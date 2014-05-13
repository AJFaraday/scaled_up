class CreateNoteStatsViews < ActiveRecord::Migration
  def change
    # note stats, all note selections irrelevant of event profile, source or event
    execute <<-SQL
      create or replace view note_stats as 
        select 
          n.name, 
          n.midi_note, 
          count(n.name) cnt 
        from events_notes en
        inner join notes n on n.id = en.note_id
        group by n.name
        order by cnt desc;
    SQL
    
  end
end
