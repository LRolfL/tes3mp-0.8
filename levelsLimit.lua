--[[
Written by 'Rolf' for TES3MP 0.8.0/0.8.1.

Description: Set and enforce a level cap for character's level, stats, attributes and skills (TES3MP does not provide individual limit options).

Steps:
1. Place this file inside 'server\scripts\custom' folder, located in your TES3MP directory.
2. Open 'customScripts.lua' file ('server\scripts') and write in it the next line: require('custom/levelsLimit')
3. Save the changes and close it.
4. Note: You need to modify the maximum allowed values in the TES3MP configuration ('config.lua' in 'server\scripts') to overcome those limitations with mine.
--]]

local maxStats = {Level = 200, Health = 5000, Magicka = 2000, Fatigue = 2000}
local maxAttributes = {Strength = 100, Agility = 100, Personality = 100, Speed = 100, Luck = 100, Endurance = 100, Intelligence = 100, Willpower = 100}
local maxSkills = {
    Heavyarmor = 100, Mediumarmor = 100, Lightarmor = 100, Unarmored = 100, Spear = 100, Axe = 100, Bluntweapon = 100, Longblade = 100, Shortblade = 100, Marksman = 100, Handtohand = 100, Block = 100,
    Illusion = 100, Conjuration = 100, Alteration = 100, Destruction = 100, Mysticism = 100, Restoration = 100, Enchant = 100, Alchemy = 100,
    Armorer = 100, Mercantile = 100, Speechcraft = 100, Security = 100, Acrobatics = 100, Athletics = 100, Sneak = 100
}

function capLevels(pid)
    local p = Players[pid]
    if not p then return end
    -- Level:
    if tes3mp.GetLevel(pid) > maxStats.Level then
        p.data.stats.level = maxStats.Level
        p.data.stats.levelProgress = 0
        p:LoadLevel()
    end
    -- Stats:
    local stats = p.data.stats
    local statsChanged = false
    if stats.healthBase > maxStats.Health then
        stats.healthBase = maxStats.Health
        statsChanged = true
    end
    if stats.magickaBase > maxStats.Magicka then
        stats.magickaBase = maxStats.Magicka
        statsChanged = true
    end
    if stats.fatigueBase > maxStats.Fatigue then
        stats.fatigueBase = maxStats.Fatigue
        statsChanged = true
    end
    if statsChanged then p:LoadStatsDynamic() end
    -- Attributes:
    local attrs = p.data.attributes
    local attrsChanged = false
    for attr, max in pairs(maxAttributes) do
        if attrs[attr].base > max then
            attrs[attr].base = max
            attrs[attr].levelProgress = 0
            attrsChanged = true
        end
    end
    if attrsChanged then p:LoadAttributes() end
    -- Skills:
    local skills = p.data.skills
    local skillsChanged = false
    for skill, max in pairs(maxSkills) do
        if skills[skill].base > max then
            skills[skill].base = max
            skills[skill].progress = 0
            skillsChanged = true
        end
    end
    if skillsChanged then p:LoadSkills() end
    -- Timer:
    tes3mp.StartTimer(tes3mp.CreateTimerEx('capLevels', 2500, 'i', pid)) -- 2.5 seconds until next check.
end

customEventHooks.registerHandler('OnPlayerConnect', function(_, pid) capLevels(pid) end)
