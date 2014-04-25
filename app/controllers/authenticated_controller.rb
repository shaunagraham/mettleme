# Inherit from this controller to automatically configure authentication
class AuthenticatedController < ApplicationController
  before_filter :authorize # clearance helper method
end