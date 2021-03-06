# Models

## SystemSetting

System settings are settings which change the operation of the app in some way. 

They are initially defined in config/system_settings.yml and created in db/seeds.rb

### Attributes

|Attribute | Description |
|----------|-------------|
| name     | the internally used name of this setting |
|display_name| The name for this setting which is shown to the user |
| description | a brief description of what this setting does | 
| default  | The initial value of this setting on intialising the database |
| value | The current value of this attribute, it may have been changed since database creation| 
| value_class | the class of ruby object this value should be. Options "integer", "float", "string" | 


## EventProfile

An event profile serves two main purposes:

* Definition of the Event form when this profile is selected
* Definition of where events will be sent to via UDP.

Note: They are currently only created via db/seed.rb

### Attributes

|Attribute | Description |
|----------|-------------|
|Name| A display name to identify profile. Used in Event form. |
|no_of_notes| Number of notes to be played simultaneosly |
| min_note | Lowest midi note possible. Used for generating event form |
| max_note | Highest midi notes possible. Used to generate event form | 
| ip_address | IP address with which to connect to Pure Data, almost always going to be localhost (127.0.0.1) |
| port | an IP port to connect to Pure Data. Should conform to mappings in docs/PD-CONNECTIONS.pd | 

### Relations

|   Model   |   Type   | Purpose                         |
|-----------|----------|---------------------------------|
| SampleGroup| belongs_to | If one is defined samples in that group are shown in the new event form |
| Sample    | has_many (through SampleGroup | Samples which appear on new event form |
| Event     | has_many | Created from Event Profile, and event is sent via a profile | 
| Note      | has_and_belongs_to_many | A list of note options for this profile, used to generate event form | 
| Length    | has_and_belongs_to_many | These are the options for the length of an event, used to generate event form |
| Length    | belongs_to (default_length)| The default length for events created from this profile |

## SampleGroup 

As the name suggests, a group of samples. Defines the samples available for an EventProfile.

Note: Currently only created via db/seed.rb

### Attributes

|Attribute | Description |
|----------|-------------|
| name     | An identifying name for a sample group, currently unused| 

### Relations
 
|   Model   |   Type   | Purpose                         |
|-----------|----------|---------------------------------|
|EventProfile|has_many | This sample group is used to generate the event form for these event profiles | 
|Sample     | has_many | These samples are together under this group. They are the options in the event form. | 


## Sample

A reference to a sound which Pure Data can make and knows by name. 

Used to generated event form and to geneate messages for Pure Data.

Names of samples here should have an eqivalent auido file for Pure Data to read. For the initial, simple Pure Data patch the similarly-named samples are in /pd/simple/audio/

### Attributes

|Attribute | Description |
|----------|-------------|
|   name   | The name of an audio file this sample refers to. For instance, if this says 'kick', on the simple Pure Data patch it refers to /pd/simple/audio/kick.wav |
| display_name | The name shown to a user on the event form |

### Relations

|   Model   |   Type   | Purpose                         |
|-----------|----------|---------------------------------|
|SampleGroup|belongs_to| A group under which this is grouped, the main link to an EventProfile |
|Event      |has_many  | Events which are this sample, this sample record is used to create an event message | 


## Length

A potential length for an event, described as musical note values. Includes a reference to an image of that length. 

Because the app currently uses steps of a quaver, this can not support smaller note values than that. To change this minimum change quaver to semiquaver across the app, change the seeds for length, and shorten the step time in /config/system_settings.yml

Currently (and only ever) created via db/seeds.rb

### Attributes

|Attribute | Description |
|----------|-------------|
| name     | The actual name of this note value |
| steps    | The number of steps (quavers) in this length |
| image    | The file name of an image of this note value (e.g. 'crotchet.png')

### Relations

|   Model   |   Type   | Purpose                         |
|-----------|----------|---------------------------------|
| Event     | has_many | That event is this length       |
| EventProfile| has_and_belongs_to_many | This is one of the options for events with that profile | 
| EventProfile| has_many (default_length) (not implemented) | This is the default length for that event profile, but the length does not need to know that, so this relation is not in the model. |  

## Note

A static lookup of note names against midi notes (standard reference for absolute pitches in western music, used for a lot of music technology). 

This is currently, and only ever will be, only generated by db/seed.rb

### Attributes

|Attribute | Description |
|----------|-------------|
| name     | Standard note name displayed to user, consisting of a note name (C, C#, D, etc.) and an octave number |
| midi_note| The midi note which is passed to Pure Data whenever this note is sent |

### Relations

|   Model    |   Type   | Purpose                         |
|------------|----------|---------------------------------|
|EventProfile|has_and_belongs_to_many| This note is an option when that event profile is selected | 
|Event       |has_and_belongs_to_many|This note is part of that event, either simultaneous with the others or consecutively (not yet implemented)


## Event

The actual user input to the synthesizer, this is the object of the main user input form (New Event Form) and is used to create Event Messages. 

This is primarily focussed on interface with the user, not setup or interface with the synth.

### Attributes

|Attribute | Description |
|----------|-------------|
|source    | The name of the user making this event, mostly required for interest. In demos users will see their name on the readout |
| steps    | Amount of steps which this event will take place for, this causes the player to pause this event profile for that many steps and makes the synth make a note for this amount of time |

### Relations

|   Model   |   Type   | Purpose                         |
|-----------|----------|---------------------------------|
|EventProfile|belongs_to| The event profile is used to define the form for this event, and to denote which port this will be sent to by the player |
|EventMessage|has_one| This holds the correctly formatted message for Pure Data and is directly connected to the Event Profile. This is the table actually polled to play this event. |
| Note      | has_and_belongs_to_many| The midi notes which will be produced when this event is played, simultaneously or consecutively (not yet implemented) |
| Sample | belongs_to | The sample which will be sounded when this event is played |
| Length | belongs_to | The length of this event, used as a lookup for steps |

## EventMessage

The formatted message to be played by pure data. This is the table polled by the player.

### Attributes

|Attribute | Description |
|----------|-------------|
| content  | Formatted message to be passed to sequencer |
| played   | a boolean which is set to true when the player plays this message | 
| display_message | A formatted message to be output to the console allowing users to see what is happening and who asked for it. |
| steps    | From the event, the number of steps this event will take |


### Relations

|   Model   |   Type   | Purpose                         |
|-----------|----------|---------------------------------|



(Template for new models)
 
## ModelName

A short description of this class and what it actually does.

### Attributes

|Attribute | Description |
|----------|-------------|


### Relations

|   Model   |   Type   | Purpose                         |
|-----------|----------|---------------------------------|
 
