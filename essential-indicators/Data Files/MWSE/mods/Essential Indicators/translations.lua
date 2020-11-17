return {
	["eng"] = {
		extensionName = "Essential Indicators",
		extensionModListName = "Essential Indicators",
		essentialHeroWarning = "This character's death would result in the thread of prophecy being severed. Hand yourself over to the guard, utilize a calm spell, or restore a saved game to reverse this tempting of fate.",
		essentialItemLabel = "Essential Item",
		settingsPageLabel = "Settings",
		settingsPageDescription = (
			"Essential Indicators\n\n" ..
			"Essential Indicators utilizes MWSE to provide configurable, dynamic crosshair indicators when looking at essential NPCs, "..
			"quest items, owned objects, and more.\n\n" ..

			"In addition, a variety of settings are included to manage how these aspects of the game work, "..
			"including a number of ways to manage the 'essential' status of Morrowind's important NPCs, "..
			"allowing you the options to remove the status once they've served their purpose, render them invincible, "..
			"disable the status entirely, or provide it to vital NPCs that weren't considered 'essential' before.\n\n" ..

			"Most of these NPCs weren't directly involved in the main quest, but would have locked you out from speaking "..
			"to their faction members who were. " ..

			"With this mod, you not only won't have to worry about those pesky messages insisting "..
			"that a spent NPC was important, but quests like 'Sleepers Awake' will no longer lock you out "..
			"from completion for having killed them, considering they're no longer essential.\n\n" ..

			"In addition, quest items and essential NPCs will have their status and indicators updated to reflect "..
			"when they're no longer essential for the completion of a quest."
		),
		uiSettingsCategoryLabel = "UI Settings",
		uiSettings_enableMessagesLabel = "Enable Messages",
		uiSettings_enableMessages_description = (
			"Enable Messages\n\n" ..
			"Determines whether new messages are displayed.\n\n" ..
			"Default: On"
		),
		uiSettings_enableAutoHidingCrosshair = "Enable Autohiding Crosshair",
		uiSettings_enableAutoHidingCrosshair_description = (
			"Enable Autohiding Crosshair\n\n"..
			"Determines whether the crosshair disappears while not in use.\n\n"..
			"Default: On"
		),
		uiSettings_enableOwnershipIndicator = "Enable Ownership Indicator",
		uiSettings_enableOwnershipIndicator_description = (
			"Enable Ownership Indicator\n\n"..
			"Determines whether the crosshair indicates when you're targeting an owned item or NPC to pickpocket.\n\n"..
			"Default: On"
		),
		uiSettings_enableEssentialNPCIndicator = "Enable Essential NPC Indicator",
		uiSettings_enableEssentialNPCIndicator_description = (
			"Enable Essential NPC Indicator\n\n"..
			"Determines whether the crosshair indicates when you're targeting a quest-essential NPC.\n\n"..
			"Default: On"
		),
		uiSettings_enableEssentialItemIndicator = "Enable Essential Item Indicator",
		uiSettings_enableEssentialItemIndicator_description = (
			"Enable Essential Item Indicator\n\n"..
			"Determines whether the crosshair indicates when you're targeting a quest-essential item.\n\n"..
			"Default: On"
		),
		uiSettings_enableQuestItemsTooltip = "Enable Tooltip for Quest Items",
		uiSettings_enableQuestItemsTooltip_description = (
			"Enable Tooltip for Quest Items\n\n"..
			"Determines whether quest-essential items receive a helpful tooltip reminding the player of their importance.\n\n"..
			"Default: On"
		),
		uiSettings_crossHairScale = "Crosshair Scale",
		uiSettings_crossHairScale_description = (
			"Determines the size of the default crosshair on the screen.\n\n"..
			"Default: 100%"
		),
		uiSettings_indicatorScale = "Indicator Scale",
		uiSettings_indicatorScale_description = (
			"Determines the size of the indicator crosshair/texture on the screen.\n\n"..
			"Default: 100%"
		),

		npcSettings = "NPC Settings",
		npcSettings_enableChangesForVanillaEssentialNPC = "Enable Changes for Vanilla Essential NPCs",
		npcSettings_enableChangesForVanillaEssentialNPC_description = (
			"Enable Changes for Vanilla Essential NPCs\n\n"..
			"Determines whether NPCs with the 'essential' status in the vanilla game will have their status changed once they are no longer needed.\n\n"..
			"Default: On"
		),

		npcSettings_enableChangesForExtendedEssentialNPC = "Enable Changes for Extended Essential NPCs",
		npcSettings_enableChangesForExtendedEssentialNPC_description = (
			"Enable Changes for Extended Essential NPCs\n\n"..
			"Determines whether NPCs that lacked the 'essential' status in the vanilla game, "..
			"but whose deaths still rendered the main quest impossible to finish, "..
			"will be given the 'essential' status and have it changed once they are no longer needed.\n\n"..
			"Default: On"
		),

		npcSettings_enableInvincibleEssentialNPC = "Enable Invincible Essential NPCs",
		npcSettings_enableInvincibleEssentialNPC_description = (
			"Enable Invincible Essential NPCs\n\n"..
			"Determines whether NPCs with the 'essential' status are made invincible, "..
			"all damage being dealt to their fatigue rather than health.\n\n"..
			"Default: Off"
		),

		npcSettings_disableEssentialNPC = "Disable Essential NPCs",
		npcSettings_disableEssentialNPC_description = (
			"Disable Essential NPCs\n\n"..
			"Determines whether the 'essential' status is removed from all NPCs. "..
			"Not recommended unless you're an experienced player or just sick of messageboxes getting in the way of your rampage.\n\n"..
			"Default: Off"
		),
	},
	["rus"] = {
		extensionName = "Индикаторы Значимого - Essential Indicators",
		extensionModListName = "Индикаторы Значимого",
		essentialCharacterWarning = "Смерть этого персонажа прервет нить событий пророчества. Предайте себя в руки правосудия, кастаните успокаивающее заклинание или загрузите сохранение дабы избежать это испытание судьбы.",
		essentialItemLabel = "Значимый предмет",
		settingsPageLabel = "Настройки",
		settingsPageDescription = (
			"Индикаторы Значимого - Essential Indicators\n\n" ..
			"Индикаторы Значимого используют MWSE, чтобы дать настраиваемые, динамические перекрестья, когда игрок смотрит на Значимых NPC, "..
			"квестовые предметы, чужие предметы и тд.\n\n" ..

			"В добавок включено множество настроек для этих аспектов игры, "..
			"в том числе возможность манипуляции статусом 'Значимости' NPC в Морровинде."..
			"Например, вы можете убрать статус 'Значимый', когда по сюжету NPC уже больше таковым не является, "..
			"сделать их неуязвивыми, убрать 'Значимость' насовсем или наоборт сделать Значимыми те NPC, которые таковыми ранее не были.\n\n" ..

			"Часть NPC не вовлечена напрямую в ход главного квеста, но онм могут помешать вам начать разговор "..
			" с теми из их фракци, кто вовлечен.\n\n" ..

			"Модификация не только уберет назойливые сообщения о Значимости NPC, "..
			"но и,как в случае с квестом 'Пробуждение Спящих', ваше прохождение не заблокируется "..
			"в случае смерти уже больше не 'значимых' NPC.\n\n" ..

			"Плюс все изменения статусов у предметов и NPC будут всегда видны по изменившимя индикаторам."
		),
		uiSettingsCategoryLabel = "Настройки интерфейса",
		uiSettings_enableMessagesLabel = "Включить Сообщения",
		uiSettings_enableMessages_description = (
			"Включить Сообщения\n\n" ..
			"Показывать ли новые сообщения.\n\n"..
			"По умолчанию включено"
		),
		uiSettings_enableAutoHidingCrosshair = "Включить автоскрытие перекрестия",
		uiSettings_enableAutoHidingCrosshair_description = (
			"Включить автоскрытие перекрестия\n\n"..
			"Скрывать перекрестие,когда оно не используется.\n\n"..
			"По умолчанию включено"
		),
		uiSettings_enableOwnershipIndicator = "Включить индикатор принадлежности",
		uiSettings_enableOwnershipIndicator_description = (
			"Включить индикатор принадлежности\n\n"..
			"Определяет, будет ли перекрестие определять, чужой ли предмет или вороство у NPC.\n\n"..
			"По умолчанию включено"
		),
		uiSettings_enableEssentialNPCIndicator = "Включить индикатор Значимых NPC",
		uiSettings_enableEssentialNPCIndicator_description = (
			"Включить индикатор Значимых NPC\n\n"..
			"Перекрестье поменяет цвет, если вы смотрите на Значимого для квестов NPC.\n\n"..
			"По умолчанию включено"
		),
		uiSettings_enableEssentialItemIndicator = "Включить индикатор Значимых предметов",
		uiSettings_enableEssentialItemIndicator_description = (
			"Включить индикатор Значимых предметов\n\n"..
			"Перекрестье поменяет цвет, если вы посмотрите на Значимый для квестов предмет.\n\n"..
			"По умолчанию включено"
		),
		uiSettings_enableQuestItemsTooltip = "Включить подсказку для квестовых предметов",
		uiSettings_enableQuestItemsTooltip_description = (
			"Включить подсказку для квестовых предметов\n\n"..
			"Квестовые предметы получат всплывающее окно с напоминанием о значимости предмета для квеста.\n\n"..
			"По умолчанию включено"
		),
		uiSettings_crossHairScale = "Масштаб перекрестия",
		uiSettings_crossHairScale_description = (
			"Определяет размер стандартного перекрестия на экране.\n\n"..
			"По умолчанию 100%"
		),
		uiSettings_indicatorScale = "Масштаб индикаторов",
		uiSettings_indicatorScale_description = (
			"Определяет размер перекрестия-индикатора/текстуры на экране.\n\n"..
			"По умолчанию 100%"
		),

		npcSettings = "Настройки NPC",

		npcSettings_enableChangesForVanillaEssentialNPC = "Применить изменения к классическим Значимым NPC",
		npcSettings_enableChangesForVanillaEssentialNPC_description = (
			"Применить изменения к классическим Значимым NPC\n\n"..
			"Определяет, будут ли Значимые NPCs из оригинальной версии игры менять свой статус после того, как перестанут быть нужными по квесту.\n\n"..
			"По умолчанию включено"
		),

		npcSettings_enableChangesForExtendedEssentialNPC = "Применить изменения к расширенному списку Значимых NPC",
		npcSettings_enableChangesForExtendedEssentialNPC_description = (
			"Применить изменения к расширенному списку Значимых NPC\n\n"..
			"Не Значимые NPC в оригинальной версии игры, "..
			"после смерти которых невозможно завершить основной квест, "..
			"получат статус Значимых и потеряют его, как только сыграют свою роль в квесте.\n\n"..
			"По умолчанию включено"
		),

		npcSettings_enableInvincibleEssentialNPC = "Сделать Значимых NPC бессметрными",
		npcSettings_enableInvincibleEssentialNPC_description = (
			"Сделать Значимых NPC бессметрными\n\n"..
			"Делает Значимых NPC бессмертными,"..
			"перенося весь урон со Здоровья на его Запас Сил.\n\n"..
			"По умолчанию выключено"
		),

		npcSettings_disableEssentialNPC = "Отключить 'Значимость' у Значимых NPC",
		npcSettings_disableEssentialNPC_description = (
			"Отключить 'Значимость' у Значимых NPC\n\n"..
			"Убирает статус 'Значимый' у всех NPC."..
			"Только для опытных игроков, которые во время мясорубок устают от бесконечных уведомлений.\n\n"..
			"По умолчанию выключено"
		),
	}
}