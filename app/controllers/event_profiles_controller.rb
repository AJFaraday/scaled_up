class EventProfilesController < ApplicationController

  before_action :get_event_profiles, only: [:index]
  before_action :get_event_profile, except:[:index]

  def index
    
  end 
  
  protected

  def get_event_profiles
    @event_profiles = EventProfile.order('port asc')
  end

  def get_event_profile
    @event_profile = EventProfile.find(params[:id])
  end

end
