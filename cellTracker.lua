--[[
Written by 'Rolf' for TES3MP 0.8.0/0.8.1.

Description: An easy way to know in which cell and region you are moving through the message box.

Steps:
1. Place this file inside 'server\scripts\custom' folder, located in your TES3MP directory.
2. Open 'customScripts.lua' file ('server\scripts') and write in it the next line: require('custom/cellTracker')
3. Save the changes and close it.
--]]

local function OnPlayerCellChange(_, pid)
    local p = Players[pid]
    if p and p:IsLoggedIn() then
        local currCell = tes3mp.GetCell(pid)
        local currRegion = tes3mp.GetRegion(pid) or '?'
        local prevCell = p.previousCell
        p.previousCell = currCell
        if prevCell then
            tes3mp.MessageBox(pid, -1, 'You moved from ['..prevCell..'] to ['..currCell..'] on '..currRegion)
        end
    end
end

customEventHooks.registerHandler('OnPlayerCellChange', OnPlayerCellChange)
