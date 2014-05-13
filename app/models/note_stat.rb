class NoteStat < ActiveRecord::Base

  def NoteStat.note_count
    query = <<-SQL
      select count(*) from events_notes en;
    SQL
    NoteStat.connection.select_all(query).rows[0][0]
  end

  def NoteStat.white_note_count
    query = <<-SQL
      select count(*) from events_notes en
      inner join notes n on n.id = en.note_id and n.name like '%#%';
    SQL
    NoteStat.connection.select_all(query).rows[0][0] 
  end

  def NoteStat.black_note_count
    query = <<-SQL
      select count(*) from events_notes en
      inner join notes n on n.id = en.note_id and n.name not like '%#%';
    SQL
    NoteStat.connection.select_all(query).rows[0][0]
  end

  def NoteStat.colour_stats
    {
      'Black' => NoteStat.black_note_count,
      'White' => NoteStat.white_note_count
    }
  end

end

