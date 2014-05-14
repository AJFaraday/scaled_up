class EventSource < ActiveRecord::Base  

  self.primary_key = :source

  has_many :note_stats, 
           class_name: 'EventSourceNoteStat',
           foreign_key: :source, 
           primary_key: :source

  has_many :sample_stats,              
           class_name: 'EventSourceSampleStat',
           foreign_key: :source, 
           primary_key: :source

  has_many :profile_stats,
           class_name: 'EventSourceProfileStat',
           foreign_key: :source,
           primary_key: :source

  def sql_for_note(note)
    <<-SQL
      select count(*) from events_notes en
      inner join notes n on n.id = en.note_id
      inner join events e on e.id = en.event_id
      where n.name like '%#{note}%' and n.name not like '%#{note}#%'
        and e.source = '#{self.source}';
    SQL
  end

  def note_name_stats
    counts = {}
    notes = %w(A A# B C C# D D# E F F# G G#)
    notes.each do |note|
      query = sql_for_note(note)
      counts[note] = NoteStat.connection.select_all(query).rows[0][0]
    end
    counts
  end

  def note_names_bar_data
    name_stats = note_name_stats
    notes =  %w(A A# B C C# D D# E F F# G G#)
    data = {
      labels: notes,
      datasets: [
        {
          fillColor: '#FFFFFF',
          strokeColor: '#000000',
          data: notes.collect do |note|
            name_stats[note]
          end
        }
      ]
    }
    data.to_json
  end

  def sample_stats_bar_data
    stats = sample_stats.order('name asc')
    notes =  stats.collect{|x|x.name}
    data = {
      labels: notes,
      datasets: [
        {
          fillColor: '#FFFFFF',
          strokeColor: '#000000',
          data: stats.collect{|x|x.cnt}
        }
      ]
    }
    data.to_json
  end

  PIE_COLOURS = %w{
    #eeeeee
    #cccccc
    #aaaaaa
    #888888
    #666666
    #444444
    #222222
    #000000
  }

  def profile_pie_chart_data
    i = -1
    result = profile_stats.collect do |stat|
      i += 1
      {
        color: PIE_COLOURS[i % PIE_COLOURS.length],
        value: stat.cnt
      }
    end
    result.to_json
  end

end
