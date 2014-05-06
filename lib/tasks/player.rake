require 'socket'
require "#{Rails.root}/lib/player.rb"

namespace :player do

  desc "Play through event messages at a given interval"
  task :play => :environment do
    Player.new.play
  end

  desc "Crazy mode! Play all events in database irrelevant of previous playing"
  task :play_all => :environment do
    EventMessage.where(:played => true).each{|x|x.update_attribute :played, false}
    Player.new.play
  end

end 
