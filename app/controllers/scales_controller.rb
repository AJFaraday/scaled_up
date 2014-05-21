class ScalesController < ApplicationController
 
  before_action :check_local_requset

  def set_current
    @scale = Scale.find(params[:id])
    @scale.update_attribute :current, true
  end 

end
