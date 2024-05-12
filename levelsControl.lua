--[[
Writen by 'Rolf' for TES3MP 0.8.0 and 0.8.1.

Description: Provides the capacity to adjust (cap or allow) attributes, skills and level to a certain number (TES3MP does not provide options to individually limit each one).
Establishes the level and points of all basic static aspects of a character, and checks to prevent no one exceeds it.

Steps:
1. Place this file inside 'server\scripts\custom' folder, located in your TES3MP directory.
2. Open 'customScripts.lua' file ('server\scripts') and write in it the next line: require("custom/levelsControl")
3. Save the changes and close it.
4. Note: You need to modify the maximum allowed values in the base configuration of TES3MP ('config.lua' in 'server\scripts') to overcome those limitations with my script.
5. Save the changes and close it.
--]]

-- Each one are the maximun number of levels somebody can acquire, in an attribute, skill, or player level. Also health, magicka and fatigue.
local maxLevel = 200
-- Stats:
local maxHealth = 5000
local maxMagicka = 2000
local maxFatigue = 2000
-- Attributes:
local maxStrength = 100
local maxAgility = 100
local maxPersonality = 100
local maxSpeed = 100
local maxLuck = 100
local maxEndurance = 100
local maxIntelligence = 100
local maxWillpower = 100
-- Skills:
local maxHeavyArmor = 100
local maxMediumArmor = 100
local maxLightArmor = 100
local maxUnarmored = 100
local maxSpear = 100
local maxAxe = 100
local maxBluntWeapon = 100
local maxLongBlade = 100
local maxShortBlade = 100
local maxMarksman = 100
local maxHandtoHand = 100
local maxBlock = 100
local maxIllusion = 100
local maxConjuration = 100
local maxAlteration = 100
local maxDestruction = 100
local maxMysticism = 100
local maxRestoration = 100
local maxEnchant = 100
local maxAlchemy = 100
local maxAcrobatics = 100
local maxAthletics = 100
local maxSneak = 100
local maxArmorer = 100
local maxMercantile = 100
local maxSpeechcraft = 100
local maxSecurity = 100

customEventHooks.registerValidator('OnPlayerCellChange', function(eventStatus, pid)
    if Players[pid] ~= nil and Players[pid]:IsLoggedIn() then
        -- Level:
        while (tes3mp.GetLevel(pid) > maxLevel and Players[pid].data.stats.level > maxLevel) do
            Players[pid].data.stats.level = maxLevel
            Players[pid].data.stats.levelProgress = 0
            Players[pid]:LoadLevel()
        end
        -- Stats:
        while (Players[pid].data.stats.healthBase > maxHealth or Players[pid].data.stats.magickaBase > maxMagicka or Players[pid].data.stats.fatigueBase > maxFatigue) do
            if Players[pid].data.stats.healthBase > maxHealth then
                Players[pid].data.stats.healthBase = maxHealth
                Players[pid].data.stats.healthCurrent = maxHealth
            elseif Players[pid].data.stats.magickaBase > maxMagicka then
                Players[pid].data.stats.magickaBase = maxMagicka
                Players[pid].data.stats.magickaCurrent = maxMagicka
            elseif Players[pid].data.stats.fatigueBase > maxFatigue then
                Players[pid].data.stats.fatigueBase = maxFatigue
                Players[pid].data.stats.fatigueCurrent = maxFatigue
            end
            Players[pid]:LoadStatsDynamic()
        end
        -- Attributes:
        while (Players[pid].data.attributes.Strength.base > maxStrength or Players[pid].data.attributes.Agility.base > maxAgility or Players[pid].data.attributes.Personality.base > maxPersonality or Players[pid].data.attributes.Speed.base > maxSpeed or Players[pid].data.attributes.Luck.base > maxLuck or Players[pid].data.attributes.Endurance.base > maxEndurance or Players[pid].data.attributes.Intelligence.base > maxIntelligence or Players[pid].data.attributes.Willpower.base > maxWillpower) do
            if Players[pid].data.attributes.Strength.base > maxStrength then
                Players[pid].data.attributes.Strength.base = maxStrength
            elseif Players[pid].data.attributes.Agility.base > maxAgility then
                Players[pid].data.attributes.Agility.base = maxAgility
            elseif Players[pid].data.attributes.Personality.base > maxPersonality then
                Players[pid].data.attributes.Personality.base = maxPersonality
            elseif Players[pid].data.attributes.Speed.base > maxSpeed then
                Players[pid].data.attributes.Speed.base = maxSpeed
            elseif Players[pid].data.attributes.Luck.base > maxLuck then
                Players[pid].data.attributes.Luck.base = maxLuck
            elseif Players[pid].data.attributes.Endurance.base > maxEndurance then
                Players[pid].data.attributes.Endurance.base = maxEndurance
            elseif Players[pid].data.attributes.Intelligence.base > maxIntelligence then
                Players[pid].data.attributes.Intelligence.base = maxIntelligence
            elseif Players[pid].data.attributes.Willpower.base > maxWillpower then
                Players[pid].data.attributes.Willpower.base = maxWillpower
            end
            Players[pid]:LoadAttributes()
        end
        -- Skills:
        while (Players[pid].data.skills.Heavyarmor.base > maxHeavyArmor or Players[pid].data.skills.Mediumarmor.base > maxMediumArmor or Players[pid].data.skills.Lightarmor.base > maxLightArmor or Players[pid].data.skills.Unarmored.base > maxUnarmored or Players[pid].data.skills.Spear.base > maxSpear or Players[pid].data.skills.Axe.base > maxAxe or Players[pid].data.skills.Bluntweapon.base > maxBluntWeapon or Players[pid].data.skills.Longblade.base > maxLongBlade or Players[pid].data.skills.Shortblade.base > maxShortBlade or Players[pid].data.skills.Marksman.base > maxMarksman or Players[pid].data.skills.Handtohand.base > maxHandtoHand or Players[pid].data.skills.Block.base > maxBlock or Players[pid].data.skills.Illusion.base > maxIllusion or Players[pid].data.skills.Conjuration.base > maxConjuration or Players[pid].data.skills.Alteration.base > maxAlteration or Players[pid].data.skills.Destruction.base > maxDestruction or Players[pid].data.skills.Mysticism.base > maxMysticism or Players[pid].data.skills.Restoration.base > maxRestoration or Players[pid].data.skills.Enchant.base > maxEnchant or Players[pid].data.skills.Alchemy.base > maxAlchemy or Players[pid].data.skills.Acrobatics.base > maxAcrobatics or Players[pid].data.skills.Athletics.base > maxAthletics or Players[pid].data.skills.Sneak.base > maxSneak or Players[pid].data.skills.Armorer.base > maxArmorer or Players[pid].data.skills.Mercantile.base > maxMercantile or Players[pid].data.skills.Speechcraft.base > maxSpeechcraft or Players[pid].data.skills.Security.base > maxSecurity) do
            if Players[pid].data.skills.Heavyarmor.base > maxHeavyArmor then
                Players[pid].data.skills.Heavyarmor.base = maxHeavyArmor
            elseif Players[pid].data.skills.Mediumarmor.base > maxMediumArmor then
                Players[pid].data.skills.Mediumarmor.base = maxMediumArmor
            elseif Players[pid].data.skills.Lightarmor.base > maxLightArmor then
                Players[pid].data.skills.Lightarmor.base = maxLightArmor
            elseif Players[pid].data.skills.Unarmored.base > maxUnarmored then
                Players[pid].data.skills.Unarmored.base = maxUnarmored
            elseif Players[pid].data.skills.Spear.base > maxSpear then
                Players[pid].data.skills.Spear.base = maxSpear
            elseif Players[pid].data.skills.Axe.base > maxAxe then
                Players[pid].data.skills.Axe.base = maxAxe
            elseif Players[pid].data.skills.Bluntweapon.base > maxBluntWeapon then
                Players[pid].data.skills.Bluntweapon.base = maxBluntWeapon
            elseif Players[pid].data.skills.Longblade.base > maxLongBlade then
                Players[pid].data.skills.Longblade.base = maxLongBlade
            elseif Players[pid].data.skills.Shortblade.base > maxShortBlade then
                Players[pid].data.skills.Shortblade.base = maxShortBlade
            elseif Players[pid].data.skills.Marksman.base > maxMarksman then
                Players[pid].data.skills.Marksman.base = maxMarksman
            elseif Players[pid].data.skills.Handtohand.base > maxHandtoHand then
                Players[pid].data.skills.Handtohand.base = maxHandtoHand
            elseif Players[pid].data.skills.Block.base > maxBlock then
                Players[pid].data.skills.Block.base = maxBlock
            elseif Players[pid].data.skills.Illusion.base > maxIllusion then
                Players[pid].data.skills.Illusion.base = maxIllusion
            elseif Players[pid].data.skills.Conjuration.base > maxConjuration then
                Players[pid].data.skills.Conjuration.base = maxConjuration
            elseif Players[pid].data.skills.Alteration.base > maxAlteration then
                Players[pid].data.skills.Alteration.base = maxAlteration
            elseif Players[pid].data.skills.Destruction.base > maxDestruction then
                Players[pid].data.skills.Destruction.base = maxDestruction
            elseif Players[pid].data.skills.Mysticism.base > maxMysticism then
                Players[pid].data.skills.Mysticism.base = maxMysticism
            elseif Players[pid].data.skills.Restoration.base > maxRestoration then
                Players[pid].data.skills.Restoration.base = maxRestoration
            elseif Players[pid].data.skills.Enchant.base > maxEnchant then
                Players[pid].data.skills.Enchant.base = maxEnchant
            elseif Players[pid].data.skills.Alchemy.base > maxAlchemy then
                Players[pid].data.skills.Alchemy.base = maxAlchemy
            elseif Players[pid].data.skills.Acrobatics.base > maxAcrobatics then
                Players[pid].data.skills.Acrobatics.base = maxAcrobatics
            elseif Players[pid].data.skills.Athletics.base > maxAthletics then
                Players[pid].data.skills.Athletics.base = maxAthletics
            elseif Players[pid].data.skills.Sneak.base > maxSneak then
                Players[pid].data.skills.Sneak.base = maxSneak
            elseif Players[pid].data.skills.Armorer.base > maxArmorer then
                Players[pid].data.skills.Armorer.base = maxArmorer
            elseif Players[pid].data.skills.Mercantile.base > maxMercantile then
                Players[pid].data.skills.Mercantile.base = maxMercantile
            elseif Players[pid].data.skills.Speechcraft.base > maxSpeechcraft then
                Players[pid].data.skills.Speechcraft.base = maxSpeechcraft
            elseif Players[pid].data.skills.Security.base > maxSecurity then
                Players[pid].data.skills.Security.base = maxSecurity
            end
            Players[pid]:LoadSkills()
        end
    end
end)
