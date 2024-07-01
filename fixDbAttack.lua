--[[
Written by 'Rolf' for TES3MP 0.8.0/0.8.1. Inspired by Learwolf's dbFix.

Description: Manages the appearance of assassins based on player's level. Configurable for one or several spawns per character.

Steps:
1. Place this file inside 'server\scripts\custom' folder, located in your TES3MP directory.
2. Open 'customScripts.lua' file ('server\scripts') and write in it the next line: require('custom/fixDbAttack')
3. Save the changes and close it.
--]]

local lvl = 25 -- Level required to activate assassin spawns.
local spawnOnce = false -- If 'true', the assassin appears only once per player.
local scrStatus = {}
local assStatus = {}

local function toggleScript(pid, start)
    if scrStatus[pid] ~= start then
        logicHandler.RunConsoleCommandOnPlayer(pid, (start and 'startscript' or 'stopscript')..' dbAttackScript')
        scrStatus[pid] = start
    end
end

local function checkLevel(pid)
    if spawnOnce then
        if not assStatus[pid] then
            toggleScript(pid, tes3mp.GetLevel(pid) >= lvl)
            assStatus[pid] = true
        end
    else
        toggleScript(pid, tes3mp.GetLevel(pid) >= lvl)
    end
end

customEventHooks.registerHandler('OnPlayerLevel', function(_, pid) checkLevel(pid) end)
customEventHooks.registerHandler('OnPlayerAuthentified', function(_, pid) if Players[pid] and Players[pid]:IsLoggedIn() then checkLevel(pid) end end)
