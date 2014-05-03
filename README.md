# Scaled Up^

A social experiment in collaborative musicianship.

Basically, it is a web interface for multiple people to send control input to the same synthesiser. This is then read back in the order it arrived and played by the synth with an enforced rhythm.

# Components

* Web Server - Ruby on Rails webserver which provides a simple interface for users to input notes or samples. 
* Player - A Rake task which reads the database of user input, oldest first, and outputs it to the Synthesizer
* Synthesizer - A Pure Data patch which receives UPD messages from the player and produces sound. 

# Prerequisites

* Ruby 2.1.1 (www.ruby-lang.org) 
* RubyGems 
* Rails 4.1.0 (`gem install rails -v 4.1.0`)
* Pure Data (www.puredata.info/downloads)
* MySQL or another database (but not SQLite)

# Installation

* `git clone https://github.com/AJFaraday/scaled_up.git`
* bundle install
* (Modify config/database.yml if required)
* `rake db:setup`

# Operation

(from the root directory of Scaled Up^)

* `rails s`
* Open Pure Data and open any file from pd beginning with su- and ending with .pd:
** su-diagnostic.pd: This will make no sound, just show incoming signals from the player.
** su-simple.pd: A simple set of sounds, the first attempt at making sounds with pd.
* `rake player:play`


