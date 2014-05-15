class CreateEventProfileSourceStats < ActiveRecord::Migration
  def change
    execute <<-SQL
      create or replace view event_profile_source_stats as
      select 
        ep.id event_profile_id,
        e.source,
        count(e.source) cnt
      from events e
      inner join event_profiles ep on ep.id = e.event_profile_id
      group by e.source, ep.id
      order by event_profile_id asc, cnt desc
      ;
    SQL
  end
end
