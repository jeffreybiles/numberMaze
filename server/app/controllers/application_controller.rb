class ApplicationController < ActionController::Base
  protect_from_forgery

  serialization_scope :view_context
end
