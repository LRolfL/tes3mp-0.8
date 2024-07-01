--[[
Written by 'Rolf' for TES3MP 0.8.0/0.8.1.

Description: Set and enforce a level cap for character's level, stats, attributes and skills (TES3MP does not provide individual limit options).

Steps:
1. Place this file inside 'server\scripts\custom' folder, located in your TES3MP directory.
2. Open 'customScripts.lua' file ('server\scripts') and write in it the next line: require('custom/levelsLimit')
3. Save the changes and close it.
4. Note: You need to modify the maximum allowed values in the TES3MP configuration ('config.lua' in 'server\scripts') to overcome those limitations with mine.
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

function capLevels(pid)
    local p = Players[pid]
    if p then
        tes3mp.StartTimer(tes3mp.CreateTimerEx('capLevels', 10000, 'i', pid)) -- 10 seconds until next check.
        -- Level:
        local maxLevel = maxStats.Level
        while tes3mp.GetLevel(pid) > maxLevel do
            p.data.stats.level = maxLevel
            p.data.stats.levelProgress = 0
            p:LoadLevel()
        end
        -- Stats:
        local maxHealth = maxStats.Health
        local maxMagicka = maxStats.Magicka
        local maxFatigue = maxStats.Fatigue
        while p.data.stats.healthBase > maxHealth or p.data.stats.magickaBase > maxMagicka or p.data.stats.fatigueBase > maxFatigue do
            if p.data.stats.healthBase > maxHealth then
                p.data.stats.healthBase = maxHealth
            elseif p.data.stats.magickaBase > maxMagicka then
                p.data.stats.magickaBase = maxMagicka
            elseif p.data.stats.fatigueBase > maxFatigue then
                p.data.stats.fatigueBase = maxFatigue
            end
            p:LoadStatsDynamic()
        end
        -- Attributes:
        local attributes = p.data.attributes
        for attributeName, maxValue in pairs(maxAttributes) do
            if attributes and attributes[attributeName] then
                if attributes[attributeName].base > maxValue then
                    attributes[attributeName].base = maxValue
                    attributes[attributeName].levelProgress = 0
                end
            end
        end
        p:LoadAttributes()
        -- Skills:
        local skills = p.data.skills
        for skillName, maxValue in pairs(maxSkills) do
            if skills and skills[skillName] then
                if skills[skillName].base > maxValue then
                    skills[skillName].base = maxValue
                    skills[skillName].progress = 0
                end
            end
        end
        p:LoadSkills()
    end
end

customEventHooks.registerHandler('OnPlayerConnect', function(_, pid) capLevels(pid) end)
