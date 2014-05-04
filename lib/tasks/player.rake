require 'socket'

namespace :player do

  desc "Play through event messages at a given interval"
  task :play => :environment do
    sleep_time = System_setting.get('quaver_time')
    @event_profiles = EventProfile.all.select do |event_profile|
      event_profile.pd_connection ? true : false
    end 
    if @event_profiles.any?
      puts "#{@event_profiles.count} event profiles connected."
      puts @event_profiles.collect{|x|x.name}.inspect
      unconnected = EventProfile.all - @event_profiles
      puts "#{unconnected.count} event profiles could not connect."
      puts unconnected.collect{|x|x.name}.inspect
    else
      raise "No event profiles can make a connection!" 
    end
    # This is the important loop
    loop do
      @messages_to_play = []      
      @event_profiles.each do |event_profile|
        event_profile.get_current_event_message
      end 
      @event_profiles.each do |event_profile|        
        event_profile.play_current_event_message 
      end
      sleep sleep_time
    end 
  end

end 
