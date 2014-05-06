# TODO list!

This is a reference for things which have not yet been developed for Scaled Up^. They may, or may not, be added to the app in future.

If you are reading this and you are not Andrew Faraday, items on this list could be your contribution to Scaled Up^

* Sequence events: Users select X notes and they are played back in this order.
* Some kind of sequence where the user input is a change to one step in the event. 
* A "conductor" page, only accessible to localhost, which allows the user to activate or deactivate event profiles.
* Write a helper method for keyboard component for use in event and event profile UI.
* Write a helper method for length select component, for use in event (single) and event profile (multiple) UI
* UI to modify event profiles, note options, build sample groups etc.
* UI to show queued events.
* UI to show the sequence which has yet been played (not sure about this)
* General styling improvement, make it look like an app instead of a word document.
* More than one option for pure data patches, "audio skinning"
* Some form of stats on events, which notes/samples are chosen, who makes the most input. 
* Write some unit tests - yawn
* Write controller tests - yawn
* Write feature tests - eek

## Issues 

Pending me using a proper issue tracking system:

1. ~~Select an event profile - Change note value - click note/sample - note value reverts~~

## Player Performance 

2014-05-06 - Debugged the player to work with low-latency by keeping an array of played event messages in the Player object. Then updating these on cancelling the player.

This works but delays the pain, closing the player is slow.

My current idea for future development is to keep an attribute of 'last_message_played_id' on event_profiles and get rid of the played attribute of event_messages. Then I can just update the event_profiles on ending the player, which will be much more painless.

I have not implemented this yet because there is a demo tomorrow and I need it working for now.
