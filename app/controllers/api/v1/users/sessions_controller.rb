# frozen_string_literal: true

class Api::V1::Users::SessionsController < Api::V1::ApplicationController
  skip_before_action :verify_authenticity_token, only: %i[omniauth]

  REMEMBER_VALUE = '1'

  before_action :store_location, only: :new

  def new
    @session = Session.new
  end

  def create # rubocop:disable Metrics/AbcSize
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

    #     if user.new_record?
    #       flash[:warning] = user.errors.full_messages.join('; ')

    #       redirect_to signin_path and return
    #     end

    #     if user.activated?
    #       sign_in(user)

    #       if user.profile.blank?
    #         redirect_to_new_profile(user) and return
    #       end

    #       redirect_back_or(user) and return
    #     end

    #     user.create_activate_digest
    #     user.send_activation_email

    #     flash[:notice] = 'Please, check your mail to activate your account'

    redirect_to root_path
  end
end
