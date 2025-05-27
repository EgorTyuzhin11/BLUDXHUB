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
    end)
end