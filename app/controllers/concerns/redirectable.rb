module Redirectable
  extend ActiveSupport::Concern

  included do
    def redirect_back_or(default, flash)
      redirect_path = session[:forwarding_url] || default

      session.delete(:forwarding_url)

      redirect_to(redirect_path, flash)
    end

    def store_location
      session[:forwarding_url] = request.url if request.get?
    end
  end
end
