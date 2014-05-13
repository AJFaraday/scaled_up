class CreateSampleStatsView < ActiveRecord::Migration
  def change
    execute <<-SQL
      create or replace view sample_stats as
      select 
        s.name, 
        count(s.name) cnt 
      from events e 
      inner join samples s on s.id = e.sample_id
      group by s.name
      order by cnt desc
      ;
    SQL
  end
end
