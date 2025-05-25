local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()

-- Создание окна
local Window = OrionLib:MakeWindow({
    Name = "BludXKey",
    HidePremium = false,
    SaveConfig = true,
    IntroEnabled = false,
    ConfigFolder = "OrionTest"
})

-- Вкладка для ключ-системы
local KeyTab = Window:MakeTab({
    Name = "Ключ-система",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

KeyTab:AddSection({
    Name = "Система проверки ключа"
})

-- Настройки ключа
local CorrectKey = "Ожидание загрузки..."
local UserInputKey = ""
local KeyLoaded = false

-- Загрузка ключа с обработкой ошибок
local function LoadKey()
    local success, result = pcall(function()
        return loadstring(game:HttpGet('https://raw.githubusercontent.com/EgorTyuzhin11/BludXKey/refs/heads/main/Key.lua?token=GHSAT0AAAAAADDW62TUKVGVBUIQZA34VVKS2BS3DGA'))()
    end)
    
    if success then
        CorrectKey = result
        KeyLoaded = true
        OrionLib:MakeNotification({
            Name = "Ключ загружен",
            Content = "Система готова к проверке ключей",
            Image = "rbxassetid://4483345998",
            Time = 5
        })
    else
        CorrectKey = "Ошибка загрузки"
        OrionLib:MakeNotification({
            Name = "Ошибка!",
            Content = "Не удалось загрузить ключ: "..tostring(result),
            Image = "rbxassetid://4483345998",
            Time = 10
        })
    end
end

-- Запускаем загрузку ключа при старте
LoadKey()

-- Функция проверки ключа
local function CheckKey()
    if not KeyLoaded then
        OrionLib:MakeNotification({
            Name = "Ошибка!",
            Content = "Ключ еще не загружен, попробуйте позже",
            Image = "rbxassetid://4483345998",
            Time = 5
        })
        return
    end
    
    if UserInputKey == CorrectKey then
        OrionLib:MakeNotification({
            Name = "Успешно!",
            Content = "Правильный ключ! Запускаю скрипт...",
            Image = "rbxassetid://4483345998",
            Time = 3
        })
        wait(3)
        OrionLib:Destroy()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EgorTyuzhin11/BLUDXHUB/main/BludXHub.lua'))()
    else
        OrionLib:MakeNotification({
            Name = "Ошибка!",
            Content = "Неверный ключ!",
            Image = "rbxassetid://4483345998",
            Time = 5
        })
    end
end

-- Поле для ввода ключа
KeyTab:AddTextbox({
    Name = "Введите ключ",
    Default = "",
    TextDisappear = false,
    Callback = function(Value)
        if Value == "" or Value:match("^%s*$") then
            OrionLib:MakeNotification({
                Name = "Ошибка",
                Content = "Поле ключа не может быть пустым!",
                Image = "rbxassetid://4483345998",
                Time = 5
            })
            return
        end
        
        UserInputKey = Value
        CheckKey()
    end  
})

-- Кнопки управления
KeyTab:AddButton({
    Name = "Обновить ключ",
    Callback = function()
        LoadKey()
    end    
})

KeyTab:AddButton({
    Name = "Скопировать ключ",
    Callback = function()
        if KeyLoaded then
            setclipboard(CorrectKey)
            OrionLib:MakeNotification({
                Name = "Успешно",
                Content = "Ключ скопирован в буфер обмена!",
                Image = "rbxassetid://4483345998",
                Time = 5
            })
        else
            OrionLib:MakeNotification({
                Name = "Ошибка",
                Content = "Ключ еще не загружен!",
                Image = "rbxassetid://4483345998",
                Time = 5
            })
        end
    end    
})

KeyTab:AddButton({
    Name = "Закрыть интерфейс",
    Callback = function()
        OrionLib:Destroy()
    end    
})

-- Уведомление о загрузке
OrionLib:MakeNotification({
    Name = "Система загружена",
    Content = "Идет загрузка ключа...",
    Image = "rbxassetid://4483345998",
    Time = 5
})

-- Инициализация
OrionLib:Init()