class ErrorSerializer
  def initialize(error)
    @error = error
  end

  def serialize
    { errors: { detail: @error } }
  end
end