class Api::V1::Users::ProfilesController < Api::V1::ApplicationController
  #   before_action :define_user

  def new
    #     @profile = People::Profile.new(profilable: People::Customer.new, user: @user)
    #     authorize(@profile)
  end

  #   # def create; end
  #   # def edit; end
  #   # def update; end
  #   # def destroy; end

  #   private

  #   def define_user
  #     @user = current_user
  #   end

  #   def profile_params
  #     params.require(:profile).permit(:birth_day, :first_name, :last_name, :phone, :terms_of_service)
  #   end
end
