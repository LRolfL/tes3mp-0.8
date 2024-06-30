--[[
Written by 'Rolf' for TES3MP 0.8.0/0.8.1.

Description: Adds constant magicka regeneration to players. Adjusts the amount of regeneration and its timing.

Steps:
1. Place this file inside 'server\scripts\custom' folder, located in your TES3MP directory.
2. Open 'customScripts.lua' file ('server\scripts') and write in it the next line: require('custom/magickaRegen')
3. Save the changes and close it.
--]]

local increment = 0.04 -- Numerical multiplier of the magicka regeneration formula.
local delay = 1.14 -- Timer in seconds.

function regenMagicka(pid)
    local player = Players[pid]
    if player then
        local currentMagicka = tes3mp.GetMagickaCurrent(pid)
        local baseMagicka = tes3mp.GetMagickaBase(pid)
        if currentMagicka <= baseMagicka then
            tes3mp.SetMagickaCurrent(pid, currentMagicka + (baseMagicka * (1 - (currentMagicka/baseMagicka)) * increment))
            tes3mp.SendStatsDynamic(pid)
            local timerId = tes3mp.CreateTimerEx('regenMagicka', delay * 1000, 'i', pid)
            tes3mp.StartTimer(timerId)
        end
    end
end

customEventHooks.registerHandler('OnPlayerConnect', function(eventStatus, pid) regenMagicka(pid) end)
