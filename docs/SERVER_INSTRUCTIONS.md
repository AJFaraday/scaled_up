# Server issues 

## Audio

To start audio on current scaled_up server (ubnutu server edition):

* sudo modprobe snd-hda-intel
* pd-extended -open pd/su-simple.pd  -alsa -nogui

If there is no sound at this point, try `alsamixer`

You can also test with the test-tones patch

pd-extended -open pd/test-tones.pd  -alsa -nogui
