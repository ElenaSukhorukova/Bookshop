class Api::V1::Users::AccountActivationsController < Api::V1::ApplicationController
  def edit
    user = User.find_signed(params[:id], purpose: :activation_token)

    if user.present? && !user.activated? &&
       user.authenticated?(:activation, params[:id])

      user.activate

      sign_in(user)

      flash[:success] = t('.activated')

      redirect_to_new_profile(user) and return
    end

    flash[:danger] = t('.activation_error', period: count_period(user))

    redirect_to root_path
  end

  private

  def count_period(user)
    return if user.blank?

    (Time.zone.now - user.created_at).ceil
  end
end
