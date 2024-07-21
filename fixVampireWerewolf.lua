--[[
Written by 'Rolf' for TES3MP 0.8.0/0.8.1.

Description: Fixes the impossibility of becoming a vampire/werewolf without commands due to the passage of time; executes appropriate orders when infected.

Steps:
1. Place this file inside 'server\scripts\custom' folder, located in your TES3MP directory.
2. Open 'customScripts.lua' file ('server\scripts') and write in it the next line: require('custom/fixVampireWerewolf')
3. Save the changes and close it.
--]]

local vampire, werewolf = true, true -- 'false' disables the fix.
local vampTalk = false -- 'true' allows vampires to talk to everyone, but disables sun damage.
local tableHelper = require('tableHelper')

local function OnPlayerCellChange(_, pid)
    local p = Players[pid]
    if p and p:IsLoggedIn() then
        if (tableHelper.containsValue(p.data.spellbook, 'vampire blood quarra') or tableHelper.containsValue(p.data.spellbook, 'vampire blood aundae') or tableHelper.containsValue(p.data.spellbook, 'vampire blood berne')) and vampire and not tableHelper.containsValue(p.data.spellbook, 'vampire attributes') then
            local vampSpells = {'set PCVampire to 1', 'addspell "vampire attributes"', 'addspell "vampire skills"', 'addspell "vampire immunities"'}
            for _, comm in pairs(vampSpells) do logicHandler.RunConsoleCommandOnPlayer(p.pid, comm) end
            if not vampTalk then logicHandler.RunConsoleCommandOnPlayer(p.pid, 'addspell "vampire sun damage"') end
            if tableHelper.containsValue(p.data.spellbook, 'vampire blood quarra') then
                logicHandler.RunConsoleCommandOnPlayer(p.pid, 'addspell "vampire quarra specials"')
            elseif tableHelper.containsValue(p.data.spellbook, 'vampire blood aundae') then
                logicHandler.RunConsoleCommandOnPlayer(p.pid, 'addspell "vampire aundae specials"')
            elseif tableHelper.containsValue(p.data.spellbook, 'vampire blood berne') then
                logicHandler.RunConsoleCommandOnPlayer(p.pid, 'addspell "vampire berne specials"')
            end
        elseif tableHelper.containsValue(p.data.spellbook, 'werewolf blood') and werewolf and not tableHelper.containsValue(p.data.spellbook, 'werewolf resists') then
            local wereSpells = {'set PCWerewolf to 1', 'addspell "werewolf resists"', 'addspell "werewolf regeneration"', 'addspell "werewolf vision"'}
            for _, comm in pairs(wereSpells) do logicHandler.RunConsoleCommandOnPlayer(p.pid, comm) end
        end
    end
end

customEventHooks.registerValidator('OnPlayerCellChange', OnPlayerCellChange)
