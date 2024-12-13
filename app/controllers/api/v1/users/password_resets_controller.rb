class Api::V1::Users::PasswordResetsController < Api::V1::ApplicationController
  #   before_action :get_user, :valid_user, :check_expiration, only: %i[edit update]

  def new; end

  #   def create
  #     binding.pry
  #     @user = User.find_by_email(params.dig(:password_reset, :email))

  #     if @user
  #       @user.create_reset_digest
  #       @user.send_password_reset_email

  #       flash[:info] = 'Email was sent with password reset instruction'

  #       redirect_to root_path and return
  #     end

  #     flash.now[:danger] = 'Email addewss was not found'
  #     render :new
  #   end

  #   def edit; end

  #   def update
  #     if @user.update(user_params)
  #       login_in @user
  #       flash[:success] = 'Password has been reset'

  #       redirect_to @user and return
  #     end

  #     if password_blank?
  #       flash.now[:danger] = 'Password can\'t be blank'
  #     end

  #     render :edit
  #   end

  #   private

  #   def get_user
  #     @user = User.find_by_email(params[:email])
  #   end

  #   def valid_user
  #     return if (@user && @user.activated? &&
  #               @user.authenticated?(:reset, params[:id]))

  #     redirect_to root_path
  #   end

  #   def check_expiration
  #     return unless @user.password_reset_expired?

  #     flash[:danger] = 'Password reset has expired'

  #     redirect_to new_password_reset_path
  #   end

  #   def user_params
  #     params.require(:user).permit(:password, :password_confirmation)
  #   end

  #   def password_blank?
  #     params.dig(:user, :password).blank?
  #   end
end
