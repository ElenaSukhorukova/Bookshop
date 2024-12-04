# class Api::V1::Users::AccountActivationsController < Api::V1::ApplicationController
#   def edit
#     user = People::User.find_signed(params[:id], purpose: :activation_token)

#     if user && !user.activated? && user.authenticated?(:activation, params[:id])
#       user.activate
#       sign_in(user)

#       flash[:success] = 'Your account was activated'

#       redirect_to_new_profile(user) and return
#     end

#     flash[:danger] = 'Invalid activation link'

#     redirect_to root_path
#   end
# end
