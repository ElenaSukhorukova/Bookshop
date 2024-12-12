module Authorization
  extend ActiveSupport::Concern

  included do
    include ActionController::Cookies

    helper_method :current_user

    private

    def sign_in(user, user_session: nil)
      user_session ||= user.create_session(session_params)

      return if user_session.blank?

      session[:session_uid] = user_session.uid
      session[:expires_in] = 24.hours
    end

    def current_user
      sign_out_by_session if session[:expires_in].present? && (session[:expires_in] - Time.zone.now).negative?

      user_session = define_user_session(session[:session_uid])

      if user_session.present? && (session_user_id = user_session.user.id)
        @current_user ||= User.find(session_user_id)
      end

      if @current_user.blank? && (cookies_user_id = cookies.signed[:user_id])
        user = User.find(cookies_user_id)

        if user.present? && user.authenticated?(:remember, cookies[:remember_token])
          sign_in(user)

          @current_user ||= user
        end
      end

      @current_user
    end

    # def signed_in?
    #   current_user.present?
    # end

    def sign_out
      forget(current_user) if current_user.present?

      sign_out_by_session

      @current_user = nil
    end

    def sign_out_by_session
      session.delete(:session_uid)
      session.delete(:expires_in)
    end

    def remember(user)
      user.remember

      binding.pry

      cookies.premanent.signed[:user_id] = user.id
      cookies.premanent[:remember_token] = user.remember_token
    end

    def forget(user)
      user.forget

      cookies.delete(:user_id)
      cookies.delete(:remember_token)
    end

    # def current_user?(user)
    #   user == current_user
    # end

    def session_params
      { uid: SecureRandom.uid }
    end

    def define_user_session(session_uid)
      Session.find_by(uid: session_uid)
    end
  end
end
