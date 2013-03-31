class IdentitiesController < ApplicationController

  def create
    @identity = Identity.create(identity_params)
    render json: @identity
  end

  private

  def identity_params
    params.require(:identity).permit(:password, :password_confirmation, :email)
  end
end