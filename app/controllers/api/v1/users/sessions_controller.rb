# frozen_string_literal: true

class Api::V1::Users::SessionsController < Api::V1::ApplicationController
  skip_before_action :verify_authenticity_token, only: %i[omniauth]

  REMEMBER_VALUE = '1'

  before_action :store_location, only: :new

  def new
    @session = Session.new
  end

  def create # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    permited_params = permit_params(:session)

    operation = Users::Session.call(params: permited_params)

    if operation.success?
      session = operation.session
      user = session.user

      sign_in(user, user_session: session)

      permited_params[:remember_me] == REMEMBER_VALUE ? remember(user) : forget(user)

      redirect_back_or(root_path, success: t('.successful_enter')) and return
    end

    flash[:danger] = operation.errors.full_message

    render :new, status: :unauthorized
  end

  def destroy
    sign_out if signed_in?

    redirect_to root_path
  end

  def omniauth
    user = User.from_omniauth(request.env['omniauth.auth'])

    redirect_to(signin_path, danger: user.errors.full_messages.join('; ')) and return if user.new_record?

    if user.activated?
      sign_in(user)

      redirect_back_or(root_path) and return
    end

    User.transaction(isolation: :repeatable_read) do
      user.initiate_activate_process
    end

    redirect_to root_path, info: t('api.v1.users.users.create.check_email')
  end
end
