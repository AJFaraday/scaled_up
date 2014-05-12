class CreateEventSourceSampleStats < ActiveRecord::Migration

  def change
      execute <<-SQL
        create or replace view event_source_sample_stats as
          select 
            e.source,
            s.name,
            count(s.name) cnt
          from events e
          inner join samples s 
            on s.id = e.sample_id
          group by e.source, s.name
          order by e.source asc, cnt desc, s.name asc
        ;
      SQL
  end

end
