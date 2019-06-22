# frozen_string_literal: true

class ApplicationController < ActionController::Base

  def not_found
    raise ActionController::RoutingError.new('Page not found')
  end

end
