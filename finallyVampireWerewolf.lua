--[[
Writen by 'Rolf' for TES3MP 0.8.0 and 0.8.1.

Description: Fixes the impossibility of becoming vampire or werewolf without commands, due to how the passage of time works, among other things; executing the appropiate commands each time a player is infected.

Steps:
1. Place this file inside 'server\scripts\custom' folder, located in your TES3MP directory.
2. Open 'customScripts.lua' file ('server\scripts') and write in it the next line: require("custom/finallyVampireWerewolf")
3. Save the changes and close it.
--]]

local vampire = true -- 'false' if you want no one becomes vampire through this script.
local werewolf = true -- 'false' if you want no one becomes werewolf through this script.
local vampTalk = false -- 'true' if you want vampires can talk to everyone, but the sun damage applied to them stops working.

local tableHelper = require('tableHelper')

local function OnPlayerCellChange(eventStatus, pid)
    local player = Players[pid]
    if player and player:IsLoggedIn() then
        if (tableHelper.containsValue(player.data.spellbook, 'vampire blood quarra') or tableHelper.containsValue(player.data.spellbook, 'vampire blood aundae') or tableHelper.containsValue(player.data.spellbook, 'vampire blood berne')) and vampire and not tableHelper.containsValue(player.data.spellbook, 'vampire attributes') then
            local vampireSpells = {
                'set PCVampire to 1', 'addspell "vampire attributes"', 'addspell "vampire skills"', 'addspell "vampire immunities"'
            }
            for _, command in pairs(vampireSpells) do
                logicHandler.RunConsoleCommandOnPlayer(player.pid, command)
            end
            if vampTalk == false then
                logicHandler.RunConsoleCommandOnPlayer(player.pid, 'addspell "vampire sun damage"')
            elseif tableHelper.containsValue(player.data.spellbook, 'vampire blood quarra') then
                logicHandler.RunConsoleCommandOnPlayer(player.pid, 'addspell "vampire quarra specials"')
            elseif tableHelper.containsValue(player.data.spellbook, 'vampire blood aundae') then
                logicHandler.RunConsoleCommandOnPlayer(player.pid, 'addspell "vampire aundae specials"')
            elseif tableHelper.containsValue(player.data.spellbook, 'vampire blood berne') then
                logicHandler.RunConsoleCommandOnPlayer(player.pid, 'addspell "vampire berne specials"')
            end
        elseif tableHelper.containsValue(player.data.spellbook, 'werewolf blood') and werewolf and not tableHelper.containsValue(player.data.spellbook, 'werewolf resists') then
            local werewolfSpells = {
                'set PCWerewolf to 1', 'addspell "werewolf resists"', 'addspell "werewolf regeneration"', 'addspell "werewolf vision"'
            }
            for _, command in pairs(werewolfSpells) do
                logicHandler.RunConsoleCommandOnPlayer(player.pid, command)
            end
        end
    end
end

customEventHooks.registerValidator('OnPlayerCellChange', OnPlayerCellChange)
