class EventsController < ApplicationController

  before_filter :get_event, :only => [:new,:renew_form, :create]

  def new

  end 

  def renew_form

  end 

  def create
    if @event.valid?
      @event.save
      @saved = true 
      @event = @event.dup
      puts @event.inspect
    else 
      @saved = false 
    end
  end

  protected

  def get_event
    if params[:event]
      event_params = params.require(:event).permit(:source,:event_profile_id,:length)
      @event = Event.new(event_params)
      @event.midi_notes = params[:event][:midi_notes].collect{|x,y|y} if params[:event][:midi_notes]
      puts session[:source_name]
      session[:source_name] = @event.source
    else
      @event = Event.new
      @event.source = session[:source_name]
    end
    @event_profile = @event.event_profile
  end 

end