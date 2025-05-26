local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/jensonhirst/Orion/main/source'))()

-- Create window
local Window = OrionLib:MakeWindow({
    Name = "BludXKey",
    HidePremium = false,
    SaveConfig = true,
    IntroEnabled = false,
    ConfigFolder = "BludXKey"
})

-- Key system tab
local KeyTab = Window:MakeTab({
    Name = "Key System",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

KeyTab:AddSection({
    Name = "Key Verification System"
})

-- Key settings
local CorrectKey = "Loading..."
local UserInputKey = ""
local KeyLoaded = false

-- Load key from GitHub
local function LoadKey()
    local success, result = pcall(function()
        local keyContent = game:HttpGet('https://raw.githubusercontent.com/EgorTyuzhin11/BludXHub/main/Key.txt', true)
        if not keyContent:match("^[%w_]+$") then
            error("Invalid key format")
        end
        return keyContent
    end)

    if success then
        CorrectKey = result
        KeyLoaded = true
        OrionLib:MakeNotification({
            Name = "🔓 Success",
            Content = "Key loaded successfully.",
            Image = "rbxassetid://4483345998",
            Time = 3
        })
    else
        OrionLib:MakeNotification({
            Name = "❌ Error",
            Content = "Failed to load key.",
            Image = "rbxassetid://4483345998",
            Time = 3
        })
    end
end

-- Key check function
local function CheckKey()
    local normalizedInput = UserInputKey:gsub("%s+", ""):upper()
    local normalizedKey = CorrectKey:gsub("%s+", ""):upper()

    if normalizedInput == normalizedKey then
        OrionLib:MakeNotification({
            Name = "🔑 Key Valid!",
            Content = "Launching script in 3 seconds...",
            Image = "rbxassetid://4483345998",
            Time = 3
        })

        wait(3)
        OrionLib:Destroy()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EgorTyuzhin11/BludXHub/main/Hub.lua', true))()
    else
        OrionLib:MakeNotification({
            Name = "❌ Invalid Key",
            Content = "Please try again.",
            Image = "rbxassetid://4483345998",
            Time = 3
        })
    end
end

-- Textbox to input key
KeyTab:AddTextbox({
    Name = "Enter your key",
    Default = "",
    TextDisappear = false,
    Callback = function(Value)
        Value = Value:match("^%s*(.-)%s*$") or ""
        if Value == "" then
            OrionLib:MakeNotification({
                Name = "⚠️ Warning",
                Content = "Please enter a key to continue",
                Image = "rbxassetid://4483345998",
                Time = 3
            })
            return
        end
        UserInputKey = Value
        CheckKey()
    end  
})

-- Copy key button
KeyTab:AddButton({
    Name = "📋 Copy Key",
    Callback = function()
        if KeyLoaded then
            setclipboard(CorrectKey)
            OrionLib:MakeNotification({
                Name = "✅ Copied",
                Content = "Key copied to clipboard: " .. CorrectKey,
                Image = "rbxassetid://4483345998",
                Time = 3
            })
        else
            OrionLib:MakeNotification({
                Name = "⚠️",
                Content = "Key not loaded yet!",
                Image = "rbxassetid://4483345998",
                Time = 3
            })
        end
    end    
})

-- Close button
KeyTab:AddButton({
    Name = "❌ Close",
    Callback = function()
        OrionLib:Destroy()
    end    
})

-- Initial notification
OrionLib:MakeNotification({
    Name = "⚙️ Loading...",
    Content = "Initializing key system...",
    Image = "rbxassetid://4483345998",
    Time = 2
})

-- Load key on startup
LoadKey()

OrionLib:Init()