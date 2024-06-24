--[[
Writen by 'Rolf' for TES3MP 0.8.0 and 0.8.1.

Description: Provides the capacity to set attributes, skills, and level to a certain number. (TES3MP does not provide options to limit each individually).
Establishes the level and points of all basic static aspects of a character, and checks no one exceeds it.

Steps:
1. Place this file inside 'server\scripts\custom' folder, located in your TES3MP directory.
2. Open 'customScripts.lua' file ('server\scripts') and write in it the next line: require("custom/levelsControl")
3. Save the changes and close it.
4. Note: You need to modify the maximum allowed values in the base TES3MP configuration ('config.lua' in 'server\scripts') to overcome those limitations with mine.
5. Save the changes and close it.
--]]

local maxStats = {Level = 200, Health = 5000, Magicka = 2000, Fatigue = 2000}
local maxAttributes = {Strength = 100, Agility = 100, Personality = 100, Speed = 100, Luck = 100, Endurance = 100, Intelligence = 100, Willpower = 100}
local maxSkills = {
    Heavyarmor = 100, Mediumarmor = 100, Lightarmor = 100, Unarmored = 100,
    Spear = 100, Axe = 100, Bluntweapon = 100, Longblade = 100, Shortblade = 100, Marksman = 100, Handtohand = 100, Block = 100,
    Illusion = 100, Conjuration = 100, Alteration = 100, Destruction = 100, Mysticism = 100, Restoration = 100,
    Enchant = 100, Alchemy = 100, Armorer = 100, Mercantile = 100, Speechcraft = 100, Security = 100,
    Acrobatics = 100, Athletics = 100, Sneak = 100
}

function controLevels(pid)
    local player = Players[pid]
    if player then
        local timerId = tes3mp.CreateTimerEx('controLevels', 10000, 'i', pid) -- 10 seconds until next check.
        tes3mp.StartTimer(timerId)
        -- Level:
        local maxLevel = maxStats.Level
        while tes3mp.GetLevel(pid) > maxLevel do
            player.data.stats.level = maxLevel
            player.data.stats.levelProgress = 0
            player:LoadLevel()
        end
        -- Stats:
        local maxHealth = maxStats.Health
        local maxMagicka = maxStats.Magicka
        local maxFatigue = maxStats.Fatigue
        while player.data.stats.healthBase > maxHealth or player.data.stats.magickaBase > maxMagicka or player.data.stats.fatigueBase > maxFatigue do
            if player.data.stats.healthBase > maxHealth then
                player.data.stats.healthBase = maxHealth
            elseif player.data.stats.magickaBase > maxMagicka then
                player.data.stats.magickaBase = maxMagicka
            elseif player.data.stats.fatigueBase > maxFatigue then
                player.data.stats.fatigueBase = maxFatigue
            end
            player:LoadStatsDynamic()
        end
        -- Attributes:
        local attributes = player.data.attributes
        for attributeName, maxValue in pairs(maxAttributes) do
            if attributes and attributes[attributeName] then
                if attributes[attributeName].base > maxValue then
                    attributes[attributeName].base = maxValue
                    attributes[attributeName].levelProgress = 0
                end
            end
        end
        player:LoadAttributes()
        -- Skills:
        local skills = player.data.skills
        for skillName, maxValue in pairs(maxSkills) do
            if skills and skills[skillName] then
                if skills[skillName].base > maxValue then
                    skills[skillName].base = maxValue
                    skills[skillName].progress = 0
                end
            end
        end
        player:LoadSkills()
    end
end

customEventHooks.registerHandler('OnPlayerConnect', function(eventStatus, pid) controLevels(pid) end)
