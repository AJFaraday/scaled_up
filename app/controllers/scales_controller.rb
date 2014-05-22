class ScalesController < ApplicationController
 
  before_action :check_local_request

  def set_current
    @scale = Scale.find(params[:id])
    @scale.update_attributes(
      current: true,
      offset: params[:offset]
    )
  end 

end
