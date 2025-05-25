-- // Загрузка библиотек
    local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'
    local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()

-- // Локалы
    local UIS = game:GetService("UserInputService")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local MyName = LocalPlayer.Name
-- // Проверка на разработчика
    local isDev = {
        "BludXfr3",
        "xsxBLUDX",
        "BeachXBlud"
    }

    local rank = "Пользователь"
    for _, name in pairs(isDev) do
        if MyName == name then
            rank = "Разработчик"
            break
        end
    end

-- // Ватермарка
    Library.Name = "BludXHub"
    Library.version = "1.0"
    Library:SetWatermark(Library.Name .. " | " .. MyName .. " | v" .. Library.version .." | Ранг: "..rank)
-- // Создание окна
    local Window = Library:CreateWindow({
        Title = Library.Name,
        Center = true,
        AutoShow = true,
        TabPadding = 8})
-- // Создаём вкладки / Секции
    local Tabs = {
        Main = Window:AddTab('Главное'),
        Dev = Window:AddTab('Для разрабов')}
    -- // Вкладка Main
        local SlidersMain = Tabs.Main:AddLeftGroupbox('Слайдеры')
        local ServerMain = Tabs.Main:AddRightGroupbox('Сервер')
    -- // Вкладка Dev
        local ButtonsDev = Tabs.Dev:AddLeftGroupbox('Кнопки')

-- // WalkSpeed -- Main -- Sliders
    SlidersMain:AddSlider('WalkSpeedSlider', {
        Text = 'Скорость ходьбы',
        Default = 16,
        Min = 16,
        Max = 200,
        Rounding = 0,
        Tooltip = "Позволяет изменять скорость ходьбы",
        Callback = function(WSd)
            local char = LocalPlayer.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if hum then
                hum.WalkSpeed = WSd
            end
        end
    })

-- // JumpPower -- Main -- Sliders
    SlidersMain:AddSlider('JumpPowerSlider', {
        Text = 'Высота прыжка',
        Default = 50,
        Min = 50,
        Max = 150,
        Rounding = 0,
        Tooltip = "Позволяет менять высоту прыжка, тоесть прыгать выше",
        Callback = function(JPr)
            local char = LocalPlayer.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if hum then
                hum.UseJumpPower = true
                hum.JumpPower = JPr
            end
        end
    })
-- // Hip Height -- Main -- Sliders
    SlidersMain:AddSlider('HipHeight', {
        Text = 'Высота от пола',
        Default = 2,
        Min = 2,
        Max = 20,
        Rounding = 0,
        Tooltip = "Позволяет изменять вашу высоту",
        Callback = function(HHt)
            local char = LocalPlayer.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if hum then
                hum.HipHeight = HHt
            end
        end
    })
-- // JobID -- Main -- Server
    ServerMain:AddButton({
        Text = "Скопировать PlaceID",
        Tooltip = "Скопировать ID текущего места",
        Func = function()
            setclipboard(tostring(game.PlaceId))
            Library:Notify("PlaceID скопирован!", 2)
        end
    })

    ServerMain:AddButton({
        Text = "Скопировать JobID",
        Tooltip = "Скопировать ID текущей сессии",
        Func = function()
            setclipboard(tostring(game.JobId))
            Library:Notify("JobID скопирован!", 2)
        end
    })

    ServerMain:AddButton({
        Text = "Скопировать ServerID",
        Tooltip = "Скопировать ID сервера",
        Func = function()
            setclipboard(tostring(game.PlaceId .. ":" .. game.JobId))
            Library:Notify("ServerID скопирован!", 2)
        end
    })

    -- // TextBoxes
    ServerMain:AddInput('PlaceID_Input', {
        Default = tostring(game.PlaceId),
        Numeric = true,
        Finished = false,
        Text = 'Введите PlaceID',
        Tooltip = 'ID карты (места)',
        Placeholder = 'PlaceID',
        Callback = function(value)
            local place = tonumber(value)
            if place then
                TPService:Teleport(place)
            end
        end
    })

    ServerMain:AddInput('JobID_Input', {
        Default = tostring(game.JobId),
        Numeric = false,
        Finished = false,
        Text = 'Введите JobID',
        Tooltip = 'ID сервера (сессии)',
        Placeholder = 'JobID',
        Callback = function(job)
            if job and job ~= "" then
                TPService:TeleportToPlaceInstance(game.PlaceId, job)
            end
        end
    })

    ServerMain:AddInput('ServerID_Input', {
        Default = tostring(game.PlaceId .. ":" .. game.JobId),
        Numeric = false,
        Finished = false,
        Text = 'Введите ServerID',
        Tooltip = 'Формат: PlaceID:JobID',
        Placeholder = 'ServerID',
        Callback = function(serverId)
            local place, job = string.match(serverId, "^(%d+):(.+)$")
            if place and job then
                TPService:TeleportToPlaceInstance(tonumber(place), job)
            end
        end
    })

-- // IY Exec -- Dev -- Buttons
    local IYButton = ButtonsDev:AddButton({
        Text = 'Infinity Yield',
        DoubleClick = false,
        Tooltip = 'Запускает лучший универсальный скрипт',
        Func = function()
            loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
            Library:Notify("Infinity Yield запущен!", 5)
        end
    })
-- // Unload Cheat -- Dev -- Buttons
    local UnloadButton = ButtonsDev:AddButton({
        Text = 'Выключить чит',
        DoubleClick = true,
        Tooltip = 'Выключает меню и ватермарку',
        Func = function()
            local char = LocalPlayer.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            hum.JumpPower = 50
            hum.WalkSpeed = 16
            hum.HipHeight = 2
            Library:Unload()
        end
    })