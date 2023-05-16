class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def render_unprocessable_entity_response(exception)
    render json: { errors: exception.record.errors }, status: :render_unprocessable_entity
  end

  def render_not_found_response(exception)
    render json: { errors: exception.message }, status: :not_found
  end
end
