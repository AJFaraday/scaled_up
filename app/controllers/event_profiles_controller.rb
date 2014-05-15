class EventProfilesController < ApplicationController

  before_action :get_event_profiles, only: [:index,:stats]
  before_action :get_event_profile, only:[:update]

  before_action :check_local_request, except:[:stats]

  def index
    
  end 

  def update
    respond_to do |format|
      format.js do
        @event_profile.toggle_active
      end
    end
  end 

  def stats

  end
  
  protected

  def get_event_profiles
    @event_profiles = EventProfile.order('port asc')
  end

  def get_event_profile
    @event_profile = EventProfile.find(params[:id])
  end

end
