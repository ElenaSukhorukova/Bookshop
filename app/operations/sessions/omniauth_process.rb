module Sessions
  class OmniauthProcess < Micro::Case
    flow Omniauth,
         Users::Activation
  end
end
