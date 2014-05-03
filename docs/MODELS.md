# Models

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

### Relations


