class Player

  attr_accessor :event_profiles
  attr_accessor :sleep_time 

  def get_event_profiles
    self.event_profiles = EventProfile.all_with_pd_connections
  end 

  def play()
    get_event_profiles if self.event_profiles.nil? or self.event_profiles.count == 0
    self.sleep_time = SystemSetting.get('quaver_time').to_f/1000
    begin
      loop do
        event_profiles.each do |event_profile|
          event_profile.get_current_event_message
        end
        event_profiles.each do |event_profile|
          event_profile.play_current_event_message
        end
        sleep sleep_time
      end
    rescue Interrupt => er
      puts er.message
      self.save_event_profiles
    end
  end

  def save_event_profiles
    self.event_profiles.each{|x|x.save}
  end

end 
