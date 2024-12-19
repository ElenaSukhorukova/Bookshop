class Api::V1::Users::PasswordResetsController < Api::V1::ApplicationController
  before_action :get_user, :check_expiration, only: %i[edit update]

  def new; end

  def create
    operation = Users::PasswordReset.call(params: permit_params(:password_reset))

    redirect_to(root_path, info: t('.check_email')) and return if operation.success?

    flash[:danger] = operation.errors.full_message

    render :new, status: :unprocessable_entity
  end

  def edit; end

  def update
    permitted_params = permit_params(:password_reset).merge(id: params[:id])
    operation = Users::Updation.call(params: permitted_params)

    if operation.success?
      sign_in(@user)

      redirect_to(root_path, success: t('.password_reset')) and return
    end

    flash[:danger] = operation.errors.full_message

    render :edit, status: :unprocessable_entity
  end

  private

  def get_user
    @user = User.find_by_token_for(:reset_token, params[:id])
  end

  def check_expiration
    return if @user.present?

    redirect_to new_password_reset_path, danger: t('errors.pass_reset_expired')
  end
end
