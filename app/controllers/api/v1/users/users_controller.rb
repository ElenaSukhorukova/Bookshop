# frozen_string_literal: true

class Api::V1::Users::UsersController < Api::V1::ApplicationController
  before_action :store_location, only: :new

  def new
    @user = User.new
  end

  def create
    operation = Users::Creation.call(params: permit_params(:user))
    @user = operation.user

    unless operation.success?
      flash[:danger] = operation.errors.full_message

      render :new, status: :bad_request and return
    end

    redirect_back_or(root_path, info: t('.check_email'))
  end
end
