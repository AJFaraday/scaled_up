class StatsController < ApplicationController

  def index
    @note_count   = NoteStat.note_count
    @note_stats   = NoteStat.all.order('cnt desc')
    @sample_count = Event.where('sample_id is not null').count
    @sample_stats = SampleStat.all.order('cnt desc')
  end

end
