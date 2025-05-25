local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/jensonhirst/Orion/main/source'))()

-- Создание окна
local Window = OrionLib:MakeWindow({
    Name = "BludXKey",
    HidePremium = false,
    SaveConfig = true,
    IntroEnabled = false,
    ConfigFolder = "BludXKey"
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
        local keyContent = game:HttpGet('https://raw.githubusercontent.com/EgorTyuzhin11/BludXHub/main/Key.txt', true)
        -- Проверяем, что файл содержит только ключ (без лишнего кода)
        if not keyContent:match("^[%w_]+$") then
            error("Некорректный формат ключа")
        end
        return keyContent
    end)
    
    if success then
        CorrectKey = result
        KeyLoaded = true
        OrionLib:MakeNotification({
            Name = "✅ Успешно",
            Content = "Ключ успешно загружен",
            Image = "rbxassetid://4483345998",
            Time = 3
        })
    else
        CorrectKey = "Ошибка загрузки"
        KeyLoaded = false
        OrionLib:MakeNotification({
            Name = "❌ Ошибка",
            Content = "Не удалось загрузить ключ: "..tostring(result):sub(1, 50),
            Image = "rbxassetid://4483345998",
            Time = 5
        })
    end
end

-- Функция проверки ключа
local function CheckKey()
    if not KeyLoaded then
        OrionLib:MakeNotification({
            Name = "⚠️ Внимание",
            Content = "Ключ еще не загружен. Нажмите 'Обновить'.",
            Image = "rbxassetid://4483345998",
            Time = 3
        })
        return false
    end
    
    -- Нормализация ввода (удаление пробелов, приведение к одному регистру)
    local normalizedInput = UserInputKey:gsub("%s+", ""):upper()
    local normalizedKey = CorrectKey:gsub("%s+", ""):upper()
    
    if normalizedInput == normalizedKey then
        OrionLib:MakeNotification({
            Name = "🔑 Успешно!",
            Content = "Запуск через 3 секунды...",
            Image = "rbxassetid://4483345998",
            Time = 3
        })
        
        wait(3)
        OrionLib:Destroy()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EgorTyuzhin11/BludXHub/main/Hub.lua', true))()

    else
        OrionLib:MakeNotification({
            Name = "❌ Отказано",
            Content = "Неверный ключ доступа",
            Image = "rbxassetid://4483345998",
            Time = 3
        })
        return false
    end
end

-- Поле для ввода ключа
KeyTab:AddTextbox({
    Name = "Введите ключ",
    Default = "",
    TextDisappear = false,
    Callback = function(Value)
        -- Удаляем лишние пробелы в начале и конце
        Value = Value:match("^%s*(.-)%s*$") or ""
        
        if Value == "" then
            OrionLib:MakeNotification({
                Name = "⚠️ Внимание",
                Content = "Введите ключ для продолжения",
                Image = "rbxassetid://4483345998",
                Time = 3
            })
            return
        end
        
        UserInputKey = Value
        CheckKey()
    end  
})

-- Кнопки управления
KeyTab:AddButton({
    Name = "🔄 Обновить ключ",
    Callback = LoadKey
})

KeyTab:AddButton({
    Name = "📋 Скопировать ключ",
    Callback = function()
        if KeyLoaded then
            setclipboard(CorrectKey)
            OrionLib:MakeNotification({
                Name = "✅ Успешно",
                Content = "Ключ скопирован: "..CorrectKey,
                Image = "rbxassetid://4483345998",
                Time = 3
            })
        else
            OrionLib:MakeNotification({
                Name = "⚠️ Внимание",
                Content = "Сначала загрузите ключ",
                Image = "rbxassetid://4483345998",
                Time = 3
            })
        end
    end    
})

KeyTab:AddButton({
    Name = "❌ Закрыть",
    Callback = function()
        OrionLib:Destroy()
    end    
})

-- Первоначальная загрузка
OrionLib:MakeNotification({
    Name = "⚙️ Инициализация",
    Content = "Загрузка системы...",
    Image = "rbxassetid://4483345998",
    Time = 2
})

LoadKey()

OrionLib:Init()
