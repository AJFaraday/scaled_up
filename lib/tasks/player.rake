namespace :player do

  desc "Play through event messages at a given interval"
  task :play => :environment do
    @event_profile = EventProfile.all
    loop do
      @messages_to_play = []
      @event_profiles.each do |event_profile|
        @messages_to_play << @event_profiles.event_messages.unplayed.first
      end 
      @event_profiles.each_with_index do |event_profile,index|
      end
    end 
  end

end 
