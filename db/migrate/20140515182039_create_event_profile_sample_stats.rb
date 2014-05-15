class CreateEventProfileSampleStats < ActiveRecord::Migration
  def change
    execute <<-SQL
      create or replace view event_profile_sample_stats as
      select 
        ep.id event_profile_id, 
        s.id sample_id,
        s.name sample_name, 
        count(e.id) cnt 
      from samples s 
      inner join sample_groups sg on s.sample_group_id = sg.id
      inner join event_profiles ep on ep.sample_group_id = sg.id
      left outer join events e on e.sample_id = s.id 
      group by s.name
      order by ep.id desc, cnt desc
      ;
    SQL

  end
end
