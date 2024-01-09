-- Import libraries
local GUI = require("GUI")
local system = require("System")
local component = require("component")
if not component.isAvailable("modem") then
  GUI.alert("This programm requies wireless modem.")
  return
end
local m = component.modem
---------------------------------------------------------------------------------
--m.open(123)
message = "Hello world"
port = 123
-- Add a new window to MineOS workspace
local workspace, window, menu = system.addWindow(GUI.filledWindow(1, 1, 60, 20, 0xE1E1E1))

-- Get localization table dependent of current system language
--local localization = system.getCurrentScriptLocalization()
--local localization = system.getLocalizations("/WirelessSender.app/Localizations/")

-- Add single cell layout to window
local layout = window:addChild(GUI.layout(1, 1, window.width, window.height, 1, 1))

window.onResize = function(newWidth, newHeight)
  window.backgroundPanel.width, window.backgroundPanel.height = newWidth, newHeight
  layout.width, layout.height = newWidth, newHeight
end

---------------------------------------------------------------------------------

local messageInput = window:addChild(GUI.input(2, 13, 20, 3, 0xEEEEEE, 0x555555, 0x999999, 0xFFFFFF, 0x2D2D2D, "Hello world", "Message"))
  --GUI.alert("Input finished!")
messageInput.onInputFinished = function()
  message = messageInput.text
end

local portInput = window:addChild(GUI.input(24, 9, 20, 3, 0xEEEEEE, 0x555555, 0x999999, 0xFFFFFF, 0x2D2D2D, 123, "Port"))
  --GUI.alert("Input finished!")
portInput.onInputFinished = function()
  port = tonumber(portInput.text)
  m.close()
end


local portIsOpenButton = window:addChild(GUI.button(2, 5, 20, 3, 0xFFFFFF, 0x555555, 0x696969, 0xFFFFFF, "Port is open?"))
portIsOpenButton.onTouch = function()
  GUI.alert(m.isOpen(port))
end
local broadcastButton = window:addChild(GUI.button(2, 9, 20, 3, 0xFFFFFF, 0x555555, 0x696969, 0xFFFFFF, "Broadcast"))
broadcastButton.onTouch = function()
  m.broadcast(port, message)
  GUI.alert(localization.broadcast)
end

local setPortButton = window:addChild(GUI.button(24, 5, 20, 3, 0xFFFFFF, 0x555555, 0x696969, 0xFFFFFF, "Set port"))
setPortButton.onTouch = function()
 --GUI.alert(m.open(port))
end


-- Draw changes on screen after customizing your window
workspace:draw()
