class UserController < Volt::ModelController
  def index
    self.model = store._users.buffer
  end
  reactive_accessor :email
  reactive_accessor :fullname

  def account
    user = Volt.user
    self.email = user._email
    self.fullname = user._name
  end
end
