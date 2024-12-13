class Api::V1::Users::AccountActivationsController < Api::V1::ApplicationController
  def edit
    user = User.find_by_token_for(:activation_token, params[:id])

    if user.present? && !user.activated? &&
       user.authenticated?(:activation, params[:id])

      user.activate

      sign_in(user)

      redirect_to(new_user_profile_path(user), success: t('.activated')) and return
    end

    redirect_to root_path, danger: t('.activation_error', period: count_period(user))
  end

  private

  def count_period(user)
    return if user.blank?

    15.minutes - (Time.zone.now - user.created_at).ceil.minutes
  end
end
