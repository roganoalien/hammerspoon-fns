# hammerspoon-fns
Custom functions that I've made that are not inside init.lua

#### Files

Files inside `./custom-fns` folder:

##### AutoKeyboardLayout
This file adds the fn that watches over active apps and passes through an array the name of those apps to see if they're whitelisted to change the layout to ENGLISH and if they do not then changes the layout to spanish only if the layout is different to the one changing, just to be extra cautious. 

As an extra, the menu icon has a submenu to toggle the listener and also expects the shortcut to work with `⌃ + ⌥ + ⌘ + k` or `control + option + command + k`. This shortcut will enable or disable the auto layout and the icon in the menu bar will be changed.