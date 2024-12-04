module Authorization
  extend ActiveSupport::Concern

  included do
    include ActionController::Cookies

    helper_method :current_user

    private

    def sign_in(user)
      session[:user_id] = user.id
    end

    def current_user
      if (session_user_id = session[:user_id])
        @current_user ||= People::User.find(session_user_id)
      end

      if (cookies_user_id = cookies.signed[:user_id])
        user = People::User.find(cookies_user_id)

        if user && user.authenticated?(:remember, cookies[:remember_token])
          sign_in(user)
          @current_user = user
        end
      end

      @current_user
    end

    def signed_in?
      current_user.present?
    end

    def sign_out
      forget(current_user)
      session.delete(:user_id)
      @current_user = nil
    end

    def remember(user)
      user.remember
      cookies.premanent.signed[:user_id] = user.id
      cookies.premanent[:remember_token] = user.remember_token
    end

    def forget(user)
      user.forget
      cookies.delete(:user_id)
      cookies.delete(:remember_token)
    end

    def current_user?(user)
      user == current_user
    end
  end
end
