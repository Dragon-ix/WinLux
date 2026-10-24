function Initialize()
    local userProfile = os.getenv("USERPROFILE")
    transcodedPath = userProfile .. "\\AppData\\Roaming\\Microsoft\\Windows\\Themes\\TranscodedWallpaper"
    
    -- Replace 224019 with the exact 'Current:' number shown in your Debug HUD
    targetSize = 592913
end

function GetFileSize(path)
    local file = io.open(path, "rb")
    if not file then return -1 end
    local size = file:seek("end")
    file:close()
    return size
end

function Update()
    local currentSize = GetFileSize(transcodedPath)

    -- Matches if current wallpaper size is within 500 bytes of targetSize
    if currentSize > 0 and math.abs(currentSize - targetSize) < 500 then
        SKIN:Bang("!ShowMeter", "Image")
        SKIN:Bang("!Redraw")
        return "STATUS: OVERLAY VISIBLE (" .. currentSize .. ")"
    else
        SKIN:Bang("!HideMeter", "Image")
        SKIN:Bang("!Redraw")
        return "STATUS: HIDDEN (Current: " .. currentSize .. " | Target: " .. targetSize .. ")"
    end
end