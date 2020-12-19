class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create, :destroy]

  def create
  end

  def destroy
  end
end
