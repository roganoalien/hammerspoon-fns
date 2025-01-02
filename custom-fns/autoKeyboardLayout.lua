-- sets icon PNG inside variables
local keyChangeBlockedEN = hs.image.imageFromPath("../icons/AutoKeyBLOCKEDEN.png")
local keyChangeBlockedES = hs.image.imageFromPath("../icons/AutoKeyBLOCKEDES.png")
local keyChangeEnglish = hs.image.imageFromPath("../icons/AutoKeyEN.png")
local keyChangeSpanish = hs.image.imageFromPath("../icons/AutoKeyES.png")
-- global variable that allows/prevents auto layout change
local stopKeyboardChange = false
local currentIcon = nil
-- creates the global menubar menu
keyboardChangerStatus = hs.menubar.new(true, "keyboardChangerStatus")

-- fn that sets the menu icon, receives boolean to know if the icon should be a locked one or not
local function setsMenuIcon(isBlocked)
	local currentLayout = hs.keycodes.currentLayout()
	if currentLayout == "ABC" then
		print("IS ENGLISH")
		if isBlocked then
			currentIcon = keyChangeBlockedEN
		else
			currentIcon = keyChangeEnglish
		end
	else
		print("IS SPANISH")
		if isBlocked then
			currentIcon = keyChangeBlockedES
		else
			print("NO ESTá BLOQUEADO")
			currentIcon = keyChangeSpanish
		end
	end
	print(currentIcon)
	keyboardChangerStatus:setIcon(currentIcon, true)
end

-- fn that locks or unlocks the auto layout change
local function changeKeyboardLayout()
	if stopKeyboardChange then
		stopKeyboardChange = not stopKeyboardChange
		setsMenuIcon(false)
		hs.notify.new({title="Keyboard Layout Listener", informativeText="unlocked"}):send()
	else
		stopKeyboardChange = not stopKeyboardChange
		setsMenuIcon(true)
		hs.notify.new({title="Keyboard Layout Listener", informativeText="locked"}):send()
	end
end

-- fn that calls the setsMenuIcon fn but knowing if it should be locked
local function callSetMenu()
	setsMenuIcon(stopKeyboardChange)
end

-- Listener for keyboard changes, changes after user stops pressing keys for the shortcut
hs.keycodes.inputSourceChanged(callSetMenu)

local function isAppAllowed(appName)
	local allowedApps = {"Code", "iTerm2", "WarpTerminal", "WezTerm", "Ghostty"}
	for _, app in ipairs(allowedApps) do
		if appName == app then
			return true
		end
	end
	return false
end

-- IF APP MATCHES CHANGES KEYBOARD LAYOUT TO ENGLISH AND IF NOT CHANGES TO SPANISH
hs.window.filter.default:subscribe(hs.window.filter.windowFocused, function(window, appName)
	if not stopKeyboardChange then
		local current = hs.keycodes.currentLayout()

		if not isAppAllowed(appName) then
			if (current ~= "Latin American") then
				hs.alert.closeAll()
				hs.alert.show("Español", nil, hs.screen.allScreens(), 1)
				hs.keycodes.setLayout("Latin American")
			end
		else
			if(current ~= "ABC") then
				hs.alert.closeAll()
				hs.alert.show("English", nil, hs.screen.allScreens(), 1)
				hs.keycodes.setLayout("ABC")
			end
		end
	end
end)

-- sets keyboard shortcut to disabled auto layout
hs.hotkey.bind({ "ctrl", "cmd", "alt" }, 'k', changeKeyboardLayout)
-- sets menu icon
setsMenuIcon(false)
-- sets menu items
keyboardChangerStatus:setMenu({
	{ title = "Toggle listener", fn = changeKeyboardLayout },
	{ title = "-" },
})