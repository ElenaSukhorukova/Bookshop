class Api::V1::Users::AccountActivationsController < Api::V1::ApplicationController
  def edit
    user = User.find_signed(params[:id], purpose: :activation_token)

    binding.pry
    if user.present? && !user.activated? &&
       user.authenticated?(:activation, params[:id])

      binding.pry

      user.activate

      sign_in(user)

      flash[:success] = t('.activated')

      redirect_to_new_profile(user) and return
    end

    flash[:danger] = t('.error')

    redirect_to root_path
  end
end
