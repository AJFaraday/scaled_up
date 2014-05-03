# Connecting to Pure Data

The Scaled UP^ player feeds input to Pure Data via a number of ports. 

The EventProfile for each Event defines which IP address and port that event is sent to.

The EventMessage model and contains the actual message to pass to Pure Data.

# Port Mappings 

Because the player works on each EventProfile in isolation, and most of the recieving patches only receive a limited amount of input at once, whether or not you event profiles point to the same port is significant: 

* If they share a port, they may send data simultaneously. If the patch does not support this, some notes may go missing.
* If they do not share a port, the sound may happen simultaneously.

There is a hope that the Pure Data patch could be expanded or substitued for a different one without breaking the player or rendering Event Profiles useless. It is wise, therefore, to keep the meanings of IP ports the same across the application. 

This is the current guide:

|Range       | Name         | Description                                     |
|9900 - 9909 | Bass         | Monophonic synth, sounds good at lower pitches. | 
|9910 - 9919 | Treble       | Monophonic synth, sounds good at higher pitches.|
|9920 - 9929 | Chord        | Synths designed to handle multiple voices.      |
|9930 - 9939 | Samples      | Accepts sample names, used for drums or other sounds. Samples ususally stored in /pd/*theme name*/audio/*.wav |

Pure data patches do not necessarily respond to all ports within ranges. But should respond at least to the ports ending in zero.
