class API::RegistrationsController < Devise::RegistrationsController

  respond_to :json

  def new
    respond_with User.new
  end
end
