# frozen_string_literal: true

class Api::V1::Users::SessionsController < Api::V1::ApplicationController
  # skip_before_action :verify_authenticity_token, only: %i[omniauth]

  REMEMBER_VALUE = '1'

  def new; end

  def create
    user = People::User.find_by_email(session_params[:email]&.downcase)

    if user && user.authenticate(session_params[:password])
      if user.activated?
        sign_in(user)

        session_params[:remember_me] == REMEMBER_VALUE ? remember(user) : forget(user)

        redirect_to_new_profile(user) and return if user.profile.blank?

        redirect_back_or(user) and return
      end

      user.create_activate_digest
      user.send_activation_email

      flash[:notice] = 'Your account isn\'t activated. Please check your email for the activation link.'

      redirect_to root_path and return
    end

    flash.now[:danger] = 'Invalid email or password'

    render :new, status: :unauthorized
    render json: { error: 'Invalid email or password' }, status: :unauthorized
  end

  #   def destroy
  #     sign_out if signed_in?

  #     redirect_to root_path
  #   end

  #   def omniauth
  #     user = People::User.from_omniauth(request.env['omniauth.auth'])

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

  #     redirect_to root_path and return
  #   end

  #   private

  #   def session_params
  #     params.require(:session).permit(:email, :password, :remember_me)
  #   end
end
