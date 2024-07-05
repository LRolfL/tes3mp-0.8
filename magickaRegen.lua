--[[
Written by 'Rolf' for TES3MP 0.8.0/0.8.1.

Description: Adds constant magicka regeneration to players. Adjust the amount of regeneration and its timing.

Steps:
1. Place this file inside 'server\scripts\custom' folder, located in your TES3MP directory.
2. Open 'customScripts.lua' file ('server\scripts') and write in it the next line: require('custom/magickaRegen')
3. Save the changes and close it.
--]]

local mult = 0.05 -- Multiplier of the magicka regeneration formula.
local delay = 1 -- Timer in seconds.

function regenMagicka(pid)
    local p = Players[pid]
    if p then
        local currMagicka = tes3mp.GetMagickaCurrent(pid)
        local baseMagicka = p.data.stats.magickaBase
        if currMagicka < baseMagicka then
            tes3mp.SetMagickaCurrent(pid, currMagicka + (baseMagicka * (1 - (currMagicka/baseMagicka)) * mult))
            tes3mp.SendStatsDynamic(pid)
            tes3mp.StartTimer(tes3mp.CreateTimerEx('regenMagicka', delay * 1000, 'i', pid))
        end
    end
end

customEventHooks.registerHandler('OnPlayerConnect', function(_, pid) regenMagicka(pid) end)
