local this = {}

local lib = require('abot.lib')

this.config = {}

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


function this.onCreate(container)
	local mainPane = lib.createMainPane(container)
	lib.createBooleanConfig({
		parent = mainPane,
		label = text.switchAtInteriorsOptionText,
		config = this.config,
		key = "onEnteringInteriors",
	})
	lib.createBooleanConfig({
		parent = mainPane,
		label = text.switchAtExteriorsOptionText,
		config = this.config,
		key = "onCrossingExteriors",
	})
	lib.createSliderConfig({
		parent = mainPane,
		label = text.numberOfDoorsOptionText,
		config = this.config,
		key = "minExteriorCellLinkedDoorsForLocalMap",
		min = 1, max = 50, step = 1, jump = 5,
		info = "(" .. text.numberOfDoorsInfoText .. ")",
	})
end

return this
