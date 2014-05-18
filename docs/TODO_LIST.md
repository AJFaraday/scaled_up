# TODO list!

This is a reference for things which have not yet been developed for Scaled Up^. They may, or may not, be added to the app in future.

If you are reading this and you are not Andrew Faraday, items on this list could be your contribution to Scaled Up^

* Refactor event profile notes, instead have a scale with an option of only 12 notes, stamped across octaves, only one scale active at a time relevant to all note event profiles
* Sequence events: Users select X notes and they are played back in this order.
* Some kind of sequence where the user input is a change to one step in the event. 
* Write a helper method for keyboard component for use in event and event profile UI.
* Write a helper method for length select component, for use in event (single) and event profile (multiple) UI
* UI to modify event profiles, note options, build sample groups etc.
* UI to show queued events.
* UI to show the sequence which has yet been played (not sure about this)
* More than one option for pure data patches, "audio skinning"
* Write controller tests - yawn
* Write feature tests - eek
* Re-finish translations
* Work out how to block many spoofed events (see below)

## Issues 

Pending me using a proper issue tracking system:

1. ~~Select an event profile - Change note value - click note/sample - note value reverts~~

## Spoofed HTTP call event problem

During the demo at BACON 2014 the server recieved 330 identical event create calls from the same source in a short space of time. 

a: This may have contributed to the server slowing down
b: It is against the spirit of the app, which should be a democratic music collaboration tool, which can not be played by just one person.

I think this should probably involve the app adding a black-list rule to the server when it detects too many event create requests from a single source, so the rails app doesn`t process requests from that IP. Currently I don`t know a way to fix this. 
