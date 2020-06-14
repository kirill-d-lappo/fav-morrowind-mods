-- Essential Indicators

local defaultConfig = {
	messages = true,
	autoHide = false,
	ownershipTarget = true,
	npcTarget = true,
	itemTarget = true,
	essentialTooltip = true,
	crosshairScale = 100,
	indicatorScale = 100,
	useTex = false,

	npcVanilla = true,
	npcExtended = true,
	essentialsInvincible = false,
	noEssentials = false,
}

-- Translations

function loadTranslation()
	-- Get the ISO language code.
	local language = tes3.getLanguage()

	-- Load the dictionaries, and start off with English.
	local dictionaries = require("Essential Indicators.translations")
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

local data = require("Essential Indicators.data")

local config = mwse.loadConfig("Essential Indicators", defaultConfig)

local function essentialSwitch()
	for ref in tes3.getPlayerCell():iterateReferences(tes3.objectType.actor) do
		if ref == nil then
			return
		end

		if config.npcVanilla then
			local npc = data.vanillaTable[ref.baseObject.id:lower()]
			if config.noEssentials and npc then
				ref.baseObject.essential = false
			elseif not config.noEssentials and npc then
				local entry = tes3.getJournalIndex{ id = (npc.entry) }
				local index = npc.index
				if ((entry < index) or (entry == nil)) then
					ref.baseObject.essential = true
				elseif (entry >= index) then
					ref.baseObject.essential = false
					end
			end
		end

		if config.npcExtended then
			local npc = data.extendedTable[ref.baseObject.id:lower()]
			if config.noEssentials and npc then
				ref.baseObject.essential = false
			elseif not config.noEssentials and npc then
				local entry = tes3.getJournalIndex{ id = (npc.entry) }
				local index = npc.index
				if ((entry < index) or (entry == nil)) then
					ref.baseObject.essential = true
				elseif (entry >= index) then
					ref.baseObject.essential = false
				end
			end
		end
	end
end

local function onDamage(e)
	if config.essentialsInvincible then
		if (e.reference.baseObject.essential == true) then
			local newFatigue = (e.reference.mobile.fatigue.current - e.damage)
			tes3.setStatistic{ reference = e.reference.mobile, name = "fatigue", current = newFatigue }
			e.damage = 0
			if config.messages then
				tes3.messageBox(text.essentialCharacterWarning)
			end
		end
	end
end

local function onTooltip(e)
	if config.essentialTooltip then
		local item = data.questItemTable[e.object.id:lower()]
		if item then
			local entry = tes3.getJournalIndex{ id = (item.entry) }
			local index = item.index
			if ((entry < index) or (entry == nil)) then
				local block = e.tooltip:createBlock{}
				block.minWidth = 1
				block.maxWidth = 440
				block.autoWidth = true
				block.autoHeight = true
				block.paddingAllSides = 4
				local essentialLabel
				essentialLabel = (block:createLabel{ id = tes3ui.registerID("Essential_Indicators_Item"), text = text.essentialItemLabel })
				essentialLabel.wrapText = true
			elseif (entry >= index) then
				return
			end
		end
	end
end

local function onInitialized()
	event.register("cellChanged", essentialSwitch)
	event.register("loaded", essentialSwitch)
	event.register("journal", essentialSwitch)
	event.register("damage", onDamage)
	event.register("uiObjectTooltip", onTooltip)
	print("[Essential Indicators]: Initialized Essential Indicators.")
end
event.register("initialized", onInitialized)

-- CROSSHAIR STUFF

-- Save people deleting their config.
if config.indicatorScale == nil then
	config.indicatorScale = 100
end

local function onLoaded(e)
	-- Hide the crosshair.We hide the niTriShape instead of the main niNode,
	-- because Bethesda appCull the main node to hide it in the menu.
	tes3.worldController.nodeCursor.children[1].appCulled = true
end
event.register("loaded", onLoaded)

local crosshair = {}
local function createCrosshair()
	if crosshair.parent == nil then
		return
	end

	crosshair.main = crosshair.parent:createBlock()
	crosshair.main.layoutOriginFractionX = 0.5
	crosshair.main.layoutOriginFractionY = 0.5
	crosshair.main.autoWidth = true
	crosshair.main.autoHeight = true

	local defaultTex = "textures/target.dds"

	crosshair.default = crosshair.main:createImage({ path = defaultTex })
	crosshair.default.scaleMode = true
	crosshair.default.width = (32 * (config.crosshairScale / 100))
	crosshair.default.height = (32 * (config.crosshairScale / 100))


	local stealTex = "textures/ownership_indicator.dds"
	local stealColor = {1.0, 1.0, 1.0}
	if not config.useTex then
		stealTex = defaultTex
		stealColor = {1.0, 0.1, 0.1}
	end
	crosshair.steal = crosshair.main:createImage({ path = stealTex })
	crosshair.steal.color = stealColor
	crosshair.steal.visible = false
	crosshair.steal.scaleMode = true
	crosshair.steal.width = (32 * (config.indicatorScale / 100))
	crosshair.steal.height = (32 * (config.indicatorScale / 100))

	local essentialTex = "textures/essential_indicator.dds"
	local essentialColor = {1.0, 1.0, 1.0}
	if not config.useTex then
		essentialTex = defaultTex
		essentialColor = {0.1, 0.1, 1.0}
	end
	crosshair.essential = crosshair.main:createImage({ path = stealTex })
	crosshair.essential.color = essentialColor
	crosshair.essential.visible = false
	crosshair.essential.scaleMode = true
	crosshair.essential.width = (32 * (config.indicatorScale / 100))
	crosshair.essential.height = (32 * (config.indicatorScale / 100))

	crosshair.main:updateLayout()
end

local function onMenuMultiCreated(e)
	if not e.newlyCreated then
		return
	end
	crosshair = {}
	crosshair.parent = e.element
	createCrosshair()
end
event.register("uiActivated", onMenuMultiCreated, { filter = "MenuMulti" })

local function setCrosshair(e)
	crosshair.default.visible = false
	crosshair.steal.visible = false
	crosshair.essential.visible = false

	if e == crosshair.default and tes3.worldController.cursorOff then
		return
	end

	e.visible = true
end

local function updateIndicator(target)
	setCrosshair(crosshair.default)
	if target ~= nil then
		if config.ownershipTarget then
			local owner = tes3.getOwner(target)
			if owner ~= nil then
				if owner.objectType == tes3.objectType.npc then
					-- Doors
					if target.object.objectType == tes3.objectType.door or string.find(target.object.name, '[Dd]oor') then
						local locked = tes3.getLocked{ reference = target }
						if locked then
							setCrosshair(crosshair.steal)
						else
							return
						end
					end
					-- Check it's not a rented bed.
					local globalVar = target.attachments.variables.requirement
					if globalVar == nil or globalVar.value ~= 1 then
						setCrosshair(crosshair.steal)
					end
				-- Factions may allow the player to use their items, if they're a member of adequate rank
				elseif owner.objectType == tes3.objectType.faction then
					if not owner.playerJoined or target.attachments.variables.requirement > owner.playerRank then
						setCrosshair(crosshair.steal)
					end
				end
			-- Pickpocketing (living) people is always bad.
			elseif target.object.objectType == tes3.objectType.npc and tes3.mobilePlayer.isSneaking and target.mobile.health.current > 0 then
				setCrosshair(crosshair.steal)
			end
		end
		-- Essential NPCs and Items
		if config.npcTarget and (target.baseObject.essential == true) then
			setCrosshair(crosshair.essential)
		elseif config.itemTarget then
			local item = data.questItemTable[target.object.id:lower()]
			if item then
				local entry = tes3.getJournalIndex{ id = (item.entry) }
				local index = item.index
				if ((entry < index) or (entry == nil)) then
					setCrosshair(crosshair.essential)
				elseif (entry >= index) then
					return
				end
			end
		end
	end
end

local function onActivationTargetChanged(e)
	updateIndicator(e.current)
end
event.register("activationTargetChanged", onActivationTargetChanged)

local hideTime = 0
local prevSneaking
local function onSimulate(e)
	crosshair.main.visible = true

	if prevSneaking ~= tes3.mobilePlayer.isSneaking then
		updateIndicator(tes3.getPlayerTarget())
	end
	prevSneaking = tes3.mobilePlayer.isSneaking

	if tes3.mobilePlayer.is3rdPerson then
		crosshair.main.visible = false
	end

	if config.autoHide then
		if tes3.getPlayerTarget() == nil and not tes3.mobilePlayer.castReady and ( not tes3.mobilePlayer.weaponReady or tes3.mobilePlayer.readiedWeapon == nil or not tes3.mobilePlayer.readiedWeapon.object.isRanged) then
			hideTime = hideTime + e.delta
			if hideTime > 1.5 then
				crosshair.main.visible = false
			end
		else
			hideTime = 0
		end
	end
end
event.register("simulate", onSimulate)

local function menuUpdate(e)
	crosshair.main.visible = not e.menuMode

	if e.menuMode == false then
		updateIndicator(tes3.getPlayerTarget())
	end
end
event.register("menuEnter", menuUpdate)
event.register("menuExit", menuUpdate)

-- MCM

local function registerMCM()
	local template = mwse.mcm.createTemplate(text.extensionModListName)
	template.onClose = function(self)
		mwse.saveConfig("Essential Indicators", config)
		essentialSwitch()
		if crosshair.main ~= nil then
			createCrosshair()
		end
    end

	local page = template:createSideBarPage()
	page.label = text.settingsPageLabel
	page.description = text.settingsPageDescription
	page.noScroll = false

	local category = page:createCategory(text.uiSettingsCategoryLabel)

	local messageButton = category:createOnOffButton({
		label = text.uiSettings_enableMessagesLabel,
		description = text.uiSettings_enableMessagesDescription,
		variable = mwse.mcm:createTableVariable{id = "messages", table = config},
	})

	local autoHideButton = category:createOnOffButton({
		label = text.uiSettings_enableAutoHidingCrosshair,
		description = "Enable Autohiding Crosshair\n\nDetermines whether the crosshair disappears while not in use.\n\nDefault: On",
		variable = mwse.mcm:createTableVariable{id = "autoHide", table = config},
	})

	local ownershipButton = category:createOnOffButton({
		label = text.uiSettings_enableOwnershipIndicator,
		description = "Enable Ownership Indicator\n\nDetermines whether the crosshair indicates when you're targeting an owned item or NPC to pickpocket.\n\nDefault: On",
		variable = mwse.mcm:createTableVariable{id = "ownershipTarget", table = config},
	})

	local npcTargetButton = category:createOnOffButton({
		label =  text.uiSettings_enableEssentialNPCIndicator,
		description = "Enable Essential NPC Indicator\n\nDetermines whether the crosshair indicates when you're targeting a quest-essential NPC.\n\nDefault: On",
		variable = mwse.mcm:createTableVariable{id = "npcTarget", table = config},
	})

	local itemTargetButton = category:createOnOffButton({
		label = text.uiSettings_enableEssentialItemIndicator,
		description = "Enable Essential Item Indicator\n\nDetermines whether the crosshair indicates when you're targeting a quest-essential item.\n\nDefault: On",
		variable = mwse.mcm:createTableVariable{id = "itemTarget", table = config},
	})

	local tooltipButton = category:createOnOffButton({
		label = text.uiSettings_enableQuestItemsTooltip,
		description = "Enable Tooltip for Quest Items\n\nDetermines whether quest-essential items receive a helpful tooltip reminding the player of their importance.\n\nDefault: On",
		variable = mwse.mcm:createTableVariable{id = "essentialTooltip", table = config},
	})

	local crosshairScaleSlider = category:createSlider({
		label = text.uiSettings_crossHairScale .. ": %s%%",
		description = "Determines the size of the default crosshair on the screen.\n\nDefault: 100%",
		min = 0,
		max = 200,
		step = 1,
		jump = 24,
		variable = mwse.mcm.createTableVariable{id = "crosshairScale", table = config },
	})

	local indicatorScaleSlider = category:createSlider({
		label = text.uiSettings_indicatorScale .. ": %s%%",
		description = "Determines the size of the indicator crosshair/texture on the screen.\n\nDefault: 100%",
		min = 0,
		max = 200,
		step = 1,
		jump = 24,
		variable = mwse.mcm.createTableVariable{id = "indicatorScale", table = config },
	})

	local category2 = page:createCategory(text.npcSettings)

	local vanillaButton = category2:createOnOffButton({
		label = text.npcSettings_enableChangesForVanillaEssentialNPC,
		description = "Enable Messages\n\nDetermines whether NPCs with the 'essential' status in the vanilla game will have their status changed once they are no longer needed.\n\nDefault: On",
		variable = mwse.mcm:createTableVariable{id = "npcVanilla", table = config}
	})

	local extendedButton = category2:createOnOffButton({
		label = text.npcSettings_enableChangesForExtendedEssentialNPC,
		description = "Enable Messages\n\nDetermines whether NPCs that lacked the 'essential' status in the vanilla game, but whose deaths still rendered the main quest impossible to finish, will be given the 'essential' status and have it changed once they are no longer needed.\n\nDefault: On",
		variable = mwse.mcm:createTableVariable{id = "npcExtended", table = config}
	})

	local invincibleButton = category2:createOnOffButton({
		label = text.npcSettings_enableInvincibleEssentialNPC,
		description = "Enable Invincible Essential NPCs\n\nDetermines whether NPCs with the 'essential' status are made invincible, all damage being dealt to their fatigue rather than health.\n\nDefault: Off",
		variable = mwse.mcm:createTableVariable{id = "essentialsInvincible", table = config}
	})

	local disableButton = category2:createOnOffButton({
		label = text.npcSettings_disableEssentialNPC,
		description = "Disable Essential NPCs\n\nDetermines whether the 'essential' status is removed from all NPCs. Not recommended unless you're an experienced player or just sick of messageboxes getting in the way of your rampage.\n\nDefault: Off",
		variable = mwse.mcm:createTableVariable{id = "noEssentials", table = config}
	})

	mwse.mcm.register(template)
end

event.register("modConfigReady", registerMCM)
