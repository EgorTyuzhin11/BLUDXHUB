-- // Load libraries
local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'
local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()

-- // Locals
local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local TPService = game:GetService("TeleportService")
local LocalPlayer = Players.LocalPlayer
local MyName = LocalPlayer.Name

-- // Developer check
local isDev = {
    "BludXfr3",
    "xsxBLUDX",
    "BeachXBlud"
}

local rank = "User"
for _, name in pairs(isDev) do
    if MyName == name then
        rank = "Developer"
        break
    end
end

-- // Watermark
Library.Name = "BludXHub"
Library.version = "1.1"
Library:SetWatermark(Library.Name .. " | " .. MyName .. " | v" .. Library.version .. " | Rank: " .. rank)

-- // Create window
local Window = Library:CreateWindow({
    Title = Library.Name,
    Center = true,
    AutoShow = true,
    TabPadding = 8
})

-- // Tabs / Sections
local Tabs = {
    Main = Window:AddTab('Main'),
    Players = Window:AddTab('Players'),
    Dev = Window:AddTab('Dev')
}

-- Main Tab
local SlidersMain = Tabs.Main:AddLeftGroupbox('Sliders')
local ServerMain = Tabs.Main:AddRightGroupbox('Server')
local MovementMain = Tabs.Main:AddLeftGroupbox('Movement')
local TeleportMain = Tabs.Main:AddRightGroupbox('Teleport')

-- Dev Tab
local ButtonsDev = Tabs.Dev:AddLeftGroupbox('Buttons')

-- Players Tab
local PlayerSection = Tabs.Players:AddLeftGroupbox('Players')
local FriendMenu = Tabs.Players:AddRightGroupbox('Friend Menu')

-- Sliders (Main)
SlidersMain:AddSlider('WalkSpeedSlider', {
    Text = 'Walk Speed',
    Default = 16,
    Min = 16,
    Max = 200,
    Rounding = 0,
    Tooltip = "Adjusts your walking speed",
    Callback = function(WSd)
        local char = LocalPlayer.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.WalkSpeed = WSd
        end
    end
})

SlidersMain:AddSlider('JumpPowerSlider', {
    Text = 'Jump Power',
    Default = 50,
    Min = 50,
    Max = 150,
    Rounding = 0,
    Tooltip = "Allows you to jump higher",
    Callback = function(JPr)
        local char = LocalPlayer.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.UseJumpPower = true
            hum.JumpPower = JPr
        end
    end
})

SlidersMain:AddSlider('HipHeight', {
    Text = 'Hip Height',
    Default = 2,
    Min = 2,
    Max = 20,
    Rounding = 0,
    Tooltip = "Adjusts your character's height above the ground",
    Callback = function(HHt)
        local char = LocalPlayer.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.HipHeight = HHt
        end
    end
})

-- Movement (Noclip)
local noclip = false
local noclipConn
MovementMain:AddToggle('NoclipToggle', {
    Text = 'Noclip Mode',
    Default = false,
    Tooltip = 'Walk through walls',
    Callback = function(state)
        noclip = state

        local function onStep()
            local Char = LocalPlayer.Character
            if Char then
                for _, v in pairs(Char:GetDescendants()) do
                    if v:IsA("BasePart") and v.CanCollide == true then
                        v.CanCollide = false
                    end
                end
            end
        end

        if noclip then
            noclipConn = RunService.Stepped:Connect(onStep)
        else
            if noclipConn then
                noclipConn:Disconnect()
                noclipConn = nil
            end
        end
    end
})

-- Server Buttons
ServerMain:AddButton({
    Text = "Copy PlaceID",
    Tooltip = "Copy current place ID",
    Func = function()
        setclipboard(tostring(game.PlaceId))
        Library:Notify("PlaceID copied!", 2)
    end
})

ServerMain:AddButton({
    Text = "Copy JobID",
    Tooltip = "Copy current session ID",
    Func = function()
        setclipboard(tostring(game.JobId))
        Library:Notify("JobID copied!", 2)
    end
})

ServerMain:AddButton({
    Text = "Copy ServerID",
    Tooltip = "Copy server ID",
    Func = function()
        setclipboard(tostring(game.PlaceId .. ":" .. game.JobId))
        Library:Notify("ServerID copied!", 2)
    end
})

-- Server Inputs
ServerMain:AddInput('PlaceID_Input', {
    Default = "",
    Numeric = true,
    Finished = false,
    Text = 'Enter PlaceID',
    Tooltip = 'Map ID',
    Placeholder = 'PlaceID',
    Callback = function(value)
        local place = tonumber(value)
        if place then
            TPService:Teleport(place)
        end
    end
})

ServerMain:AddInput('JobID_Input', {
    Default = "",
    Numeric = false,
    Finished = false,
    Text = 'Enter JobID',
    Tooltip = 'Session ID',
    Placeholder = 'JobID',
    Callback = function(job)
        if job and job ~= "" then
            TPService:TeleportToPlaceInstance(game.PlaceId, job)
        end
    end
})

ServerMain:AddInput('ServerID_Input', {
    Default = "",
    Numeric = false,
    Finished = false,
    Text = 'Enter ServerID',
    Tooltip = 'Format: PlaceID:JobID',
    Placeholder = 'ServerID',
    Callback = function(serverId)
        local place, job = string.match(serverId, "^(%d+):(.+)$")
        if place and job then
            TPService:TeleportToPlaceInstance(tonumber(place), job)
        end
    end
})

-- Custom Scripts
if true then
    if game.PlaceId == 17663218496 then -- Tsunami
        local Tsunami = Tabs.Main:AddLeftGroupbox("Disaster Ocean")

        -- Кнопка: Телепорт в конец
        Tsunami:AddButton({
            Text = 'Teleport to End',
            DoubleClick = false,
            Tooltip = 'Teleports you to the end',
            Func = function()
                local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.CFrame = CFrame.new(33, 124, -4124)
                    Library:Notify("Teleported to End!", 5)
                else
                    Library:Notify("Character not loaded!", 5)
                end
            end
        })

        -- Кнопка: Телепорт к спавну лодки
        Tsunami:AddButton({
            Text = 'Teleport to Boat Spawn',
            DoubleClick = false,
            Tooltip = 'Teleports you to the boat spawn location',
            Func = function()
                local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.CFrame = CFrame.new(-184, 124, 4558)
                    Library:Notify("Teleported to Boat Spawn!", 5)
                else
                    Library:Notify("Character not loaded!", 5)
                end
            end
        })

        -- Кнопка: Телепорт к ящику
        Tsunami:AddButton({
            Text = 'Teleport to Crate',
            DoubleClick = false,
            Tooltip = 'Teleports you to the crate location',
            Func = function()
                local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.CFrame = CFrame.new(-244, 124, 4567)
                    Library:Notify("Teleported to Crate!", 5)
                else
                    Library:Notify("Character not loaded!", 5)
                end
            end
        })


        local autoSequence = false
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer

        Tsunami:AddToggle("AutoSequenceToggle", {
            Text = "Auto Boat > Request Box > Crate > End > Unload",
            Default = false,
            Tooltip = "Full auto delivery chain"
        }):OnChanged(function(state)
            autoSequence = state

            if autoSequence then
                task.spawn(function()
                    while autoSequence do
                        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        if not hrp then
                            Library:Notify("Character not found", 5)
                            return
                        end

                        -- Step 1: Купить лодку
                        local args = {
                            "echo",
                            CFrame.new(-211.9999237060547, 131, 4443.50048828125)
                        }
                        ReplicatedStorage:WaitForChild("RemoteEvent"):FireServer(unpack(args))
                        Library:Notify("Boat purchased", 3)

                        -- Step 2: Выпрыгнуть из лодки
                        task.wait(2.5)
                        hrp.CFrame = hrp.CFrame * CFrame.new(0, -10, 5) -- выпрыгнуть немного вниз и вперёд
                        Library:Notify("Jumped out of boat", 2)

                        -- Step 4: Телепорт к ящику
                        task.wait(3)
                        hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        if not hrp then return end
                        hrp.CFrame = CFrame.new(-244, 122, 4568)
                        Library:Notify("Moved to crate", 2)

                        -- Step 3: Request Box
                        task.wait(2)
                        for _, v in ipairs(workspace:GetDescendants()) do
                            if v:IsA("ProximityPrompt") and v.ActionText == "Request Box of Supplies" then
                                fireproximityprompt(v, 3)
                                Library:Notify("Requested box", 2)
                                break
                            end
                        end

                        -- Step 6: Тп в конец
                        task.wait(2)
                        hrp.CFrame = CFrame.new(33, 124, -4124)
                        Library:Notify("Teleported to end", 2)

                        -- Step 7: Выгрузка
                        task.wait(2)
                        for _, v in ipairs(workspace:GetDescendants()) do
                            if v:IsA("ProximityPrompt") and v.ActionText == "Unload Ship" then
                                fireproximityprompt(v, 1)
                                Library:Notify("Ship Unloaded", 3)
                                break
                            end
                        end

                        -- Ждём 7.5 секунд перед следующим циклом
                        task.wait(15)
                    end
                end)
            end
        end) end
end

-- Teleport Buttons
local savedCFrame = nil
TeleportMain:AddButton({
    Text = "Save Position",
    Tooltip = "Saves your current position",
    Func = function()
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if hrp then
            savedCFrame = hrp.CFrame
            Library:Notify("Position saved!", 2)
        end
    end
})

TeleportMain:AddButton({
    Text = "Teleport to saved position",
    Tooltip = "Teleports you back to saved position",
    Func = function()
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if savedCFrame and hrp then
            hrp.CFrame = savedCFrame
            Library:Notify("Teleported!", 2)
        else
            Library:Notify("No position saved!", 2)
        end
    end
})

-- // ClickTP Toggle
local ClickTP_Enabled = false

-- Создание переключателя
TeleportMain:AddToggle('ClickTP_Toggle', {
    Text = 'Click TP (hold Left Ctrl)',
    Default = false,
    Tooltip = 'Teleport on click, when you pressed LeftCtrl',
    Callback = function(state)
        ClickTP_Enabled = state
    end
})

-- ClickTP Logic
local function onInput(input, gameProcessed)
    if not ClickTP_Enabled then return end
    if gameProcessed then return end
    if input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
    if not UIS:IsKeyDown(Enum.KeyCode.LeftControl) then return end

    local mouse = LocalPlayer:GetMouse()
    local targetPosition = mouse.Hit and mouse.Hit.Position

    if targetPosition and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(targetPosition + Vector3.new(0, 3, 0))
        Library:Notify("ClickTP Teleported!", 2)
    end
end

UIS.InputBegan:Connect(onInput)


-- Players Tab
local selectedPlayer = nil
local isSpectatingPlayer = false
local FriendName = nil

local function getPlayerList()
    local list = {}
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            table.insert(list, player.Name)
        end
    end
    return list
end

local playerList = getPlayerList()
local firstPlayer = playerList[1] or "None"

local PlayersDropdown = PlayerSection:AddDropdown('PlayersDropdown', {
    Values = playerList,
    Default = firstPlayer,
    Multi = false,
    Text = 'Select Player',
    Tooltip = 'Auto updates',
    Callback = function(value)
        selectedPlayer = Players:FindFirstChild(value)
    end
})

if firstPlayer ~= "None" then
    selectedPlayer = Players:FindFirstChild(firstPlayer)
end

RunService.RenderStepped:Connect(function()
    local dropdown = Options.PlayersDropdown
    if dropdown then
        local current = dropdown.Value
        local newList = getPlayerList()
        if table.concat(newList, ",") ~= table.concat(dropdown.Values, ",") then
            dropdown:SetValues(newList)
            if table.find(newList, current) then
                dropdown:SetValue(current)
            else
                dropdown:SetValue(nil)
                selectedPlayer = nil
            end
        end
    end
end)

-- Labels
local HpLabel = PlayerSection:AddLabel('HP: ?')
local WeaponLabel = PlayerSection:AddLabel('Weapon: ?')
local DistLabel = PlayerSection:AddLabel('Distance: ?')

task.spawn(function()
    while true do
        if selectedPlayer and selectedPlayer.Character then
            local char = selectedPlayer.Character
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            local hp = humanoid and math.floor(humanoid.Health) or "?"

            local tool = char:FindFirstChildOfClass("Tool")
            local weapon = tool and tool.Name or "None"

            local dist = "?"
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("HumanoidRootPart") then
                dist = math.floor((char.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude)
            end

            HpLabel:SetText("HP: " .. tostring(hp))
            WeaponLabel:SetText("Weapon: " .. weapon)
            DistLabel:SetText("Distance: " .. tostring(dist))
        else
            HpLabel:SetText("HP: ?")
            WeaponLabel:SetText("Weapon: ?")
            DistLabel:SetText("Distance: ?")
        end

        task.wait(0.3)
    end
end)

PlayerSection:AddButton({
    Text = 'Teleport',
    Tooltip = 'Teleport to selected player',
    Func = function()
        if selectedPlayer and selectedPlayer.Character and selectedPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.CFrame = selectedPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
                Library:Notify("Teleported to " .. selectedPlayer.Name, 2)
            end
        end
    end
})

PlayerSection:AddButton({
    Text = 'Spectate',
    Tooltip = 'Spectate selected player / cancel',
    Func = function()
        if selectedPlayer and selectedPlayer.Character then
            if not isSpectatingPlayer then
                local humanoid = selectedPlayer.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    workspace.CurrentCamera.CameraSubject = humanoid
                    isSpectatingPlayer = true
                    Library:Notify("Spectating: " .. selectedPlayer.Name, 2)
                end
            else
                local myHumanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if myHumanoid then
                    workspace.CurrentCamera.CameraSubject = myHumanoid
                    isSpectatingPlayer = false
                    Library:Notify("Returned camera to self", 2)
                end
            end
        end
    end
})

PlayerSection:AddButton({
    Text = 'Add as Friend',
    Tooltip = 'Sets selected player as your only friend',
    DoubleClick = true,
    Func = function()
        if selectedPlayer then
            FriendName = selectedPlayer.Name
            currentFriend = selectedPlayer
            Library:Notify(FriendName .. " is now your friend!", 2)
        else
            Library:Notify("No player selected!", 2)
        end
    end
})

-- Friend Menu
local currentFriend = nil
local isSpectatingFriend = false

local friendLabel = FriendMenu:AddLabel("Friend: None")
RunService.RenderStepped:Connect(function()
    if FriendName then
        friendLabel:SetText("Friend: " .. FriendName)
    else
        friendLabel:SetText("Friend: None")
    end
end)

FriendMenu:AddButton({
    Text = 'Teleport to Friend',
    Tooltip = 'Teleport to your friend',
    Func = function()
        if not FriendName then
            Library:Notify("No friend selected!", 2)
            return
        end

        local friendPlayer = Players:FindFirstChild(FriendName)
        if not friendPlayer then
            Library:Notify("Player " .. FriendName .. " not found!", 2)
            return
        end

        local char = friendPlayer.Character
        local friendHRP = char and char:FindFirstChild("HumanoidRootPart")
        local myHRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

        if friendHRP and myHRP then
            myHRP.CFrame = friendHRP.CFrame + Vector3.new(0, 3, 0)
            Library:Notify("Teleported to friend: " .. FriendName, 2)
        else
            Library:Notify("Teleport failed — character not loaded!", 2)
        end
    end
})

FriendMenu:AddButton({
    Text = 'Spectate Friend',
    Tooltip = 'Spectate your friend / cancel',
    Func = function()
        if currentFriend and currentFriend.Character then
            if not isSpectatingFriend then
                local hum = currentFriend.Character:FindFirstChildOfClass("Humanoid")
                if hum then
                    workspace.CurrentCamera.CameraSubject = hum
                    isSpectatingFriend = true
                    Library:Notify("Spectating: " .. currentFriend.Name, 2)
                end
            else
                local myHum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if myHum then
                    workspace.CurrentCamera.CameraSubject = myHum
                    isSpectatingFriend = false
                    Library:Notify("Returned camera to self", 2)
                end
            end
        else
            Library:Notify("No friend selected", 2)
        end
    end
})

FriendMenu:AddButton({
    Text = 'Remove Friend',
    Tooltip = 'Removes your current friend',
    DoubleClick = true,
    Func = function()
        if FriendName then
            Library:Notify(FriendName .. " removed from friends!", 2)
            FriendName = nil
            currentFriend = nil
        else
            Library:Notify("No friend selected!", 2)
        end
    end
})

-- Dev Tab
ButtonsDev:AddButton({
    Text = 'Infinity Yield',
    DoubleClick = false,
    Tooltip = 'Executes a universal script',
    Func = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
        Library:Notify("Infinity Yield executed!", 5)
    end
})

ButtonsDev:AddButton({
    Text = 'Unload Cheat',
    DoubleClick = true,
    Tooltip = 'Disables menu and watermark',
    Func = function()
        local char = LocalPlayer.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        hum.JumpPower = 50
        hum.WalkSpeed = 16
        hum.HipHeight = 2
        Library:Unload()
    end
})

-- //