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
local scriptStatus = {}
local assassinStatus = {}

local function toggleScript(pid, start)
    if scriptStatus[pid] ~= start then
        logicHandler.RunConsoleCommandOnPlayer(pid, (start and 'startscript' or 'stopscript')..' dbAttackScript')
        scriptStatus[pid] = start
    end
end

local function checkLevel(pid)
    if not assassinStatus[pid] and spawnOnce then
        toggleScript(pid, tes3mp.GetLevel(pid) >= lvl)
        assassinStatus[pid] = true
    elseif not spawnOnce then
        toggleScript(pid, tes3mp.GetLevel(pid) >= lvl)
    end
end

customEventHooks.registerHandler('OnPlayerLevel', function(_, pid) checkLevel(pid) end)

customEventHooks.registerHandler('OnPlayerAuthentified', function(_, pid)
    if Players[pid] and Players[pid]:IsLoggedIn() then
        checkLevel(pid)
    end
end)
