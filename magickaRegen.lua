--[[
Writen by 'Rolf' for TES3MP 0.8.0 and 0.8.1.

Description: Add players magicka regeneration and adjust the amount of regeneration and its timing.

Steps:
1. Place this file inside 'server\scripts\custom' folder, located in your TES3MP directory.
2. Open 'customScripts.lua' file ('server\scripts') and write in it the next line: require("custom/magickaRegen")
3. Save the changes and close it.
--]]

local delay = 1 -- Time delay in seconds. Make it larger or smaller to switch to slower or faster magicka regeneration respectively.
local amount = 1 -- Numerical amount of magicka that is added to the player's current magicka (quantity of regeneration).
local players = {}

local function isLoggedIn(player)
    return player:IsLoggedIn()
end

local function getMagicka(pid)
    return tes3mp.GetMagicka(pid)
end

local function OnServerPostInit()
    -- List of players connected:
    players = tes3mp.GetOnlinePlayerList()
end

local function RegenMagicka(players)
    -- Browse the list of players:
    for _, pid in pairs(players) do
        -- Ensure the player is connected and is not an NPC:
        local player = Players[pid]
        if player and isLoggedIn(player) then
            -- Obtain the player's current magicka:
            local currentMagicka = getMagicka(pid)
            local newMagicka = currentMagicka + amount
            -- Increases player's magicka by 'amount':
            tes3mp.SetMagicka(pid, newMagicka)
        end
    end
end

OnServerPostInit()

-- Executes the function every certain time (defined in 'delay'):
tes3mp.StartTimer(delay, function() RegenMagicka(players) end, players)
