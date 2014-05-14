class NoteStat < ActiveRecord::Base

  self.primary_key = :name

  def NoteStat.note_count
    query = <<-SQL
      select count(*) from events_notes en;
    SQL
    NoteStat.connection.select_all(query).rows[0][0]
  end

  def NoteStat.white_note_count
    query = <<-SQL
      select count(*) from events_notes en
      inner join notes n on n.id = en.note_id and n.name not like '%#%';
    SQL
    NoteStat.connection.select_all(query).rows[0][0] 
  end

  def NoteStat.black_note_count
    query = <<-SQL
      select count(*) from events_notes en
      inner join notes n on n.id = en.note_id and n.name like '%#%';
    SQL
    NoteStat.connection.select_all(query).rows[0][0]
  end

  def NoteStat.colour_stats
    {
      black: NoteStat.black_note_count,
      white: NoteStat.white_note_count
    }
  end

  def NoteStat.colour_stats_pie_data
    stats = NoteStat.colour_stats
    [
      {value: stats[:black], color: '#000000'},  
      {value: stats[:white], color: '#FFFFFF'}
    ].to_json
  end

  def NoteStat.sql_for_note(note)
    <<-SQL
      select count(*) from events_notes en
      inner join notes n on n.id = en.note_id
      where n.name like '%#{note}%' and n.name not like '%#{note}#%';
    SQL
  end

  def NoteStat.note_name_stats
    counts = {}
    notes = %w(A A# B C C# D D# E F F# G G#)
    notes.each do |note|
      query = NoteStat.sql_for_note(note)
      counts[note] = NoteStat.connection.select_all(query).rows[0][0]
    end
    counts
  end 

  def NoteStat.note_names_bar_data
    name_stats = NoteStat.note_name_stats
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

end

