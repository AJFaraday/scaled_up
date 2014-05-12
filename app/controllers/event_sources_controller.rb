class EventSourcesController < ApplicationController

  def index
    @count = EventSource.count
    @event_sources = EventSource.all.order('cnt desc')
  end

  def show
    @event_source = EventSource.find(params[:id])
  end

end
