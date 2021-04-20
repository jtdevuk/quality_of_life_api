class ApplicationController < ActionController::Base
  # filter for devise's built in authentication check to run before any controller action
  before_action :authenticate_user!
end
