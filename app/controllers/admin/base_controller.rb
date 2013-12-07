class Admin::BaseController < ApplicationController
    
  before_action :authorize

end