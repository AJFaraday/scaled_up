class CreateEventSourceProfileStats < ActiveRecord::Migration

  def change
      execute <<-SQL
        create or replace view event_source_profile_stats as
          select 
            e.source,
            p.name,
            count(p.id) cnt
          from events e
          inner join event_profiles p
            on p.id = e.event_profile_id
          group by e.source, p.id
          order by e.source asc, cnt desc, p.name asc
        ;
      SQL
  end

end
