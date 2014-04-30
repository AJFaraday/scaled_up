class EventsController < ApplicationController

  before_filter :get_event, :only => [:new,:renew_form]

  def new

  end 

  def renew_form

  end 

  protected

  def get_event
    if params[:event]
      event_params = params.require(:event).permit(:source,:event_profile_id,:length,:midi_notes)
      @event = Event.new(event_params)
      @event.midi_notes = params[:event][:midi_notes].split(',').compact.uniq.collect{|x|x.to_i}
    else
      @event = Event.new
    end
    @event_profile = @event.event_profile
  end 

end
