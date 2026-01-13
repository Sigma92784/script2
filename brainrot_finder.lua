-- Save this as "brainrot_finder.lua" or any name you prefer with a .lua extension

--[[
    Brainrot Finder v5.1 (Flat "Titanz" Edition)
    Reorganized and cleaned up for better readability
    Structure: Config -> Services -> Helpers -> Features -> GUI -> Init
]]

-- ============================================================
-- SECTION 1: CONFIGURATION (REVAMPED)
-- ============================================================

-- Initialize global config if it doesn't exist
getgenv().BRAINROT_CONFIG = {
        -- Keybinds
        TELEPORT_KEYBIND       = nil,
        TOGGLE_GUI_KEYBIND     = nil,
        INSTANT_CLONER_KEYBIND = nil,
        KICK_SELF_KEYBIND      = nil,
        FLOOR_STEAL_KEYBIND    = nil,
        REJOIN_KEYBIND         = nil,
        DESYNC_KEYBIND         = nil,

        -- Main Features
        AUTO_TP_ENABLED        = false,
        AUTO_HIDE_ENABLED      = false,
        AUTO_STEAL_ENABLED     = false,
        AUTO_STEAL_NEAREST_ENABLED = false,
        AUTO_STEAL_PRIORITY_ENABLED = false,
        PREDICTIVE_STEAL       = true,
        OptimizerEnabled       = false,
        FLOOR_STEAL_ENABLED    = false,
        AUTO_DESYNC_ENABLED    = false,
        STEAL_SPEED_ENABLED    = false,
        STEAL_DISABLE_ANIM_ENABLED = false,

        GUI_POSITION_X = nil,
        GUI_POSITION_Y = nil,
        MINI_GUI_POSITION_X = nil,
        MINI_GUI_POSITION_Y = nil,
        
        -- Filters
        SHOW_ALL_RARITIES      = true,
        SHOW_MUTATIONS_ONLY    = false,
        SHOW_TRAITS_ONLY       = false,
        MIN_GEN_VALUE          = 0,
        
        -- Priority System
        FAVORITES_PRIORITY_ENABLED = false,
        INVISIBLE_BASE_WALLS_ENABLED = false,
        SAFE_TELEPORT  = true,
        CARPET_MIDDLE  = false,
        
        -- ESP
        ESP_ENABLED         = false,
        ESP_PLAYERS_ENABLED = false,
        
        -- Anti-Lag
        ANTI_LAG_ENABLED    = false,
        ANTI_BEE_DISCO_ENABLED = false,
        ANTI_RAGDOLL_V1_ENABLED = false,
        ANTI_RAGDOLL_V2_ENABLED = false,
}

local PRIORITY_ANIMALS = {
    "Strawberry Elephant",
    "Meowl",
    "Headless Horseman",
    "Dragon Cannelloni",
    "Capitano Moby",
    "Cooki and Milki",
    "La Supreme Combinasion",
    "Burguro and Fryuro",
    "Garama and Madundung",
    "Lavadorito Spinito",
    "Spooky and Pumpky",
    "La Casa Boo",
    "La Secret Combinasion",
    "Chillin Chili",
    "Ketchuru and Musturu",
    "Ketupat Kepat",
    "La Taco Combinasion",
    "Tang Tang Keletang",
    "Tictac Sahur",
    "W or L",
    "Spaghetti Tualetti",
    "Nuclearo Dinossauro",
    "Money Money Puggy"
}

local CONFIG = getgenv().BRAINROT_CONFIG

if not getgenv().BRAINROT_FAVORITES then
    getgenv().BRAINROT_FAVORITES = {}
end

local FAVORITES = getgenv().BRAINROT_FAVORITES

local Config = {
    FAVORITES_FILE = "BrainrotFinderFavorites.json",
    CONFIG_FILE_NAME = "BrainrotFinderConfig.json"
}

local COLORS = {
    Background             = Color3.fromRGB(8, 8, 15),
    BackgroundTransparency = 0.25,
    Surface                = Color3.fromRGB(18, 12, 28),
    SurfaceTransparency    = 0.20,
    Text    = Color3.fromRGB(255, 255, 255),
    TextDim = Color3.fromRGB(230, 230, 240),
    Accent  = Color3.new(0.694118, 0.121569, 1.000000),
    Purple = Color3.new(0.796078, 0.317647, 0.972549),
    Pink   = Color3.fromRGB(255, 140, 255),
    Cyan   = Color3.fromRGB(120, 240, 255),
    Yellow = Color3.fromRGB(255, 235, 120),
    Blue   = Color3.fromRGB(140, 200, 255),
    Red    = Color3.fromRGB(255, 120, 160),
    Success = Color3.fromRGB(120, 255, 200),
    Warning = Color3.fromRGB(255, 215, 120),
    Error   = Color3.fromRGB(255, 120, 160),
}

-- Desync flags
local DESYNC_FLAGS = {
    LargeReplicatorEnabled9 = true,
    GameNetDontSendRedundantNumTimes = 1,
    MaxTimestepMultiplierAcceleration = 2147483647,
    InterpolationFrameVelocityThresholdMillionth = 5,
    CheckPVDifferencesForInterpolationMinRotVelThresholdRadsPerSecHundredth = 1,
    TimestepArbiterVelocityCriteriaThresholdTwoDt = 2147483646,
    GameNetPVHeaderLinearVelocityZeroCutoffExponent = -5000,
    TimestepArbiterHumanoidTurningVelThreshold = 1,
    LargeReplicatorSerializeWrite4 = true,
    SimExplicitlyCappedTimestepMultiplier = 2147483646,
    InterpolationFrameRotVelocityThresholdMillionth = 5,
    ServerMaxBandwith = 52,
    LargeReplicatorSerializeRead3 = true,
    GameNetDontSendRedundantDeltaPositionMillionth = 1,
    PhysicsSenderMaxBandwidthBps = 20000,
    CheckPVCachedVelThresholdPercent = 10,
    NextGenReplicatorEnabledWrite4 = true,
    LargeReplicatorWrite5 = true,
    MaxMissedWorldStepsRemembered = -2147483648,
    StreamJobNOUVolumeCap = 2147483647,
    CheckPVLinearVelocityIntegrateVsDeltaPositionThresholdPercent = 1,
    DisableDPIScale = true,
    WorldStepMax = 30,
    InterpolationFramePositionThresholdMillionth = 5,
    MaxAcceptableUpdateDelay = 1,
    TimestepArbiterOmegaThou = 1073741823,
    CheckPVCachedRotVelThresholdPercent = 10,
    StreamJobNOUVolumeLengthCap = 2147483647,
    S2PhysicsSenderRate = 15000,
    MaxTimestepMultiplierBuoyancy = 2147483647,
    SimOwnedNOUCountThresholdMillionth = 2147483647,
    ReplicationFocusNouExtentsSizeCutoffForPauseStuds = 2147483647,
    LargeReplicatorRead5 = true,
    CheckPVDifferencesForInterpolationMinVelThresholdStudsPerSecHundredth = 1,
    MaxDataPacketPerSend = 2147483647,
    MaxTimestepMultiplierContstraint = 2147483647,
    DebugSendDistInSteps = -2147483648,
    GameNetPVHeaderRotationalVelocityZeroCutoffExponent = -5000,
    AngularVelociryLimit = 360
}

-- ============================================================
-- SECTION 2: SERVICES & MODULES
-- ============================================================

local S = {
    -- Services
    Players           = game:GetService("Players"),
    UserInputService  = game:GetService("UserInputService"),
    TweenService      = game:GetService("TweenService"),
    ReplicatedStorage = game:GetService("ReplicatedStorage"),
    HttpService       = game:GetService("HttpService"),
    RunService        = game:GetService("RunService"),
    Stats             = game:GetService("Stats"),
    TeleportService   = game:GetService("TeleportService"),
    Lighting          = game:GetService("Lighting"),
}

S.Packages = S.ReplicatedStorage:WaitForChild("Packages")
S.Datas    = S.ReplicatedStorage:WaitForChild("Datas")
S.Shared   = S.ReplicatedStorage:WaitForChild("Shared")
S.Utils    = S.ReplicatedStorage:WaitForChild("Utils")

S.Synchronizer  = require(S.Packages:WaitForChild("Synchronizer"))
S.AnimalsData   = require(S.Datas:WaitForChild("Animals"))
S.RaritiesData  = require(S.Datas:WaitForChild("Rarities"))
S.AnimalsShared = require(S.Shared:WaitForChild("Animals"))
S.NumberUtils   = require(S.Utils:WaitForChild("NumberUtils"))

S.LocalPlayer = S.Players.LocalPlayer
S.PlayerGui   = S.LocalPlayer:WaitForChild("PlayerGui")

-- ============================================================
-- SECTION 3: GLOBAL STATE
-- ============================================================

local screenGui, mainFrame, contentFrame
local allAnimalsCache = {}
local guiVisible = true
local currentTab = "animals"
local searchQuery = ""
local isCloning = false
local highestAnimal = nil
local statLabels = nil

local ESP_INSTANCES = {}
local PLAYER_ESP = {}
local ESP_BEST_UID = nil

local stats = {
    totalAnimals  = 0,
    totalValue    = 0,
    highestGen    = 0,
    mutationCount = 0,
    traitCount    = 0,
}

local scannerConnections = {}
local plotChannels = {}
local lastAnimalData = {}

local floatPlatform = nil
local invisibleWallsLoaded = false
local originalTransparency = {}

local InternalStealCache = {}
local AUTO_STEAL_PROX_RADIUS = 20
local PromptMemoryCache = {}
local LastTargetUID = nil
local LastPlayerPosition = nil
local PlayerVelocity = Vector3.zero
local PREDICTION_LOOKAHEAD = 1.25 -- seconds

local STEAL_SPEED = 25.5
local stealSpeedConn = nil

local PLAYER_OUTLINE_MAIN = Color3.fromRGB(220, 120, 255)  -- Vibrant purple
local PLAYER_OUTLINE_SOFT = Color3.new(0.345098, 0.066667, 0.952941)  -- Soft blue

local tweenInfoFast   = TweenInfo.new(0.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
local tweenInfoMedium = TweenInfo.new(0.4, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)

-- ============================================================
-- SECTION 4: CORE HELPER FUNCTIONS
-- ============================================================

local function blendColor(c1, c2, alpha)
    return Color3.new(
        c1.R + (c2.R - c1.R) * alpha,
        c1.G + (c2.G - c1.G) * alpha,
        c1.B + (c2.B - c1.B) * alpha
    )
end

local function applyTitanzTextStyle(el)
    if not el then return end
    if el:IsA("TextLabel") or el:IsA("TextButton") or el:IsA("TextBox") then
        el.TextStrokeColor3 = COLORS.Accent
        local size = el.TextSize
        if el.TextScaled then
            size = math.floor((el.AbsoluteSize.Y / 24) * 18)
        end
        if size <= 14 then
            el.TextStrokeTransparency = 0.65
        elseif size <= 18 then
            el.TextStrokeTransparency = 0.45
        else
            el.TextStrokeTransparency = 0.25
        end
    end
end

local function applyTitanzButtonStyle(frame)
    if not frame or not (frame:IsA("Frame") or frame:IsA("TextButton")) then return end
    
    frame.BackgroundColor3 = blendColor(COLORS.Surface, COLORS.Accent, 0.10)
    frame.BackgroundTransparency = math.clamp(COLORS.SurfaceTransparency + 0.15, 0, 1)
    
    local border = frame:FindFirstChild("TitanzBorder")
    if not border then
        border = Instance.new("UIStroke")
        border.Name = "TitanzBorder"
        border.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        border.Parent = frame
    end
    border.Thickness = 1.5
    border.Color = COLORS.Accent
    border.Transparency = 0.35
    
    if not frame:FindFirstChild("TitanzShadow") then
        local corner = Instance.new("UICorner")
        corner.Name = "TitanzShadow"
        corner.CornerRadius = UDim.new(0, 10)
        corner.Parent = frame
    end
end

local function createElement(className, properties)
    local el = Instance.new(className)
    for k, v in pairs(properties) do
        el[k] = v
    end
    applyTitanzTextStyle(el)
    return el
end

local function tween(el, info, props)
    S.TweenService:Create(el, info, props):Play()
end

local glowingTexts = {}

local function makeTextGlow(textElement, color1, color2, duration, delay)
    color1 = color1 or COLORS.Purple
    color2 = color2 or Color3.fromRGB(255, 100, 255)
    duration = duration or 1.2
    delay = delay or 0
    
    table.insert(glowingTexts, textElement)
    
    task.spawn(function()
        if delay > 0 then task.wait(delay) end
        
        while textElement.Parent do
            tween(textElement, TweenInfo.new(duration, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                TextColor3 = color2
            })
            task.wait(duration)
            tween(textElement, TweenInfo.new(duration, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                TextColor3 = color1
            })
            task.wait(duration)
        end
    end)
end

local function addTextGradient(textElement, color1, color2, rotation)
    rotation = rotation or 45
    
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, color1),
        ColorSequenceKeypoint.new(1, color2)
    })
    gradient.Rotation = rotation
    gradient.Parent = textElement
    
    -- Animated rotating gradient
    task.spawn(function()
        while textElement.Parent and gradient.Parent do
            for rot = rotation, rotation + 360, 2 do
                if not gradient.Parent then break end
                gradient.Rotation = rot
                task.wait(0.03)
            end
        end
    end)
    
    return gradient
end

-- ============================================================
-- NOTIFICATION SYSTEM (REVAMPED)
-- ============================================================

local NOTIFICATION_QUEUE = {}
local NOTIFICATION_ACTIVE = {}
local MAX_NOTIFICATIONS = 5
local NOTIFICATION_DURATION = 3.5

-- Notification types with icons and colors
local NOTIFICATION_TYPES = {
    success = {
        icon = "✔",
        color = COLORS.Success,
        gradient = Color3.fromRGB(100, 255, 150)
    },
    error = {
        icon = "✖",
        color = COLORS.Error,
        gradient = Color3.fromRGB(255, 100, 120)
    },
    warning = {
        icon = "⚠",
        color = COLORS.Warning,
        gradient = Color3.fromRGB(255, 200, 50)
    },
    info = {
        icon = "ℹ",
        color = COLORS.Cyan,
        gradient = Color3.fromRGB(100, 200, 255)
    },
    default = {
        icon = "•",
        color = COLORS.Accent,
        gradient = COLORS.Purple
    }
}

local function getNotificationType(color)
    if not color then return NOTIFICATION_TYPES.default end
    
    -- Match color to type
    if color == COLORS.Pink then return NOTIFICATION_TYPES.success end
    if color == COLORS.Error or color == COLORS.Pink then return NOTIFICATION_TYPES.error end
    if color == COLORS.Warning or color == COLORS.Pink then return NOTIFICATION_TYPES.warning end
    if color == COLORS.Pink then return NOTIFICATION_TYPES.info end
    
    return NOTIFICATION_TYPES.default
end

local function repositionNotifications()
    local yOffset = -100  -- Start from bottom
    
    for i = #NOTIFICATION_ACTIVE, 1, -1 do  -- Reverse order
        local notif = NOTIFICATION_ACTIVE[i]
        if notif and notif.frame and notif.frame.Parent then
            tween(notif.frame, tweenInfoFast, {
                Position = UDim2.new(1, -1600, 1, yOffset)  -- Bottom-right
            })
            yOffset = yOffset - 85  -- Stack upwards
        end
    end
end

local function removeNotification(notif)
    if not notif or not notif.frame then return end
    
    -- Remove from active list
    for i, n in ipairs(NOTIFICATION_ACTIVE) do
        if n == notif then
            table.remove(NOTIFICATION_ACTIVE, i)
            break
        end
    end
    
    -- Animate out
    tween(notif.frame, tweenInfoMedium, {
        Position = UDim2.new(1, -1600, 1, 100),  -- Slide down-right
        BackgroundTransparency = 1
    })
    
    -- Fade out all children
    for _, child in ipairs(notif.frame:GetDescendants()) do
        if child:IsA("TextLabel") or child:IsA("TextButton") then
            tween(child, tweenInfoMedium, { TextTransparency = 1 })
        elseif child:IsA("Frame") or child:IsA("ImageLabel") then
            tween(child, tweenInfoMedium, { BackgroundTransparency = 1 })
        elseif child:IsA("UIStroke") then
            tween(child, tweenInfoMedium, { Transparency = 1 })
        end
    end
    
    task.wait(0.5)
    if notif.frame then
        notif.frame:Destroy()
    end
    
    repositionNotifications()
    
    -- Process queue
    if #NOTIFICATION_QUEUE > 0 then
        local next = table.remove(NOTIFICATION_QUEUE, 1)
        showNotification(next.message, next.color, next.duration)
    end
end

function showNotification(message, color, duration)
    if not screenGui then return end
    
    duration = duration or NOTIFICATION_DURATION
    local notifType = getNotificationType(color)
    
    -- Queue if too many active
    if #NOTIFICATION_ACTIVE >= MAX_NOTIFICATIONS then
        table.insert(NOTIFICATION_QUEUE, {
            message = message,
            color = color,
            duration = duration
        })
        return
    end
    
    local notif = {}
    
    -- Main frame
    notif.frame = createElement("Frame", {
        Size = UDim2.new(0, 360, 0, 75),
        Position = UDim2.new(1, 1600, 1, 100),
        BackgroundColor3 = COLORS.Background,
        BackgroundTransparency = 0.15,
        BorderSizePixel = 0,
        Parent = screenGui,
        ZIndex = 999999999999999,
    })
    
    -- Rounded corners
    createElement("UICorner", {
        CornerRadius = UDim.new(0, 14),
        Parent = notif.frame,
    })
    
    -- Gradient border
    local border = createElement("UIStroke", {
        Name = "GradientBorder",
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Thickness = 2,
        Transparency = 0.3,
        Parent = notif.frame,
    })
    
    local gradient = createElement("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, notifType.color),
            ColorSequenceKeypoint.new(1, notifType.gradient)
        }),
        Rotation = 45,
        Parent = border,
    })
    
    -- Accent bar (left side)
    local accentBar = createElement("Frame", {
        Size = UDim2.new(0, 5, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = notifType.color,
        BorderSizePixel = 0,
        Parent = notif.frame,
    })
    
    createElement("UICorner", {
        CornerRadius = UDim.new(1, 0),
        Parent = accentBar,
    })
    
    createElement("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, notifType.color),
            ColorSequenceKeypoint.new(1, notifType.gradient)
        }),
        Rotation = 90,
        Parent = accentBar,
    })
    
    -- Icon
    local icon = createElement("TextLabel", {
        Size = UDim2.new(0, 40, 0, 40),
        Position = UDim2.new(0, 15, 0.5, -20),
        BackgroundTransparency = 1,
        Text = notifType.icon,
        TextColor3 = notifType.color,
        TextSize = 24,
        Font = Enum.Font.GothamBold,
        TextStrokeTransparency = 0.5,
        TextStrokeColor3 = COLORS.Background,
        Parent = notif.frame,
        ZIndex = 999999999999999,
    })
    makeTextGlow(icon, Color3.fromRGB(255, 140, 255), Color3.fromRGB(180, 220, 255), 1.2, 0.3)
    addTextGradient(icon, Color3.new(0.815686, 0.305882, 1.000000), Color3.fromHSV(0.578947, 0.298039, 1.000000), 45) 
    
    -- Message text
    local messageLabel = createElement("TextLabel", {
        Size = UDim2.new(1, -100, 1, -10),
        Position = UDim2.new(0, 60, 0, 5),
        BackgroundTransparency = 1,
        Text = message,
        TextColor3 = COLORS.Text,
        TextSize = 15,
        Font = Enum.Font.GothamSemibold,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center,
        Parent = notif.frame,
        ZIndex = 999999999999999,
    })
    makeTextGlow(messageLabel, Color3.fromRGB(255, 140, 255), Color3.fromRGB(180, 220, 255), 1.2, 0.3)
    addTextGradient(messageLabel, Color3.new(0.815686, 0.305882, 1.000000), Color3.fromHSV(0.578947, 0.298039, 1.000000), 45) 
    applyTitanzTextStyle(messageLabel)
    
    -- Close button
    local closeButton = createElement("TextButton", {
        Size = UDim2.new(0, 30, 0, 30),
        Position = UDim2.new(1, -40, 0.5, -15),
        BackgroundColor3 = COLORS.Surface,
        BackgroundTransparency = 0.3,
        Text = "×",
        TextColor3 = COLORS.TextDim,
        TextSize = 20,
        Font = Enum.Font.GothamBold,
        BorderSizePixel = 0,
        Parent = notif.frame,
        ZIndex = 999999999999999,
    })
    makeTextGlow(closeButton, Color3.fromRGB(255, 140, 255), Color3.fromRGB(180, 220, 255), 1.2, 0.3)
    addTextGradient(closeButton, Color3.new(0.815686, 0.305882, 1.000000), Color3.fromHSV(0.578947, 0.298039, 1.000000), 45) 
    
    createElement("UICorner", {
        CornerRadius = UDim.new(1, 0),
        Parent = closeButton,
    })
    
    -- Close button hover effect
    closeButton.MouseEnter:Connect(function()
        tween(closeButton, tweenInfoFast, {
            BackgroundTransparency = 0.1,
            TextColor3 = COLORS.Red
        })
    end)
    
    closeButton.MouseLeave:Connect(function()
        tween(closeButton, tweenInfoFast, {
            BackgroundTransparency = 0.3,
            TextColor3 = COLORS.TextDim
        })
    end)
    
    closeButton.MouseButton1Click:Connect(function()
        removeNotification(notif)
    end)
    
    -- Progress bar
    local progressBar = createElement("Frame", {
        Size = UDim2.new(1, 0, 0, 3),
        Position = UDim2.new(0, 0, 1, -3),
        BackgroundColor3 = notifType.color,
        BorderSizePixel = 0,
        Parent = notif.frame,
        ZIndex = 999999999999999,
    })
    
    createElement("UICorner", {
        CornerRadius = UDim.new(1, 0),
        Parent = progressBar,
    })
    
    createElement("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, notifType.color),
            ColorSequenceKeypoint.new(1, notifType.gradient)
        }),
        Rotation = 0,
        Parent = progressBar,
    })
    
    -- Add to active list
    table.insert(NOTIFICATION_ACTIVE, notif)
    
    -- Animate in
    notif.frame.BackgroundTransparency = 1
    for _, child in ipairs(notif.frame:GetDescendants()) do
        if child:IsA("TextLabel") or child:IsA("TextButton") then
            child.TextTransparency = 1
        elseif child:IsA("Frame") and child ~= notif.frame then
            child.BackgroundTransparency = 1
        elseif child:IsA("UIStroke") then
            tween(child, tweenInfoMedium, { Transparency = 1 })
        end
    end
    
    local targetY = -100 - (#NOTIFICATION_ACTIVE - 1) * 85  -- Stack upwards

    tween(notif.frame, tweenInfoMedium, {
        Position = UDim2.new(1, -1600, 1, targetY),  -- Bottom-right
        BackgroundTransparency = 0.15
    })
    
    for _, child in ipairs(notif.frame:GetDescendants()) do
        if child:IsA("TextLabel") or child:IsA("TextButton") then
            tween(child, tweenInfoMedium, { TextTransparency = 0 })
        elseif child:IsA("Frame") and child ~= notif.frame and child ~= progressBar then
            tween(child, tweenInfoMedium, { BackgroundTransparency = 0 })
        elseif child:IsA("UIStroke") then
            tween(child, tweenInfoMedium, { Transparency = 0.3 })
        end
    end
    
    -- Animate progress bar
    task.spawn(function()
        tween(progressBar, TweenInfo.new(duration, Enum.EasingStyle.Linear), {
            Size = UDim2.new(0, 0, 0, 3)
        })
    end)
    
    -- Auto-remove after duration
    task.delay(duration, function()
        removeNotification(notif)
    end)
end

-- Shorthand functions for specific notification types
local function notifySuccess(message, duration)
    showNotification(message, COLORS.Success, duration)
end

local function notifyError(message, duration)
    showNotification(message, COLORS.Error, duration)
end

local function notifyWarning(message, duration)
    showNotification(message, COLORS.Warning, duration)
end

local function notifyInfo(message, duration)
    showNotification(message, COLORS.Cyan, duration)
end

-- Export to global scope
getgenv().ShowNotification = showNotification
getgenv().NotifySuccess = notifySuccess
getgenv().NotifyError = notifyError
getgenv().NotifyWarning = notifyWarning
getgenv().NotifyInfo = notifyInfo

-- ============================================================
-- SECTION 5: CONFIG MANAGEMENT (REVAMPED)
-- ============================================================

local function saveConfig()
    local serializableConfig = {}
    
    for k, v in pairs(CONFIG) do
        if typeof(v) == "EnumItem" then
            serializableConfig[k] = {
                _type = "EnumItem",
                _enumType = tostring(v.EnumType),
                _name = v.Name
            }
        else
            -- Save all values including nil
            serializableConfig[k] = v
        end
    end
    
    local success, jsonData = pcall(S.HttpService.JSONEncode, S.HttpService, serializableConfig)
    if success then
        writefile(Config.CONFIG_FILE_NAME, jsonData)
        print("[Config] Saved successfully") -- Debug
    else
        warn("[Config] Failed to save:", jsonData)
    end
end

local function loadConfig()
    if not isfile(Config.CONFIG_FILE_NAME) then 
        print("[Config] No config file found, using defaults")
        return 
    end
    
    local success, jsonData = pcall(readfile, Config.CONFIG_FILE_NAME)
    if not success or not jsonData then 
        warn("[Config] Failed to read config file")
        return 
    end
    
    local success2, savedConfig = pcall(S.HttpService.JSONDecode, S.HttpService, jsonData)
    if not success2 or not savedConfig then 
        warn("[Config] Failed to decode config file")
        return 
    end
    
    for k, v in pairs(savedConfig) do
        if type(v) == "table" and v._type == "EnumItem" then
            -- Restore EnumItem
            local enumType = v._enumType
            local enumName = v._name
            
            if enumType == "KeyCode" and Enum.KeyCode[enumName] then
                CONFIG[k] = Enum.KeyCode[enumName]
            end
        else
            -- Load all values including nil
            CONFIG[k] = v
        end
    end
    
    -- Update global reference
    getgenv().BRAINROT_CONFIG = CONFIG
    
    print("[Config] Loaded successfully")
    print("[Config] GUI_POSITION_X:", CONFIG.GUI_POSITION_X)
    print("[Config] GUI_POSITION_Y:", CONFIG.GUI_POSITION_Y)
end

-- Save GUI position
local function saveGuiPosition()
    if not mainFrame then return end
    
    -- Get the actual screen position (accounting for scale)
    local pos = mainFrame.AbsolutePosition
    local scale = 1
    
    -- Check if there's a UIScale applied
    local uiScale = mainFrame:FindFirstChildOfClass("UIScale")
    if uiScale then
        scale = uiScale.Scale
    end
    
    -- Save unscaled position
    CONFIG.GUI_POSITION_X = pos.X / scale
    CONFIG.GUI_POSITION_Y = pos.Y / scale
    
    saveConfig()
end

local miniGuiContainer = nil -- Will be set when mini GUI is created

local function saveMiniGuiPosition()
    if not miniGuiContainer then return end
    
    local pos = miniGuiContainer.AbsolutePosition
    local scale = 1
    
    -- Check if there's a UIScale applied
    local uiScale = miniGuiContainer:FindFirstChildOfClass("UIScale")
    if uiScale then
        scale = uiScale.Scale
    end
    
    -- Save unscaled position
    CONFIG.MINI_GUI_POSITION_X = pos.X / scale
    CONFIG.MINI_GUI_POSITION_Y = pos.Y / scale
    
    saveConfig()
end

local function saveFavorites()
    local success, jsonData = pcall(S.HttpService.JSONEncode, S.HttpService, FAVORITES)
    if success then
        writefile(Config.FAVORITES_FILE, jsonData)
    else
        warn("[Favorites] Failed to save:", jsonData)
    end
end

local function loadFavorites()
    if not isfile(Config.FAVORITES_FILE) then 
        print("[Favorites] No favorites file found")
        return 
    end
    
    local success, jsonData = pcall(readfile, Config.FAVORITES_FILE)
    if not success or not jsonData then 
        warn("[Favorites] Failed to read favorites file")
        return 
    end
    
    local success2, savedFavorites = pcall(S.HttpService.JSONDecode, S.HttpService, jsonData)
    if success2 and savedFavorites then
        for _, name in ipairs(savedFavorites) do
            table.insert(FAVORITES, name)
        end
        
        -- Update global reference
        getgenv().BRAINROT_FAVORITES = FAVORITES
        
        print("[Favorites] Loaded", #FAVORITES, "items")
    else
        warn("[Favorites] Failed to decode favorites file")
    end
end

-- Helper function to update config value
local function updateConfig(key, value)
    CONFIG[key] = value
    getgenv().BRAINROT_CONFIG[key] = value
    saveConfig()
    return true
end

-- Helper function to get config value
local function getConfig(key)
    return CONFIG[key]
end

-- Debug function to print current config
local function debugConfig()
    print("============ CURRENT CONFIG ============")
    for k, v in pairs(CONFIG) do
        print(string.format("%s = %s", k, tostring(v)))
    end
    print("========================================")
end

-- Export helper functions to global scope if needed
getgenv().UpdateBrainrotConfig = updateConfig
getgenv().GetBrainrotConfig = getConfig
getgenv().DebugBrainrotConfig = debugConfig

-- ============================================================
-- SECTION 6: FAVORITES MANAGEMENT
-- ============================================================

local function isFavorite(animalName)
    for _, name in ipairs(FAVORITES) do
        if name:lower() == animalName:lower() then
            return true
        end
    end
    return false
end

local function addFavorite(animalName)
    for _, name in ipairs(FAVORITES) do
        if name:lower() == animalName:lower() then
            if showNotification then
                showNotification("Already in favorites: " .. animalName, COLORS.Yellow)
            end
            return false
        end
    end
    
    table.insert(FAVORITES, animalName)
    saveFavorites()
    
    if showNotification then
        showNotification("🠐 Added to favorites: " .. animalName, COLORS.Cyan)
    end
    
    return true
end

local function removeFavorite(animalName)
    for i, name in ipairs(FAVORITES) do
        if name:lower() == animalName:lower() then
            table.remove(FAVORITES, i)
            saveFavorites()
            if showNotification then
                showNotification("🝚 Removed from favorites: " .. animalName, COLORS.Red)
            end
            return true
        end
    end
    return false
end

local function moveFavoriteUp(index)
    if index > 1 and index <= #FAVORITES then
        FAVORITES[index], FAVORITES[index - 1] = FAVORITES[index - 1], FAVORITES[index]
        saveFavorites()
        return true
    end
    return false
end

local function moveFavoriteDown(index)
    if index >= 1 and index < #FAVORITES then
        FAVORITES[index], FAVORITES[index + 1] = FAVORITES[index + 1], FAVORITES[index]
        saveFavorites()
        return true
    end
    return false
end

local function getFavoriteByPriority()
    for _, favName in ipairs(FAVORITES) do
        for _, animal in ipairs(allAnimalsCache) do
            if animal.name:lower() == favName:lower() then
                return animal
            end
        end
    end
    return nil
end

-- ============================================================
-- SECTION 7: DESYNC SYSTEM
-- ============================================================

local function runDesyncEngine()
    for key, value in pairs(DESYNC_FLAGS) do
        pcall(function()
            setfflag(tostring(key), tostring(value))
        end)
    end
end

local function createDesyncIndicator()
    if not screenGui then return end
    
    if screenGui:FindFirstChild("DesyncIndicator") then
        return
    end
    
    local isMobile = S.UserInputService.TouchEnabled and not S.UserInputService.KeyboardEnabled
    local isTablet = S.UserInputService.TouchEnabled and workspace.CurrentCamera.ViewportSize.X >= 768
    
    local indicatorWidth = isMobile and 200 or (isTablet and 220 or 210)
    local indicatorHeight = 50
    
    local indicator = createElement("Frame", {
        Name = "DesyncIndicator",
        Size = UDim2.new(0, indicatorWidth, 0, indicatorHeight),
        Position = UDim2.new(0.5, -indicatorWidth/2, 0, isMobile and 90 or (isTablet and 130 or 125)),
        BackgroundColor3 = COLORS.Background,
        BackgroundTransparency = 0.15,
        BorderSizePixel = 0,
        ZIndex = 999999999999999,
        Parent = screenGui,
    })
    
    createElement("UICorner", {
        CornerRadius = UDim.new(0, 12),
        Parent = indicator,
    })
    
    -- Simple animated border
    local border = createElement("UIStroke", {
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Thickness = 2,
        Color = COLORS.Purple,
        Transparency = 0.3,
        Parent = indicator,
    })
    
    -- Rotating gradient on border
    local gradient = createElement("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(220, 120, 255)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(120, 240, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(220, 120, 255))
        }),
        Rotation = 0,
        Parent = border,
    })
    
    task.spawn(function()
        while indicator.Parent do
            for i = 0, 360, 3 do
                if not indicator.Parent then break end
                gradient.Rotation = i
                task.wait(0.01)
            end
        end
    end)
    
    -- Icon
    local icon = createElement("TextLabel", {
        Size = UDim2.new(0, 35, 0, 35),
        Position = UDim2.new(0, 12, 0.5, -17.5),
        BackgroundTransparency = 1,
        Text = "BK's",
        TextColor3 = Color3.fromRGB(220, 120, 255),
        TextSize = 22,
        Font = Enum.Font.GothamBold,
        Parent = indicator,
        ZIndex = 999999999999999,
    })
    
    -- Title
    local title = createElement("TextLabel", {
        Size = UDim2.new(1, -55, 0, 20),
        Position = UDim2.new(0, 60, 0, 8),
        BackgroundTransparency = 1,
        Text = "Desync V3",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = isMobile and 13 or 14,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = indicator,
        ZIndex = 999999999999999,
    })
    makeTextGlow(title, Color3.fromRGB(255, 140, 255), Color3.fromRGB(180, 220, 255), 1.2, 0.3)
    addTextGradient(title, Color3.new(0.815686, 0.305882, 1.000000), Color3.fromHSV(0.578947, 0.298039, 1.000000), 45) 
    applyTitanzTextStyle(title)
    
    -- Status
    local status = createElement("TextLabel", {
        Size = UDim2.new(1, -55, 0, 16),
        Position = UDim2.new(0, 60, 0, 28),
        BackgroundTransparency = 1,
        Text = "ACTIVE • NO LAGBACK",
        TextColor3 = Color3.fromRGB(120, 255, 200),
        TextSize = isMobile and 10 or 11,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = indicator,
        ZIndex = 999999999999999,
    })
    makeTextGlow(status, Color3.fromRGB(255, 140, 255), Color3.fromRGB(180, 220, 255), 1.2, 0.3)
    addTextGradient(status, Color3.new(0.815686, 0.305882, 1.000000), Color3.fromHSV(0.578947, 0.298039, 1.000000), 45) 
    applyTitanzTextStyle(status)
    
    -- Simple glow animation
    task.spawn(function()
        while indicator.Parent do
            tween(icon, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                TextColor3 = Color3.fromRGB(255, 180, 255)
            })
            task.wait(1)
            tween(icon, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                TextColor3 = Color3.fromRGB(220, 120, 255)
            })
            task.wait(1)
        end
    end)
    
    -- Fade in
    indicator.BackgroundTransparency = 1
    border.Transparency = 1
    icon.TextTransparency = 1
    title.TextTransparency = 1
    status.TextTransparency = 1
    
    tween(indicator, tweenInfoMedium, { BackgroundTransparency = 0.15 })
    tween(border, tweenInfoMedium, { Transparency = 0.3 })
    tween(icon, tweenInfoMedium, { TextTransparency = 0 })
    tween(title, tweenInfoMedium, { TextTransparency = 0 })
    tween(status, tweenInfoMedium, { TextTransparency = 0 })
    
    return indicator
end

local function enableDesync()
    task.spawn(runDesyncEngine)
    showNotification("Desync Enabled", COLORS.Accent)
    
    -- Show permanent tuff desync indicator
    task.spawn(createDesyncIndicator)
end

-- ============================================================
-- SECTION 8: ESP SYSTEM
-- ============================================================

local function isMyBaseAnimal(animalData)
    if not animalData or not animalData.plot then
        return false
    end
    
    local plots = workspace:FindFirstChild("Plots")
    if not plots then
        return false
    end
    
    local plot = plots:FindFirstChild(animalData.plot)
    if not plot then
        return false
    end
    
    -- PRIMARY METHOD: Use Synchronizer to check owner (most reliable)
    local channel = S.Synchronizer:Get(plot.Name)
    if channel then
        local owner = channel:Get("Owner")
        if owner then
            -- Check if owner matches LocalPlayer by comparing UserId (more reliable than Name)
            if typeof(owner) == "Instance" and owner:IsA("Player") then
                return owner.UserId == S.LocalPlayer.UserId
            elseif typeof(owner) == "table" and owner.UserId then
                return owner.UserId == S.LocalPlayer.UserId
            elseif typeof(owner) == "Instance" then
                return owner == S.LocalPlayer
            end
        end
    end
    
    -- FALLBACK METHOD: Check PlotSign.YourBase
    local sign = plot:FindFirstChild("PlotSign")
    if sign then
        local yourBase = sign:FindFirstChild("YourBase")
        if yourBase and yourBase:IsA("BillboardGui") then
            return yourBase.Enabled == true
        end
    end
    
    return false
end

local function clearESPForUID(uid)
    local rec = ESP_INSTANCES[uid]
    if not rec then return end
    if rec.highlight then pcall(function() rec.highlight:Destroy() end) end
    if rec.billboard then pcall(function() rec.billboard:Destroy() end) end
    ESP_INSTANCES[uid] = nil
end

local function clearAllESP()
    for uid in pairs(ESP_INSTANCES) do
        clearESPForUID(uid)
    end
    ESP_BEST_UID = nil
end

local function getPodiumWorldPart(animal)
    if not animal.plot or not animal.slot then return nil end
    
    local plot = workspace.Plots:FindFirstChild(animal.plot)
    if not plot then return nil end
    
    local podiums = plot:FindFirstChild("AnimalPodiums")
    if not podiums then return nil end
    
    local podium = podiums:FindFirstChild(animal.slot)
    if not podium then return nil end
    
    local base = podium:FindFirstChild("Base")
    if not base then return podium end
    
    local spawn = base:FindFirstChild("Spawn")
    return spawn or base or podium
end

local function refreshAllESP()
    if not screenGui then return end
    
    if not CONFIG.ESP_ENABLED then
        clearAllESP()
        return
    end
    
    local activeUIDs = {}
    local bestAnimal = nil
    
    -- Find best animal that's NOT from your base
    for _, animalData in ipairs(allAnimalsCache) do
        if not isMyBaseAnimal(animalData) then
            bestAnimal = animalData
            break
        end
    end
    
    ESP_BEST_UID = bestAnimal and bestAnimal.uid or nil
    
    for _, animalData in ipairs(allAnimalsCache) do
        -- CRITICAL: Skip your own base animals
        if isMyBaseAnimal(animalData) then
            continue
        end
        
        if (animalData.uid == ESP_BEST_UID) or (animalData.genValue >= 50000000) then
            local uid = animalData.uid
            activeUIDs[uid] = true
            
            local rec = ESP_INSTANCES[uid]
            local model = getPodiumWorldPart(animalData)
            
            if not model then
                if rec then clearESPForUID(uid) end
                ESP_INSTANCES[uid] = nil
            else
                if not rec or rec.part ~= model then
                    if rec then clearESPForUID(uid) end
                    
                    rec = { part = model }
                    
                    -- Add highlight for better visibility
                    local highlight = Instance.new("Highlight")
                    highlight.Adornee = model
                    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    highlight.FillTransparency = 0.7
                    highlight.FillColor = Color3.fromRGB(220, 120, 255)
                    highlight.OutlineTransparency = 0.5
                    highlight.OutlineColor = Color3.fromRGB(255, 180, 255)
                    highlight.Parent = screenGui
                    rec.highlight = highlight
                    
                    local bb = Instance.new("BillboardGui")
                    bb.Name = "BrainrotESP"
                    bb.Adornee = model
                    bb.AlwaysOnTop = true
                    bb.Size = UDim2.new(0, 220, 0, 80)
                    bb.SizeOffset = Vector2.new(0, 0)
                    bb.StudsOffset = Vector3.new(0, 3.5, 0)
                    bb.Parent = screenGui
                    
                    -- Background frame with gradient
                    local bgFrame = Instance.new("Frame")
                    bgFrame.Size = UDim2.new(1, 0, 1, 0)
                    bgFrame.BackgroundColor3 = Color3.fromRGB(100, 50, 150)
                    bgFrame.BackgroundTransparency = 0.8
                    bgFrame.BorderSizePixel = 0
                    bgFrame.Parent = bb
                    
                    -- Gradient overlay
                    local gradient = Instance.new("UIGradient")
                    gradient.Color = ColorSequence.new({
                        ColorSequenceKeypoint.new(0, Color3.fromRGB(150, 80, 200)),
                        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(100, 180, 255)),
                        ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 200, 150))
                    })
                    gradient.Rotation = 45
                    gradient.Parent = bgFrame
                    
                    local corner = Instance.new("UICorner")
                    corner.CornerRadius = UDim.new(0, 10)
                    corner.Parent = bgFrame
                    
                    local stroke = Instance.new("UIStroke")
                    stroke.Color = Color3.fromRGB(255, 255, 255)
                    stroke.Thickness = 2
                    stroke.Transparency = 0.4
                    stroke.Parent = bgFrame
                    
                    -- Add animated gradient rotation
                    task.spawn(function()
                        while bgFrame.Parent do
                            for rot = 45, 405, 2 do
                                if not bgFrame.Parent then break end
                                gradient.Rotation = rot
                                task.wait(0.03)
                            end
                        end
                    end)
                    
                    local nameLabel = Instance.new("TextLabel")
                    nameLabel.Size = UDim2.new(1, -10, 0.5, 0)
                    nameLabel.Position = UDim2.new(0, 5, 0, 5)
                    nameLabel.BackgroundTransparency = 1
                    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    nameLabel.TextScaled = true
                    nameLabel.Font = Enum.Font.GothamBold
                    nameLabel.TextStrokeTransparency = 0
                    nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
                    nameLabel.Parent = bgFrame
                    makeTextGlow(nameLabel, Color3.fromRGB(255, 140, 255), Color3.fromRGB(180, 220, 255), 1.2, 0.3)
                    addTextGradient(nameLabel, Color3.new(0.815686, 0.305882, 1.000000), Color3.fromHSV(0.578947, 0.298039, 1.000000), 45) 
                    applyTitanzTextStyle(nameLabel)
                    
                    local genLabel = Instance.new("TextLabel")
                    genLabel.Size = UDim2.new(1, -10, 0.5, -5)
                    genLabel.Position = UDim2.new(0, 5, 0.5, 0)
                    genLabel.BackgroundTransparency = 1
                    genLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    genLabel.TextScaled = true
                    genLabel.Font = Enum.Font.GothamBold
                    genLabel.TextStrokeTransparency = 0
                    genLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
                    genLabel.Parent = bgFrame
                    applyTitanzTextStyle(genLabel)
                    
                    rec.billboard = bb
                    rec.labelName = nameLabel
                    rec.labelGen = genLabel
                    
                    ESP_INSTANCES[uid] = rec
                end
                
                rec.labelName.Text = animalData.name
                rec.labelGen.Text = animalData.genText
            end
        end
    end
    
    for uid in pairs(ESP_INSTANCES) do
        if not activeUIDs[uid] then
            clearESPForUID(uid)
        end
    end
end

-- ============================================================
-- SECTION 9: PLAYER ESP
-- ============================================================

local function clearPlayerESP(plr)
    local rec = PLAYER_ESP[plr]
    if not rec then return end
    
    if rec.highlightMain then pcall(function() rec.highlightMain:Destroy() end) end
    if rec.highlightSoft then pcall(function() rec.highlightSoft:Destroy() end) end
    if rec.billboard then pcall(function() rec.billboard:Destroy() end) end
    
    PLAYER_ESP[plr] = nil
end

local function clearAllPlayerESP()
    for plr in pairs(PLAYER_ESP) do
        clearPlayerESP(plr)
    end
end

local function createPlayerESP(plr)
    local char = plr.Character
    if not char then return end
    
    local hrp = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("UpperTorso") or char.PrimaryPart
    if not hrp then return end
    
    local rec = {}
    
    local hMain = Instance.new("Highlight")
    hMain.Adornee = char
    hMain.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hMain.FillTransparency = 1
    hMain.OutlineTransparency = 0
    hMain.OutlineColor = PLAYER_OUTLINE_MAIN
    hMain.Parent = screenGui
    rec.highlightMain = hMain
    
    local hSoft = Instance.new("Highlight")
    hSoft.Adornee = char
    hSoft.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hSoft.FillTransparency = 1
    hSoft.OutlineTransparency = 0
    hSoft.OutlineColor = PLAYER_OUTLINE_SOFT
    hSoft.Parent = screenGui
    rec.highlightSoft = hSoft
    
    local bb = Instance.new("BillboardGui")
    bb.Size = UDim2.new(0, 160, 0, 32)
    bb.Adornee = hrp
    bb.AlwaysOnTop = true
    bb.StudsOffset = Vector3.new(0, 3.2, 0)
    bb.Parent = screenGui
    rec.billboard = bb
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 1, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.TextColor3 = Color3.fromRGB(120, 240, 255)  -- Bright cyan
    nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    nameLabel.TextStrokeTransparency = 0.3
    nameLabel.TextScaled = true
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.Text = plr.Name
    nameLabel.Parent = bb
    makeTextGlow(nameLabel, Color3.fromRGB(255, 140, 255), Color3.fromRGB(180, 220, 255), 1.2, 0.3)
    addTextGradient(nameLabel, Color3.new(0.815686, 0.305882, 1.000000), Color3.fromHSV(0.578947, 0.298039, 1.000000), 45) 
    applyTitanzTextStyle(nameLabel)
    rec.nameLabel = nameLabel
    
    PLAYER_ESP[plr] = rec
end

local function refreshPlayerESP()
    if not CONFIG.ESP_PLAYERS_ENABLED then
        clearAllPlayerESP()
        return
    end
    
    for _, plr in ipairs(S.Players:GetPlayers()) do
        if plr ~= S.LocalPlayer then
            if not PLAYER_ESP[plr] then
                createPlayerESP(plr)
            end
        end
    end
    
    local myChar = S.LocalPlayer.Character
    local myHRP = myChar and (myChar:FindFirstChild("HumanoidRootPart") or myChar:FindFirstChild("UpperTorso") or myChar.PrimaryPart)
    
    for plr, rec in pairs(PLAYER_ESP) do
        local char = plr.Character
        local hrp = char and (char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("UpperTorso") or char.PrimaryPart)
        
        if not char or not hrp or not myHRP then
            clearPlayerESP(plr)
        else
            local dist = (myHRP.Position - hrp.Position).Magnitude
            local distInt = math.floor(dist + 0.5)
            
            if rec.nameLabel then
                rec.nameLabel.Text = string.format("%s [%dm]", plr.Name, distInt)
            end
        end
    end
end

local function playerESPHeartbeat()
    if CONFIG.ESP_PLAYERS_ENABLED then
        refreshPlayerESP()
    end
end

-- ============================================================
-- SECTION 10: FLOOR STEAL & INVISIBLE WALLS
-- ============================================================

local function getHRP()
    local c = S.LocalPlayer.Character
    if not c then return end
    return c:FindFirstChild("HumanoidRootPart") or c:FindFirstChild("UpperTorso")
end

local function startFloorSteal()
    if floatPlatform then floatPlatform:Destroy() end
    
    floatPlatform = Instance.new("Part")
    floatPlatform.Size = Vector3.new(6, 1, 6)
    floatPlatform.Anchored = true
    floatPlatform.CanCollide = true
    floatPlatform.Transparency = 1
    floatPlatform.Parent = workspace
    
    task.spawn(function()
        while CONFIG.FLOOR_STEAL_ENABLED and floatPlatform do
            local hrp = getHRP()
            if hrp then
                floatPlatform.Position = hrp.Position - Vector3.new(0, 3, 0)
            end
            task.wait(0.05)
        end
    end)
end

local function stopFloorSteal()
    if floatPlatform then
        floatPlatform:Destroy()
        floatPlatform = nil
    end
end

local function isBaseWall(obj)
    if not obj:IsA("BasePart") then return false end
    local n = obj.Name:lower()
    local parent = obj.Parent and obj.Parent.Name:lower() or ""
    return n:find("base") or parent:find("base")
end

local function tryApplyInvisibleWalls()
    if not CONFIG.INVISIBLE_BASE_WALLS_ENABLED then return end
    
    local plots = workspace:FindFirstChild("Plots")
    if not plots then return end
    if #plots:GetChildren() == 0 then return end
    
    if invisibleWallsLoaded then return end
    invisibleWallsLoaded = true
    
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Anchored and obj.CanCollide and isBaseWall(obj) then
            originalTransparency[obj] = obj.LocalTransparencyModifier
            obj.LocalTransparencyModifier = 0.85
        end
    end
    
    workspace.DescendantAdded:Connect(function(obj)
        if CONFIG.INVISIBLE_BASE_WALLS_ENABLED and isBaseWall(obj) then
            originalTransparency[obj] = obj.LocalTransparencyModifier
            obj.LocalTransparencyModifier = 0.85
        end
    end)
end

local function enableInvisibleBaseWalls()
    CONFIG.INVISIBLE_BASE_WALLS_ENABLED = true
    
    task.spawn(function()
        for _ = 1, 20 do
            tryApplyInvisibleWalls()
            if invisibleWallsLoaded then return end
            task.wait(0.5)
        end
    end)
end

local function disableInvisibleBaseWalls()
    CONFIG.INVISIBLE_BASE_WALLS_ENABLED = false
    invisibleWallsLoaded = false
    
    for part, value in pairs(originalTransparency) do
        if part then
            part.LocalTransparencyModifier = value
        end
    end
    originalTransparency = {}
end

-- ============================================================
-- SECTION 11: AUTO-STEAL SYSTEM (WITH PREDICTION)
-- ============================================================

local function findProximityPromptForAnimal(animalData)
    if not animalData then return nil end
    
    local cachedPrompt = PromptMemoryCache[animalData.uid]
    if cachedPrompt and cachedPrompt.Parent then
        return cachedPrompt
    end
    
    local plot = workspace.Plots:FindFirstChild(animalData.plot)
    if not plot then return nil end
    
    local podiums = plot:FindFirstChild("AnimalPodiums")
    if not podiums then return nil end
    
    local podium = podiums:FindFirstChild(animalData.slot)
    if not podium then return nil end
    
    local base = podium:FindFirstChild("Base")
    if not base then return nil end
    
    local spawn = base:FindFirstChild("Spawn")
    if not spawn then return nil end
    
    local attach = spawn:FindFirstChild("PromptAttachment")
    if not attach then return nil end
    
    for _, p in ipairs(attach:GetChildren()) do
        if p:IsA("ProximityPrompt") then
            PromptMemoryCache[animalData.uid] = p
            return p
        end
    end
    
    return nil
end

local function getAnimalPosition(animalData)
    local plot = workspace.Plots:FindFirstChild(animalData.plot)
    if not plot then return nil end
    
    local podiums = plot:FindFirstChild("AnimalPodiums")
    if not podiums then return nil end
    
    local podium = podiums:FindFirstChild(animalData.slot)
    if not podium then return nil end
    
    return podium:GetPivot().Position
end

local function getNearestAnimal()
    local hrp = getHRP()
    if not hrp then return nil end
    
    local nearest = nil
    local minDist = math.huge
    
    for _, animalData in ipairs(allAnimalsCache) do
        -- CRITICAL: Skip your own base animals
        if isMyBaseAnimal(animalData) then
            continue
        end
        
        local pos = getAnimalPosition(animalData)
        if pos then
            local dist = (hrp.Position - pos).Magnitude
            
            if dist < minDist then
                minDist = dist
                nearest = animalData
            end
        end
    end
    
    return nearest
end

-- Calculate player velocity for prediction
local function updatePlayerVelocity()
    local hrp = getHRP()
    if not hrp then return end
    
    local currentPos = hrp.Position
    
    if LastPlayerPosition then
        PlayerVelocity = (currentPos - LastPlayerPosition) / task.wait()
    end
    
    LastPlayerPosition = currentPos
end

-- Predict time until player reaches target
local function getTimeToReach(targetPos)
    local hrp = getHRP()
    if not hrp then return math.huge end
    
    local currentPos = hrp.Position
    local distance = (targetPos - currentPos).Magnitude
    
    -- If not moving, return infinite time
    if PlayerVelocity.Magnitude < 0.1 then
        return math.huge
    end
    
    -- Calculate direction to target
    local directionToTarget = (targetPos - currentPos).Unit
    
    -- Project velocity onto direction to target
    local velocityTowardTarget = PlayerVelocity:Dot(directionToTarget)
    
    -- If moving away from target, return infinite time
    if velocityTowardTarget <= 0 then
        return math.huge
    end
    
    -- Calculate time to reach
    return distance / velocityTowardTarget
end

-- Check if we should pre-fire based on prediction
local function shouldPreFire(animalData)
    local animalPos = getAnimalPosition(animalData)
    if not animalPos then return false end
    
    local hrp = getHRP()
    if not hrp then return false end
    
    local currentDistance = (hrp.Position - animalPos).Magnitude
    
    -- Always fire if in range
    if currentDistance <= AUTO_STEAL_PROX_RADIUS then
        return true
    end
    
    -- Check prediction if enabled
    if not CONFIG.PREDICTIVE_STEAL then
        return false
    end
    
    local timeToReach = getTimeToReach(animalPos)
    
    if timeToReach <= PREDICTION_LOOKAHEAD and timeToReach > 0 then
        return true
    end
    
    return false
end

local function buildStealCallbacks(prompt)
    if InternalStealCache[prompt] then return end
    
    local data = {
        holdCallbacks = {},
        triggerCallbacks = {},
        ready = true,
    }
    
    local ok1, conns1 = pcall(getconnections, prompt.PromptButtonHoldBegan)
    if ok1 and type(conns1) == "table" then
        for _, conn in ipairs(conns1) do
            if type(conn.Function) == "function" then
                table.insert(data.holdCallbacks, conn.Function)
            end
        end
    end
    
    local ok2, conns2 = pcall(getconnections, prompt.Triggered)
    if ok2 and type(conns2) == "table" then
        for _, conn in ipairs(conns2) do
            if type(conn.Function) == "function" then
                table.insert(data.triggerCallbacks, conn.Function)
            end
        end
    end
    
    if (#data.holdCallbacks > 0) or (#data.triggerCallbacks > 0) then
        InternalStealCache[prompt] = data
    end
end

local function runCallbackList(list)
    for _, fn in ipairs(list) do
        task.spawn(fn)
    end
end

-- OPTIMIZED: Non-blocking async execution
local function executeInternalStealAsync(prompt)
    local data = InternalStealCache[prompt]
    if not data or not data.ready then return false end
    
    data.ready = false
    
    task.spawn(function()
        if #data.holdCallbacks > 0 then
            runCallbackList(data.holdCallbacks)
        end
        
        task.wait(1.3)
        
        if #data.triggerCallbacks > 0 then
            runCallbackList(data.triggerCallbacks)
        end
        
        task.wait()
        data.ready = true
    end)
    
    return true
end

local function attemptSteal(prompt)
    if not prompt or not prompt.Parent then
        return false
    end
    
    buildStealCallbacks(prompt)
    if not InternalStealCache[prompt] then
        return false
    end
    
    return executeInternalStealAsync(prompt)
end

-- Pre-build callbacks in background
local function prebuildStealCallbacks()
    for uid, prompt in pairs(PromptMemoryCache) do
        if prompt and prompt.Parent then
            buildStealCallbacks(prompt)
        end
    end
end

task.spawn(function()
    while task.wait() do
        if CONFIG.AUTO_STEAL_ENABLED or CONFIG.AUTO_STEAL_NEAREST_ENABLED then
            prebuildStealCallbacks()
        end
    end
end)

local function getPriorityAnimal()
    for _, priorityName in ipairs(PRIORITY_ANIMALS) do
        for _, animalData in ipairs(allAnimalsCache) do
            -- CRITICAL: Skip your own base animals
            if not isMyBaseAnimal(animalData) and animalData.name == priorityName then
                return animalData
            end
        end
    end
    return nil
end

local stealConnection = nil
local velocityConnection = nil

local function autoStealLoop()
    if stealConnection then
        stealConnection:Disconnect()
    end
    if velocityConnection then
        velocityConnection:Disconnect()
    end
    
    velocityConnection = S.RunService.Heartbeat:Connect(function()
        updatePlayerVelocity()
    end)
    
    stealConnection = S.RunService.Heartbeat:Connect(function()
        if not CONFIG.AUTO_STEAL_ENABLED and not CONFIG.AUTO_STEAL_NEAREST_ENABLED and not CONFIG.AUTO_STEAL_PRIORITY_ENABLED then
            return
        end
        
        local targetAnimal = nil
        
        if CONFIG.AUTO_STEAL_PRIORITY_ENABLED then
            targetAnimal = getPriorityAnimal()
            
            if not targetAnimal then
                if CONFIG.AUTO_STEAL_NEAREST_ENABLED then
                    targetAnimal = getNearestAnimal()
                elseif CONFIG.AUTO_STEAL_ENABLED then
                    -- Find first non-owned animal
                    for _, animal in ipairs(allAnimalsCache) do
                        if not isMyBaseAnimal(animal) then
                            targetAnimal = animal
                            break
                        end
                    end
                end
            end
        elseif CONFIG.AUTO_STEAL_NEAREST_ENABLED then
            targetAnimal = getNearestAnimal()
        elseif CONFIG.AUTO_STEAL_ENABLED then
            -- Find first non-owned animal
            for _, animal in ipairs(allAnimalsCache) do
                if not isMyBaseAnimal(animal) then
                    targetAnimal = animal
                    break
                end
            end
        end
        
        -- CRITICAL: Double-check target is not your own
        if not targetAnimal or isMyBaseAnimal(targetAnimal) then
            return
        end
        
        if not shouldPreFire(targetAnimal) then
            return
        end
        
        if LastTargetUID ~= targetAnimal.uid then
            LastTargetUID = targetAnimal.uid
        end
        
        local prompt = PromptMemoryCache[targetAnimal.uid]
        if not prompt or not prompt.Parent then
            prompt = findProximityPromptForAnimal(targetAnimal)
        end
        
        if prompt then
            attemptSteal(prompt)
        end
    end)
end

local function setupPromptCacheCleanup()
    local plots = workspace:WaitForChild("Plots", 8)
    if not plots then return end
    
    plots.ChildRemoved:Connect(function(plot)
        for uid, prompt in pairs(PromptMemoryCache) do
            if uid:find(plot.Name) then
                PromptMemoryCache[uid] = nil
            end
        end
    end)
end

-- ============================================================
-- SECTION 11.5: SPEED BOOST SYSTEM
-- ============================================================

local function startStealSpeed()
    if stealSpeedConn then return end

    stealSpeedConn = S.RunService.Heartbeat:Connect(function()
        if not CONFIG.STEAL_SPEED_ENABLED then return end
        if not S.LocalPlayer:GetAttribute("Stealing") then return end

        local char = S.LocalPlayer.Character
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hum or not hrp then return end

        -- Only move if the player is actually pressing movement
        local move = hum.MoveDirection
        if move.Magnitude > 0 then
            hrp.AssemblyLinearVelocity = Vector3.new(
                move.X * STEAL_SPEED,
                hrp.AssemblyLinearVelocity.Y,
                move.Z * STEAL_SPEED
            )
        end
    end)
end

local function stopStealSpeed()
    if stealSpeedConn then
        stealSpeedConn:Disconnect()
        stealSpeedConn = nil
    end
end

S.LocalPlayer:GetAttributeChangedSignal("Stealing"):Connect(function()
    if S.LocalPlayer:GetAttribute("Stealing") then
        startStealSpeed()
    else
        stopStealSpeed()
    end
end)

-- ============================================================
-- SECTION 11.6: ANIMATION DISABLER SYSTEM
-- ============================================================

local animDisableConn = nil
local originalAnimIds = {}
local animateScript = nil

local ANIM_TYPES = {
    "walk", "run", "jump", "fall"
}

local function cacheOriginalAnimations()
    local char = S.LocalPlayer.Character
    if not char then return false end
    
    animateScript = char:FindFirstChild("Animate")
    if not animateScript then return false end
    
    originalAnimIds = {}
    
    for _, animType in ipairs(ANIM_TYPES) do
        local animFolder = animateScript:FindFirstChild(animType)
        if animFolder then
            originalAnimIds[animType] = {}
            for _, anim in ipairs(animFolder:GetChildren()) do
                if anim:IsA("Animation") then
                    originalAnimIds[animType][anim.Name] = anim.AnimationId
                end
            end
        end
    end
    
    return true
end

local function disableAnimations()
    if not animateScript then return end
    
    for _, animType in ipairs(ANIM_TYPES) do
        local animFolder = animateScript:FindFirstChild(animType)
        if animFolder then
            for _, anim in ipairs(animFolder:GetChildren()) do
                if anim:IsA("Animation") then
                    anim.AnimationId = ""
                end
            end
        end
    end
    
    local char = S.LocalPlayer.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            for _, track in ipairs(hum:GetPlayingAnimationTracks()) do
                track:Stop(0)
            end
        end
    end
end

local function restoreAnimations()
    if not animateScript or not originalAnimIds then return end
    
    for animType, anims in pairs(originalAnimIds) do
        local animFolder = animateScript:FindFirstChild(animType)
        if animFolder then
            for animName, animId in pairs(anims) do
                local anim = animFolder:FindFirstChild(animName)
                if anim and anim:IsA("Animation") then
                    anim.AnimationId = animId
                end
            end
        end
    end
end

local function startAnimDisable()
    if animDisableConn then return end
    
    -- Cache animations on first run
    if not next(originalAnimIds) then
        if not cacheOriginalAnimations() then
            warn("[Anim Disable] Failed to cache animations")
            return
        end
    end

    animDisableConn = S.RunService.Heartbeat:Connect(function()
        if not CONFIG.STEAL_DISABLE_ANIM_ENABLED then return end
        if not S.LocalPlayer:GetAttribute("Stealing") then return end

        disableAnimations()
    end)
end

local function stopAnimDisable()
    if animDisableConn then
        animDisableConn:Disconnect()
        animDisableConn = nil
    end
    restoreAnimations()
end

-- Monitor stealing state for animations
S.LocalPlayer:GetAttributeChangedSignal("Stealing"):Connect(function()
    if S.LocalPlayer:GetAttribute("Stealing") then
        if CONFIG.STEAL_DISABLE_ANIM_ENABLED then
            startAnimDisable()
        end
    else
        stopAnimDisable()
    end
end)

-- Re-cache animations on respawn
S.LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1) -- Wait for Animate script to load
    originalAnimIds = {}
    animateScript = nil
    cacheOriginalAnimations()
end)

-- ============================================================
-- SECTION 12: OPTIMIZER MODULE (ULTRA POTATO MODE)
-- ============================================================

local OPTIMIZER = {}
local optimizerThreads = {}
local optimizerConnections = {}
local originalSettings = {}

local function addThread(func)
    local t = task.spawn(func)
    table.insert(optimizerThreads, t)
    return t
end

local function addConnection(conn)
    table.insert(optimizerConnections, conn)
    return conn
end

-- Store original settings for restoration
local function storeOriginalSettings()
    pcall(function()
        originalSettings = {
            -- Workspace
            streamingEnabled = workspace.StreamingEnabled,
            streamingMinRadius = workspace.StreamingMinRadius,
            streamingTargetRadius = workspace.StreamingTargetRadius,
            
            -- Rendering
            qualityLevel = settings().Rendering.QualityLevel,
            meshPartDetailLevel = settings().Rendering.MeshPartDetailLevel,
            
            -- Lighting
            globalShadows = S.Lighting.GlobalShadows,
            brightness = S.Lighting.Brightness,
            fogEnd = S.Lighting.FogEnd,
            technology = S.Lighting.Technology,
            environmentDiffuseScale = S.Lighting.EnvironmentDiffuseScale,
            environmentSpecularScale = S.Lighting.EnvironmentSpecularScale,
            
            -- Terrain
            decoration = workspace.Terrain.Decoration,
            waterWaveSize = workspace.Terrain.WaterWaveSize,
            waterWaveSpeed = workspace.Terrain.WaterWaveSpeed,
            waterReflectance = workspace.Terrain.WaterReflectance,
            waterTransparency = workspace.Terrain.WaterTransparency,
        }
    end)
end

local PERFORMANCE_FFLAGS = {
    -- Rendering optimizations (ULTRA LOW)
    ["DFIntTaskSchedulerTargetFps"] = 999,
    ["FFlagDebugGraphicsPreferVulkan"] = true,
    ["FFlagDebugGraphicsDisableDirect3D11"] = true,
    ["FFlagDebugGraphicsPreferD3D11FL10"] = false,
    ["DFFlagDebugRenderForceTechnologyVoxel"] = true,
    ["FFlagDisablePostFx"] = true,
    ["FIntRenderShadowIntensity"] = 0,
    ["FIntRenderLocalLightUpdatesMax"] = 0,
    ["FIntRenderLocalLightUpdatesMin"] = 0,
    ["DFIntTextureCompositorActiveJobs"] = 1,
    ["DFIntDebugFRMQualityLevelOverride"] = 1,
    
    -- Physics optimizations
    ["FFlagFixPlayerCollisionWhenSwimming"] = false,
    ["DFIntMaxInterpolationSubsteps"] = 0,
    ["DFIntS2PhysicsSenderRate"] = 15,
    
    -- Network optimizations
    ["DFIntConnectionMTUSize"] = 1492,
    ["DFIntHttpCurlConnectionCacheSize"] = 134217728,
    
    -- Memory optimizations (AGGRESSIVE)
    ["DFIntCSGLevelOfDetailSwitchingDistance"] = 0,
    ["DFIntCSGLevelOfDetailSwitchingDistanceL12"] = 0,
    ["DFIntCSGLevelOfDetailSwitchingDistanceL23"] = 0,
    ["DFIntCSGLevelOfDetailSwitchingDistanceL34"] = 0,
    
    -- Disable unnecessary features
    ["FFlagEnableInGameMenuChromeABTest3"] = false,
    ["FFlagEnableInGameMenuModernization"] = false,
    ["FFlagEnableReportAbuseMenuRoactABTest2"] = false,
    ["FFlagDisableNewIGMinDUA"] = true,
    ["FFlagEnableAccessoryValidation"] = false,
    ["FFlagEnableV3MenuABTest3"] = false,
    
    -- UI optimizations (MINIMAL)
    ["FIntRobloxGuiBlurIntensity"] = 0,
    ["DFIntTimestepArbiterThresholdCFLThou"] = 10,
    
    -- Texture/graphics optimizations (POTATO)
    ["DFIntTextureQualityOverride"] = 1,
    ["DFIntPerformanceControlTextureQualityBestUtility"] = 1,
    ["DFIntTexturePoolSizeMB"] = 64,
    
    -- Animation optimizations
    ["DFIntMaxFrameBufferSize"] = 1,
    
    -- Particle optimizations
    ["FFlagDebugDisableParticleRendering"] = false, -- Can't fully disable or game breaks
    ["DFIntParticleMaxCount"] = 100,
    
    -- Water optimizations
    ["FFlagEnableWaterReflections"] = false,
    ["DFIntWaterReflectionQuality"] = 0,
}

local function applyFFlags()
    local success = 0
    local failed = 0
    
    for flag, value in pairs(PERFORMANCE_FFLAGS) do
        local ok = pcall(function()
            setfflag(flag, tostring(value))
        end)
        
        if ok then
            success = success + 1
        else
            failed = failed + 1
        end
    end
    
    print(string.format("[Optimizer] Applied %d/%d FFlags", success, success + failed))
end

-- ULTRA POTATO: Destroy all visual effects in workspace
local function nukeVisualEffects()
    pcall(function()
        for _, obj in ipairs(workspace:GetDescendants()) do
            pcall(function()
                -- Destroy ALL particles
                if obj:IsA("ParticleEmitter") then
                    obj.Enabled = false
                    obj.Rate = 0
                    obj:Destroy()
                    
                -- Destroy trails
                elseif obj:IsA("Trail") then
                    obj.Enabled = false
                    obj:Destroy()
                    
                -- Destroy beams
                elseif obj:IsA("Beam") then
                    obj.Enabled = false
                    obj:Destroy()
                    
                -- Destroy all lights
                elseif obj:IsA("PointLight") or obj:IsA("SpotLight") or obj:IsA("SurfaceLight") then
                    obj.Enabled = false
                    obj.Brightness = 0
                    obj:Destroy()
                    
                -- Destroy fire, smoke, sparkles
                elseif obj:IsA("Fire") or obj:IsA("Smoke") or obj:IsA("Sparkles") then
                    obj.Enabled = false
                    obj:Destroy()
                    
                -- Destroy explosions
                elseif obj:IsA("Explosion") then
                    obj:Destroy()
                    
                -- Simplify meshes
                elseif obj:IsA("SpecialMesh") then
                    obj.TextureId = ""
                    
                -- Remove textures/decals (except faces)
                elseif obj:IsA("Decal") or obj:IsA("Texture") then
                    if not (obj.Name == "face" and obj.Parent and obj.Parent.Name == "Head") then
                        obj.Transparency = 1
                    end
                    
                -- Disable shadows on all parts
                elseif obj:IsA("BasePart") then
                    obj.CastShadow = false
                    obj.Material = Enum.Material.Plastic -- Cheapest material
                    
                    -- Remove reflectance
                    if obj.Material == Enum.Material.Glass then
                        obj.Reflectance = 0
                    end
                end
            end)
        end
    end)
end

function OPTIMIZER.Enable()
    if getgenv().OPTIMIZER_ACTIVE then 
        warn("[Optimizer] Already running!")
        return 
    end
    
    getgenv().OPTIMIZER_ACTIVE = true
    storeOriginalSettings()
    
    -- Apply FFlags first
    pcall(applyFFlags)
    
    -- 1. ULTRA POTATO Streaming
    pcall(function()
        workspace.StreamingEnabled = true
        workspace.StreamingMinRadius
