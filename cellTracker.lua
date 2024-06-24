--[[
Writen by 'Rolf' for TES3MP 0.8.0 and 0.8.1.

Description: An easy way to know in which cell and region you are moving through the message box.

Steps:
1. Place this file inside 'server\scripts\custom' folder, located in your TES3MP directory.
2. Open 'customScripts.lua' file ('server\scripts') and write in it the next line: require("custom/cellTracker")
3. Save the changes and close it.
--]]

local function OnPlayerCellChange(eventStatus, pid)
    local player = Players[pid]
    if player and player:IsLoggedIn() then
        local currentCell = tes3mp.GetCell(pid)
        local currentRegion = tes3mp.GetRegion(pid) or '?'
        local previousCell = player.previousCell
        player.previousCell = currentCell
        if previousCell then
            tes3mp.MessageBox(pid, -1, 'You moved from ['..previousCell..'] to ['..currentCell..'] on '..currentRegion)
        end
    end
end

customEventHooks.registerHandler('OnPlayerCellChange', OnPlayerCellChange)
