# frozen_string_literal: true

class Api::V1::Users::UsersController < Api::V1::ApplicationController
  # before_action :define_user, :singed_in_user, :correct_user, only: %i[edit update destroy]
  # before_action :admin_user?, only: %i[destroy]

  before_action :store_location, only: :new

  def new
    @user = User.new
  end

  def create
    operation = Users::Creation.call(params: params.permit!.to_h[:user])
    @user = operation.user

    unless operation.success?
      flash[:danger] = operation.errors.full_message

      render :new, status: :bad_request and return
    end

    redirect_back_or(root_path, info: t('.check_email'))
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
