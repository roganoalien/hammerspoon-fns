-- custom keybindings inside variables
hyper = { "ctrl", "cmd", "alt" }
cmd_shift = { "cmd", "shift" }
cmd_alt_shift = { "cmd", "alt", "shift" }

-- custom design warning alerts
col = hs.drawing.color.x11
hs.alert.defaultStyle.radius = 5
hs.alert.defaultStyle.fadeInDuration = 0.5
hs.alert.defaultStyle.fadeOutDuration = 0.5
hs.alert.defaultStyle.textFont = "Fira Code Bold"
hs.alert.defaultStyle.textSize = 16
hs.alert.defaultStyle.padding = 8
hs.alert.defaultStyle.fillColor = {black = 1, alpha = 0.75}
hs.alert.defaultStyle.strokeColor = {white = 1, alpha = 0.75}
hs.alert.defaultStyle.textColor = {white = 1, alpha = 0.75}
hs.alert.defaultStyle.textStyle = {paragraphStyle = {alignment = "center"}}
hs.alert.defaultStyle.atScreenEdge = 0

-- require all custom luas
require("custom-fns.autoKeyboardLayout")