class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_error

  private

  def not_found_error
    head :not_found
  end
end
