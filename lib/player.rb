class Player

  attr_accessor :event_profiles
  attr_accessor :played_messages
  attr_accessor :sleep_time 

  def get_event_profiles
    self.event_profiles = EventProfile.all_with_pd_connections
  end 

  def play()
    get_event_profiles if self.event_profiles.nil? or self.event_profiles.count == 0
    self.sleep_time = SystemSetting.get('quaver_time').to_f/1000
    self.played_messages = []
    begin
      loop do
        event_profiles.each do |event_profile|
          event_profile.get_current_event_message(played_messages)
        end
        event_profiles.each do |event_profile|
          played_messages << event_profile.play_current_event_message
        end
        rescue_from_memory_fill
        sleep sleep_time
      end
    rescue Interrupt => er
      puts er.message
      self.clear_played_messages
    end
  end

  def rescue_from_memory_fill
    played_messages.compact!
    if played_messages.length > 1000
      clear_played_messages
    end 
  end 


  def clear_played_messages
    puts "Updating #{played_messages.compact.count} messages to played."
    played_messages.compact.each{|x| x.update_attribute :played, true }
    self.played_messages = []
  end

end 
