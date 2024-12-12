module Redirectable
  extend ActiveSupport::Concern

  included do
    #     def redirect_to_new_profile(user)
    #       redirect_to new_user_customer_path(user) if user.customer?
    #       redirect_to new_employee_path(user) if user.employee?
    #     end

    #     def redirect_back_or(default)
    #       binding.pry
    #       # TODO reset ???
    #       # redirect_back(fallback_location: root_path)
    #       redirect_to(session[:forwarding_url] || default)
    #       session.delete(:forwarding_url)
    #     end

    #     def store_location
    #       session[:forwarding_url] = request.url if request.get?
    #     end
  end
end
