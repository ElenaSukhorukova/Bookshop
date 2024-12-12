# frozen_string_literal: true

class Api::V1::Users::UsersController < Api::V1::ApplicationController
  # before_action :define_user, :singed_in_user, :correct_user, only: %i[edit update destroy]
  # before_action :admin_user?, only: %i[destroy]

  CUSTOMER = 'customer'

  def new
    @user = User.new
  end

  def create
    user_params = params.permit!.to_h
    user_params = user_params[:user]&.merge(role: CUSTOMER) || {}

    operation = Users::Creation.call(params: user_params)

    unless operation.success?
      flash[:danger] = operation.errors.full_message

      render :new, status: :bad_request and return
    end

    flash[:info] = t('.check_email')

    redirect_to root_path
  end

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
end
