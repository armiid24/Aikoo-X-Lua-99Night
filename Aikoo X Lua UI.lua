-- Roblox Hub UI Layout (Glassmorphism Style)
-- LocalScript di StarterGui

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "CustomHubUI"

-- FRAME UTAMA
local mainFrame = Instance.new("Frame", gui)
mainFrame.Size = UDim2.new(0, 600, 0, 350)
mainFrame.Position = UDim2.new(0.5, -300, 0.5, -175)
mainFrame.BackgroundColor3 = Color3.fromRGB(20,20,30)
mainFrame.BackgroundTransparency = 0.2
mainFrame.Active = true
mainFrame.Draggable = true

local UICorner = Instance.new("UICorner", mainFrame)
UICorner.CornerRadius = UDim.new(0, 12)

local UIStroke = Instance.new("UIStroke", mainFrame)
UIStroke.Thickness = 1
UIStroke.Color = Color3.fromRGB(255,255,255)
UIStroke.Transparency = 0.7

--// PENGATURAN TEMA //--
local Themes = {
    ["Glassy Dark"] = {
        Background = Color3.fromRGB(20, 20, 25),
        BackgroundTransparency = 0.3,
        Accent = Color3.fromRGB(80, 80, 255),
        AccentSecondary = Color3.fromRGB(40, 40, 60),
        Text = Color3.fromRGB(255, 255, 255),
        Border = Color3.fromRGB(150, 150, 170)
    },
    ["Light"] = {
        Background = Color3.fromRGB(240, 240, 240),
        BackgroundTransparency = 0.4,
        Accent = Color3.fromRGB(0, 120, 255),
        AccentSecondary = Color3.fromRGB(200, 200, 210),
        Text = Color3.fromRGB(10, 10, 10),
        Border = Color3.fromRGB(200, 200, 200)
    },
    ["Ocean Blue"] = {
        Background = Color3.fromRGB(10, 25, 40),
        BackgroundTransparency = 0.25,
        Accent = Color3.fromRGB(0, 191, 255),
        AccentSecondary = Color3.fromRGB(15, 40, 60),
        Text = Color3.fromRGB(230, 240, 255),
        Border = Color3.fromRGB(60, 120, 180)
    },
    ["Crimson Red"] = {
        Background = Color3.fromRGB(30, 10, 10),
        BackgroundTransparency = 0.3,
        Accent = Color3.fromRGB(220, 20, 60),
        AccentSecondary = Color3.fromRGB(60, 20, 25),
        Text = Color3.fromRGB(255, 220, 220),
        Border = Color3.fromRGB(150, 80, 80)
    }
}


-- TITLE BAR
local titleBar = Instance.new("Frame", mainFrame)
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.Position = UDim2.new(0, 0, 0, 0)
titleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
titleBar.BackgroundTransparency = 0.3
titleBar.BorderSizePixel = 0
titleBar.ZIndex = 2

local titleCorner = Instance.new("UICorner", titleBar)
titleCorner.CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel", titleBar)
title.Size = UDim2.new(1, -80, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.Text = "Speed Hub X | Version 5.5.1 | discord.gg/speedhubx"
title.TextColor3 = Color3.fromRGB(200, 180, 255)
title.BackgroundTransparency = 1
title.TextXAlignment = Enum.TextXAlignment.Left

-- CLOSE & MINIMIZE
local closeBtn = Instance.new("TextButton", titleBar)
closeBtn.Size = UDim2.new(0, 30, 1, 0)
closeBtn.Position = UDim2.new(1, -30, 0, 0)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
closeBtn.BackgroundTransparency = 1

local minBtn = Instance.new("TextButton", titleBar)
minBtn.Size = UDim2.new(0, 30, 1, 0)
minBtn.Position = UDim2.new(1, -60, 0, 0)
minBtn.Text = "-"
minBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minBtn.BackgroundTransparency = 1

-- SIDEBAR (Scroll)
local sidebarContainer = Instance.new("Frame", mainFrame)
sidebarContainer.Size = UDim2.new(0, 160, 1, -30)
sidebarContainer.Position = UDim2.new(0, 10, 0, 30)
sidebarContainer.BackgroundTransparency = 1

local sidebar = Instance.new("ScrollingFrame", sidebarContainer)
sidebar.Size = UDim2.new(1, 0, 1, 0)
sidebar.CanvasSize = UDim2.new(0,0,0,0)
sidebar.ScrollBarThickness = 4
sidebar.BackgroundTransparency = 1

local sideList = Instance.new("UIListLayout", sidebar)
sideList.Padding = UDim.new(0, 5)
sideList.FillDirection = Enum.FillDirection.Vertical
sideList.SortOrder = Enum.SortOrder.LayoutOrder

local UIPaddingSidebar = Instance.new("UIPadding", sidebar)
UIPaddingSidebar.PaddingLeft = UDim.new(0,5)
UIPaddingSidebar.PaddingTop = UDim.new(0,5)

-- CONTENT (Scroll)
local contentContainer = Instance.new("Frame", mainFrame)
contentContainer.Size = UDim2.new(1, -180, 1, -30)
contentContainer.Position = UDim2.new(0, 180, 0, 30)
contentContainer.BackgroundTransparency = 1

local content = Instance.new("ScrollingFrame", contentContainer)
content.Size = UDim2.new(1, 0, 1, 0)
content.CanvasSize = UDim2.new(0,0,0,0)
content.ScrollBarThickness = 6
content.BackgroundTransparency = 1

local UIPaddingContent = Instance.new("UIPadding", content)
UIPaddingContent.PaddingLeft = UDim.new(0,10)
UIPaddingContent.PaddingTop = UDim.new(0,10)

local listLayout = Instance.new("UIListLayout", content)
listLayout.Padding = UDim.new(0, 5)
listLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- === CONTENT UPDATE FUNCTION ===
local function clearContent()
    for _,child in ipairs(content:GetChildren()) do
        if not child:IsA("UIListLayout") and not child:IsA("UIPadding") then
            child:Destroy()
        end
    end
end

local function applyTheme(themeName)
    local theme = Themes[themeName]
    if not theme then return end

    mainFrame.BackgroundColor3 = theme.Background
    mainFrame.BackgroundTransparency = theme.BackgroundTransparency
    UIStroke.Color = theme.Border

    titleBar.BackgroundColor3 = theme.AccentSecondary
    title.TextColor3 = theme.Text
    closeBtn.TextColor3 = theme.Accent
    minBtn.TextColor3 = theme.Text
end

local function createExpandableSection(parent, titleText, subItems, onClick)
    local section = Instance.new("Frame", parent)
    section.Size = UDim2.new(1, -20, 0, 40)
    section.BackgroundTransparency = 1

    local toggleBtn = Instance.new("TextButton", section)
    toggleBtn.Size = UDim2.new(1, 0, 0, 40)
    toggleBtn.Text = "▶ " .. titleText
    toggleBtn.TextColor3 = Color3.fromRGB(230,230,230)
    toggleBtn.BackgroundTransparency = 1
    toggleBtn.TextXAlignment = Enum.TextXAlignment.Left

    local subContainer = Instance.new("Frame", parent)
    subContainer.Size = UDim2.new(1, -20, 0, #subItems * 35)
    subContainer.BackgroundTransparency = 1
    subContainer.Visible = false

    local layout = Instance.new("UIListLayout", subContainer)
    layout.Padding = UDim.new(0, 4)
    layout.SortOrder = Enum.SortOrder.LayoutOrder

    for _, txt in ipairs(subItems) do
        local subBtn = Instance.new("TextButton", subContainer)
        subBtn.Size = UDim2.new(1, 0, 0, 30)
        subBtn.Text = "   • " .. txt
        subBtn.TextColor3 = Color3.fromRGB(200,200,200)
        subBtn.BackgroundTransparency = 0.3
        subBtn.BackgroundColor3 = Color3.fromRGB(40,40,60)
        subBtn.BorderSizePixel = 0
        Instance.new("UICorner", subBtn).CornerRadius = UDim.new(0, 6)

        subBtn.MouseButton1Click:Connect(function()
            if onClick then onClick(txt) end
        end)
    end

    toggleBtn.MouseButton1Click:Connect(function()
        subContainer.Visible = not subContainer.Visible
        toggleBtn.Text = (subContainer.Visible and "▼ " or "▶ ") .. titleText
    end)
end


local function setContent(titleText, items)
    clearContent()

    -- Title
    local contentTitle = Instance.new("TextLabel", content)
    contentTitle.Size = UDim2.new(1, -20, 0, 40)
    contentTitle.Text = titleText
    contentTitle.TextSize = 28
    contentTitle.Font = Enum.Font.SourceSansBold
    contentTitle.TextColor3 = Color3.fromRGB(255,255,255)
    contentTitle.BackgroundTransparency = 1
    contentTitle.TextXAlignment = Enum.TextXAlignment.Left

    -- Items
    for _,txt in ipairs(items) do
        local item = Instance.new("TextButton", content)
        item.Size = UDim2.new(1, -20, 0, 35)
        item.Text = txt.."   >"
        item.TextColor3 = Color3.fromRGB(240,240,240)
        item.BackgroundColor3 = Color3.fromRGB(40,40,60)
        item.BackgroundTransparency = 0.4
        item.BorderSizePixel = 0

        local UIC = Instance.new("UICorner", item)
        UIC.CornerRadius = UDim.new(0, 6)
    end
end

-- MENU DATA
local menuData = {
    ["Home"] = {},
    ["Main"] = {},
    ["Automatically"] = {},
    ["Inventory"] = {},
    ["Shop"] = {},
    ["Webhook"] = {},
    ["Misc"] = {},
    ["Settings"] = {},
    ["Settings UI"] = {}
}

local menuItems = {"Home","Main","Automatically","Inventory","Shop","Webhook","Misc","Settings","Settings UI"}

-- === MENU INTERAKTIF ===
local defaultColor = Color3.fromRGB(40,40,60)
local activeColor = Color3.fromRGB(90,60,150)
local hoverColor = Color3.fromRGB(70,70,100)
local menuButtons = {}

for _,v in ipairs(menuItems) do
    local btn = Instance.new("TextButton", sidebar)
    btn.Size = UDim2.new(1, -10, 0, 30)
    btn.Text = "  "..v
    btn.TextColor3 = Color3.fromRGB(230,230,230)
    btn.BackgroundColor3 = defaultColor
    btn.BackgroundTransparency = 0.4
    btn.BorderSizePixel = 0

    local UIC = Instance.new("UICorner", btn)
    UIC.CornerRadius = UDim.new(0, 6)

    menuButtons[v] = btn

    -- Hover effect
    btn.MouseEnter:Connect(function()
        if btn.BackgroundColor3 ~= activeColor then
            btn.BackgroundColor3 = hoverColor
        end
    end)
    btn.MouseLeave:Connect(function()
        if btn.BackgroundColor3 ~= activeColor then
            btn.BackgroundColor3 = defaultColor
        end
    end)

    -- onClick update content + highlight
    btn.MouseButton1Click:Connect(function()
        for _,b in pairs(menuButtons) do
            b.BackgroundColor3 = defaultColor
        end
        btn.BackgroundColor3 = activeColor
        setContent(v, menuData[v] or {"Empty"})
    end)
end
sidebar.CanvasSize = UDim2.new(0,0,0,#menuItems*35)

-- DEFAULT CONTENT & HIGHLIGHT
setContent("Home", menuData["Home"])
setContent("Settings UI", menuData["Settings UI"])
menuButtons["Home"].BackgroundColor3 = activeColor

local settingsScroll = pageContainers["Settings UI"]

-- TEMA PILIHAN

createExpandableSection(settingsScroll, "Themes", {
    "Glassy Dark",
    "Light",
    "Ocean Blue",
    "Crimson Red"
}, function(selectedTheme)
    applyTheme(selectedTheme)
end)


-- MINIMIZE ICON
local miniIcon = Instance.new("TextButton", gui)
miniIcon.Size = UDim2.new(0, 50, 0, 50)
miniIcon.Position = UDim2.new(0.1, 0, 0.8, 0)
miniIcon.Text = "📜"
miniIcon.Visible = false
miniIcon.BackgroundTransparency = 0.5
miniIcon.BackgroundColor3 = Color3.fromRGB(50,50,50)
miniIcon.Active = true
miniIcon.Draggable = true

-- BUTTON FUNCTIONS
closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

minBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    miniIcon.Visible = true
end)

miniIcon.MouseButton1Click:Connect(function()
    mainFrame.Visible = true
    miniIcon.Visible = false
end)

-- Update scroll content otomatis
listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    content.CanvasSize = UDim2.new(0,0,0,listLayout.AbsoluteContentSize.Y)
end)
