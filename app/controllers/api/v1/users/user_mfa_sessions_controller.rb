class UserMfaSessionsController < ApplicationController
  skip_before_action :check_mfa, only: %i[new create]

  def new; end

  def create
    binding.pry
    user = current_user
    user.mfa_secret = params[:mfa_code]
    user.save!

    if user.google_authentic?(params[:mfa_code])
      UserMfaSession.create(user)
      redirect_to root_path
    else
      flash.now[:danger] = 'Invalid code'
      render :new
    end
  end
end
