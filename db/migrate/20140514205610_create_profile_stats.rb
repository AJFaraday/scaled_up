class CreateProfileStats < ActiveRecord::Migration

  def change
      execute <<-SQL
        create or replace view profile_stats as
          select 
            p.name,
            count(p.id) cnt
          from events e
          inner join event_profiles p
            on p.id = e.event_profile_id
          group by p.id
          order by cnt desc
        ;
      SQL
  end

end
