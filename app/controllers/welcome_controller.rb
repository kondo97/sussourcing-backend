class WelcomeController < ApplicationController
  def index
    render json: { status: 'SUCCESS2', message: 'hello world2' }
  end
end