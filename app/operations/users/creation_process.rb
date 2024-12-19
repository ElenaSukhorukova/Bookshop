module Users
  class CreationProcess < Micro::Case
    flow CreatedUser,
         Activation
  end
end
