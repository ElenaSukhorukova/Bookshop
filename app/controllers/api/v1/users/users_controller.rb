# class Api::V1::Users::UsersController < Api::V1::ApplicationController
#   # before_action :define_user, :singed_in_user, :correct_user, only: %i[edit update destroy]
#   # before_action :admin_user?, only: %i[destroy]

#   def new
#     @user = People::User.new
#   end

#   def create
#     @user = People::User.new(user_params)

#     if @user.save
#       @user.send_activation_email

#       flash[:info] = 'Please, check your mail to activate your account'

#       redirect_to root_path and return
#     end

#     render :new, status: :bad_request
#   end

#   # def edit; end

#   # def update; end

#   private

#   # def define_user
#   #   @user = User.find(params[:id])
#   # end

#   # def singed_in_user
#   #   return if signed_in?

#   #   store_location
#   #   # flash[:danger]
#   #   # redirect_to
#   # end

#   # def correct_user
#   #   return if current_user?(@user)

#   #   # redirect_to
#   # end

#   # TODO use pandit policies
#   # def admin_user?
#   #   employee = @user.profile.employee

#   #   return if employee.sys_admin? || current_user?(@user)

#   #   redirect_to root_path
#   # end

#   def user_params
#     params.require(:people_user).permit(:email, :password, :password_confirmation)
#   end
# end