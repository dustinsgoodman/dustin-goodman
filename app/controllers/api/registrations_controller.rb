class API::RegistrationsController < Devise::RegistrationsController

  respond_to :json

  def new
    respond_with User.new
  end

  def create
    @user = User.create(user_params)
    respond_with @user, location: nil
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end
end
