class CreateEventSources < ActiveRecord::Migration
  def change
    execute <<-SQL
      create or replace view event_sources as
      select source, count(id) cnt from events group by source order by source asc;
    SQL
  end
end
