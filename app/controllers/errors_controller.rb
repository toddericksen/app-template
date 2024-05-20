class ErrorsController < ApplicationController
  layout 'application'
  def not_found
    render status: 404
  end

  def internal_server
    render status: 500
  end

  def unprocessable
    render status: 422
  end

  def unacceptable
    render status: 406
  end

  def unauthorized
    render status: 401
  end
end
