class CreateEventSourceNoteStats < ActiveRecord::Migration

  def change
      execute <<-SQL
        create or replace view event_source_note_stats as
          select 
            e.source,
            n.name,
            n.midi_note,
            count(n.name) cnt
          from events e
          inner join events_notes en 
            on en.event_id = e.id
          inner join notes n 
            on n.id = en.note_id
          group by e.source, n.name
          order by e.source asc, cnt desc, n.midi_note asc
        ;
      SQL
  end

end
