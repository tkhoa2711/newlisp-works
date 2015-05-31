#!/usr/bin/env newlisp

; create a color mixer UI in newlisp
; example taken from this wikibook
; http://en.wikibooks.org/wiki/Introduction_to_newLISP/Graphical_interface

(load (append (env "NEWLISPDIR") "/guiserver.lsp"))

(gs:init)

; layout of the main frame Mixer
(gs:frame 'Mixer 200 200 400 300 "Mixer")
(gs:set-resizable 'Mixer nil)
(gs:set-border-layout 'Mixer)

; layout of the panel for sliders
(gs:panel 'SliderPanel)
(gs:set-grid-layout 'SliderPanel 3 1)

; define the slider panel with its components
(gs:panel  'RedPanel)
(gs:panel  'GreenPanel)
(gs:panel  'BluePanel)
 
(gs:label  'Red   "Red"   "left" 50 10 )
(gs:label  'Green "Green" "left" 50 10 )
(gs:label  'Blue  "Blue"  "left" 50 10 )
 
(gs:slider 'RedSlider   'slider-handler "horizontal" 0 100 0)
(gs:slider 'GreenSlider 'slider-handler "horizontal" 0 100 0)
(gs:slider 'BlueSlider  'slider-handler "horizontal" 0 100 0)
 
(gs:label  'RedSliderStatus   "0"  "right" 50 10)
(gs:label  'GreenSliderStatus "0"  "right" 50 10)
(gs:label  'BlueSliderStatus  "0"  "right" 50 10)

; add the components to the slider panel
(gs:add-to 'RedPanel 'Red 'RedSlider 'RedSliderStatus) 
(gs:add-to 'GreenPanel 'Green 'GreenSlider 'GreenSliderStatus)
(gs:add-to 'BluePanel 'Blue 'BlueSlider 'BlueSliderStatus)
 
(gs:add-to 'SliderPanel 'RedPanel 'GreenPanel 'BluePanel)

; the Swatch holding a canvas to show the color
(gs:canvas 'Swatch)
 
(gs:label 'Value "")
(gs:set-font 'Value "Sans Serif" 16)

; add the 3 main components to the main frame
(gs:add-to 'Mixer 'SliderPanel "north" 'Swatch "center" 'Value "south")

; initialization
(gs:set-visible 'Mixer true)
(set 'red 0 'green 0 'blue 0)
(gs:set-color 'Swatch (list red green blue))
(gs:set-text  'Value (string (list red green blue)))

; handler for the slider
(define (slider-handler id value)
  (cond 
     ((= id "MAIN:RedSlider") 
        (set 'red (div value 100))
        (gs:set-text 'RedSliderStatus (string red)))
     ((= id "MAIN:GreenSlider") 
       (set 'green (div value 100))
        (gs:set-text 'GreenSliderStatus (string green)))
     ((= id "MAIN:BlueSlider") 
       (set 'blue (div value 100))
       (gs:set-text 'BlueSliderStatus (string blue)))
     )
  (gs:set-color 'Swatch (list red green blue))
  (gs:set-text  'Value (string (list red green blue))))

; start listening to events and dispatching them to the handlers
(gs:listen)
