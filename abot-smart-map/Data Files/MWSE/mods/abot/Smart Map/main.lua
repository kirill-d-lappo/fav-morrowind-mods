--[[
Try some smart auto-switch between local and world map /abot
--]]

-- begin configurable parameters

local defaultConfig = {
onEnteringInteriors = true, -- Allow changing map display when entering interior cells
onCrossingExteriors = true, -- Allow changing map display when crossing exterior cells
minExteriorCellLinkedDoorsForLocalMap = 4, -- Minimum number of linked doors in exterior to consider worth displaying the local map
}
local tk = {} -- why it must be so hard to keep things in order...
tk[1] = 'onEnteringInteriors'
tk[2] = 'onCrossingExteriors'
tk[3] = 'minExteriorCellLinkedDoorsForLocalMap'

-- end configurable parameters

-- begin translation

function loadTranslation()
	-- Get the ISO language code.
	local language = tes3.getLanguage()

	-- Load the dictionaries, and start off with English.
	local dictionaries = require("abot.Smart Map.translations")
	-- Intentionally apply rus translation - tes3.getLanguage() doesn't return correct lang for russian
	local dictionary = dictionaries["rus"]

	-- If we aren't doing English, copy over translated entries.
	if (language ~= "eng" and dictionaries[language]) then
		table.copy(dictionaries[language], dictionary)
	end

	-- Set the dictionary.
	return dictionary
end

local text = loadTranslation()

-- end translation

local author = 'abot'
local modName = 'Smart Map'
local modPrefix = author .. '/'.. modName
local configName = author .. modName
configName = string.gsub(configName, ' ', '_') -- replace spaces with underscores

local lib = require(author .. '.lib')

-- http://dkolf.de/src/dkjson-lua.fsl/wiki?name=Documentation
local config = mwse.loadConfig(configName)
if not config then
	config = table.copy(defaultConfig)
	mwse.log("%s config restored to default", modPrefix)
	lib.logConfig(config, {indent = true, keyorder = tk})
end

local mcm = require(author .. '.' .. modName .. '.mcm')
mcm.config = table.copy(config)

local function modConfigReady()
	mwse.registerModConfig(text.extensionModListName, mcm)
	mwse.log(modPrefix .. " modConfigReady")
	lib.logConfig(config, {keyorder = tk})
end
event.register('modConfigReady', modConfigReady)

function mcm.onClose()
	config = table.copy(mcm.config)
	lib.saveConfig(configName, config, {keyorder = tk})
end

--[[
function lib.resetConfig() -- overriden
	config = table.copy(defaultConfig)
	mcm.config = table.copy(defaultConfig)
end
--]]

local GUIID_MenuMap = tes3ui.registerID('MenuMap')
local MenuMap_world = tes3ui.registerID('MenuMap_world')
local MenuMap_local = tes3ui.registerID('MenuMap_local')
local MenuMap_switch = tes3ui.registerID('MenuMap_switch')

--- local mapMenu -- nope fucking thing is hard to cache as it may be valid/invalid/not ready on loaded
local interior
local severalExteriorLinkedDoors

--  note uiActivated may trigger before loaded event, so better to set cached pointers from both events
local function uiActivated(e)
	local mapMenu = e.element
	interior = nil
	severalExteriorLinkedDoors = nil
	---lastInterior = nil
	---mwse.log("%s: 2 uiActivated mapMenu = %s", modPrefix, mapMenu)
	if not mapMenu then
		assert(mapMenu)
	end
	local switchButton = mapMenu:findChild(MenuMap_switch)
	if not switchButton then
		assert(switchButton)
		return
	end
	--[[mapMenu:register('keyEnter', function()
		switchButton:triggerEvent('mouseClick')
	end)--]]

end

local function loaded()
	interior = nil -- this is less of a problem as it is updated in cellChanged
	severalExteriorLinkedDoors = nil
end

local function updateMap()

	---mwse.log("%s: updateMap()", modPrefix)
	local mapMenu = tes3ui.findMenu(GUIID_MenuMap)

	if not mapMenu then
		-- assert(mapMenu) -- it may happen!
		---mwse.log("%s: updateMap mapMenu = %s", modPrefix, mapMenu)
		return
	end
	if not mapMenu.visible then
		---mwse.log("%s: updateMap mapMenu.visible = %s", modPrefix, mapMenu.visible)
		--return -- skipping return as this way it should work even when not pinned
	end
	if mapMenu.disabled then
		---mwse.log("%s: updateMap mapMenu.disabled = %s", modPrefix, mapMenu.disabled)
		--return
	end
	local worldMap = mapMenu:findChild(MenuMap_world)
	if not worldMap then
		---assert(worldMap) -- it happens!
		return
	end
	local localMap = mapMenu:findChild(MenuMap_local)
	if not localMap then
		assert(localMap)
		return
	end
	local switchButton = mapMenu:findChild(MenuMap_switch)
	if not switchButton then
		assert(switchButton)
		return
	end

	---mwse.log("%s: 4 updateMap interior = %s, severalExteriorLinkedDoors = %s, localMap.visible = %s", modPrefix, interior, severalExteriorLinkedDoors, localMap.visible)

	if interior then
		if localMap.visible then
			return -- local map already visible in interior cell, always worth, return
		end
	else -- exterior cell
		if localMap.visible then
			if severalExteriorLinkedDoors then
				return -- local map already visible in doors filled exterior cell, return
			end
		elseif not severalExteriorLinkedDoors then
			return -- world map already visible in exterior cell, not a lot of doors, return
		end
	end

	-- else switch
	switchButton:triggerEvent('mouseClick')

	---local playerCell = tes3.getPlayerCell()
	---if playerCell then
		---if interior then
			---mwse.log("%s: switched to %s Local Map", modPrefix, playerCell)
		---else
			---mwse.log("%s: switched to %s World Map", modPrefix, playerCell)
		---end
	---end
end

local DOORTYPE = tes3.objectType.door

local function getLinkedDoorsCount(cell)
	local i = 0
	local m = config.minExteriorCellLinkedDoorsForLocalMap

	for linkedDoorRef in tes3.iterate(cell.activators) do
		if not linkedDoorRef.disabled then
			if not linkedDoorRef.deleted then
				local linkedDoorObj = linkedDoorRef.object
				if linkedDoorObj then
					if linkedDoorObj.objectType == DOORTYPE then
						if linkedDoorRef.destination then
							i = i + 1
							if i >= m then
								break
							end
						end -- if linkedDoorRef.destination
					end -- if linkedDoorObj.objectType
				end -- if linkedDoorObj
			end -- if not linkedDoorRef.deleted
		end -- if not linkedDoorRef.disabled
	end -- for linkedDoorRef
	return i
end

local function cellChanged(e)

	---mwse.log("%s: cellChanged", modPrefix)

	local mapMenu = tes3ui.findMenu(GUIID_MenuMap)

	--[[
	if mapMenu then
		mwse.log("%s: cellChanged mapMenu %s mapMenu.visible %s", modPrefix, mapMenu, mapMenu.visible)
	else
		mwse.log("%s: cellChanged mapMenu %s", modPrefix, mapMenu)
	end
	--]]
	if not mapMenu then
		return
	end

	if not mapMenu.visible then
		--return
	end

	interior = e.cell.isInterior

	---mwse.log("%s: 3 cellChanged interior = %s", modPrefix, interior)

	severalExteriorLinkedDoors = false

	if interior then
		if config.onEnteringInteriors then
			---if not e.cell.behavesAsExterior then
			updateMap()
			---end
		end
		return
	end

	-- exterior cell
	if not config.onCrossingExteriors then
		return -- skip disallowed exterior changes
	end

	if lib.isPlayerMovingFast() then
		return
	end

	if lib.isPlayerScenicTraveling() then
		return
	end

	local linkedDoorsCount = getLinkedDoorsCount(e.cell)
	--- mwse.log("%s: 3 cellChanged linkeDoorsCount = %s", modPrefix, linkedDoorsCount)
	if linkedDoorsCount >= config.minExteriorCellLinkedDoorsForLocalMap then
		severalExteriorLinkedDoors = true
	end

	timer.delayOneFrame(updateMap)

end

local function initialized()
	event.register('uiActivated', uiActivated, {filter = 'MenuMap'})
	event.register('loaded', loaded)
	event.register('cellChanged', cellChanged)
	local s = string.format("%s: initialized", modPrefix)
	mwse.log(s)
	---tes3.messageBox(s)
end
event.register('initialized', initialized)
