-- == SETUP UI UTAMA == --
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local GuiService = game:GetService("GuiService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local gui = Instance.new("ScreenGui")
gui.Name = "CustomHubUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")


-- == FRAME UTAMA == --
local mainFrame = Instance.new("Frame", gui)
mainFrame.Size = UDim2.new(0, 600, 0, 400) -- Sedikit diperbesar untuk ruang tambahan
mainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
mainFrame.BackgroundTransparency = 0.2
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.BorderSizePixel = 0
mainFrame.Name = "MainFrame"
mainFrame.ClipsDescendants = true -- Penting untuk sudut melengkung

-- [DIUBAH] Membuat sudut lebih melengkung
local UICorner = Instance.new("UICorner", mainFrame)
UICorner.CornerRadius = UDim.new(0, 20) 

local UIStroke = Instance.new("UIStroke", mainFrame)
UIStroke.Thickness = 1
UIStroke.Color = Color3.fromRGB(255, 255, 255)
UIStroke.Transparency = 0.7


-- == TITLE BAR == --
local titleBar = Instance.new("Frame", mainFrame)
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
titleBar.BackgroundTransparency = 0.2
titleBar.BorderSizePixel = 0
titleBar.Name = "TitleBar"

local title = Instance.new("TextLabel", titleBar)
title.Size = UDim2.new(1, -80, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.Text = "Aikoo Hub"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.BackgroundTransparency = 1
title.TextXAlignment = Enum.TextXAlignment.Left


-- == TOMBOL CLOSE & MINIMIZE == --
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


-- == MINIMIZE ICON == --
local miniIcon = Instance.new("TextButton", gui)
miniIcon.Size = UDim2.new(0, 40, 0, 40)
miniIcon.Position = UDim2.new(0, 10, 1, -50)
miniIcon.Text = "☰"
miniIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
miniIcon.Font = Enum.Font.GothamBold
miniIcon.TextSize = 22
miniIcon.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
miniIcon.BackgroundTransparency = 0.2
miniIcon.Visible = false
miniIcon.Name = "MiniIcon"

local miniCorner = Instance.new("UICorner", miniIcon)
miniCorner.CornerRadius = UDim.new(0, 8)


-- == SIDEBAR MENU == --
local sidebarContainer = Instance.new("Frame", mainFrame)
sidebarContainer.Size = UDim2.new(0, 140, 1, -40)
sidebarContainer.Position = UDim2.new(0, 0, 0, 40)
sidebarContainer.BackgroundTransparency = 1
sidebarContainer.Name = "SidebarContainer"

local sidebar = Instance.new("ScrollingFrame", sidebarContainer)
sidebar.Size = UDim2.new(1, 0, 1, 0)
sidebar.CanvasSize = UDim2.new(0, 0, 0, 0)
sidebar.ScrollBarThickness = 4
sidebar.BackgroundTransparency = 1
sidebar.BorderSizePixel = 0
sidebar.Name = "Sidebar"

local sidebarLayout = Instance.new("UIListLayout", sidebar)
sidebarLayout.Padding = UDim.new(0, 6)
sidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder

local sidebarPadding = Instance.new("UIPadding", sidebar)
sidebarPadding.PaddingTop = UDim.new(0, 10)
sidebarPadding.PaddingLeft = UDim.new(0, 10)
sidebarPadding.PaddingRight = UDim.new(0, 10)


-- == CONTENT CONTAINER == --
local contentContainer = Instance.new("Frame", mainFrame)
contentContainer.Size = UDim2.new(1, -140, 1, -40)
contentContainer.Position = UDim2.new(0, 140, 0, 40)
contentContainer.BackgroundTransparency = 1
contentContainer.Name = "ContentContainer"


-- == PENGATURAN TEMA == --
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
    },
    ["Midnight Purple"] = {
		Background = Color3.fromRGB(25, 10, 40),
		BackgroundTransparency = 0.25,
		Accent = Color3.fromRGB(180, 0, 255),
		AccentSecondary = Color3.fromRGB(60, 20, 80),
		Text = Color3.fromRGB(240, 220, 255),
		Border = Color3.fromRGB(120, 60, 160)
	},
	["Mint Breeze"] = {
		Background = Color3.fromRGB(220, 255, 240),
		BackgroundTransparency = 0.35,
		Accent = Color3.fromRGB(0, 200, 150),
		AccentSecondary = Color3.fromRGB(180, 240, 220),
		Text = Color3.fromRGB(30, 60, 50),
		Border = Color3.fromRGB(150, 220, 200)
	},
	["Cyber Neon"] = {
		Background = Color3.fromRGB(10, 10, 10),
		BackgroundTransparency = 0.2,
		Accent = Color3.fromRGB(0, 255, 180),
		AccentSecondary = Color3.fromRGB(20, 20, 40),
		Text = Color3.fromRGB(0, 255, 180),
		Border = Color3.fromRGB(0, 255, 180)
	},
	["Retro Sunset"] = {
		Background = Color3.fromRGB(255, 120, 80),
		BackgroundTransparency = 0.3,
		Accent = Color3.fromRGB(255, 200, 0),
		AccentSecondary = Color3.fromRGB(200, 80, 60),
		Text = Color3.fromRGB(40, 10, 10),
		Border = Color3.fromRGB(255, 160, 80)
	},
	["Forest Night"] = {
		Background = Color3.fromRGB(15, 30, 20),
		BackgroundTransparency = 0.25,
		Accent = Color3.fromRGB(0, 100, 60),
		AccentSecondary = Color3.fromRGB(30, 60, 40),
		Text = Color3.fromRGB(200, 255, 220),
		Border = Color3.fromRGB(60, 120, 90)
	},
	["Mono Gray"] = {
		Background = Color3.fromRGB(60, 60, 60),
		BackgroundTransparency = 0.3,
		Accent = Color3.fromRGB(120, 120, 120),
		AccentSecondary = Color3.fromRGB(80, 80, 80),
		Text = Color3.fromRGB(220, 220, 220),
		Border = Color3.fromRGB(150, 150, 150)
	}
}


-- == FUNGSI SCROLL CONTAINER == --
local function createScrollContainer(parent)
    local scroll = Instance.new("ScrollingFrame", parent)
    scroll.Size = UDim2.new(1, 0, 1, 0)
    scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    scroll.ScrollBarThickness = 6
    scroll.BackgroundTransparency = 1
    scroll.BorderSizePixel = 0
    scroll.Name = "ScrollContainer"
    scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scroll.ScrollingDirection = Enum.ScrollingDirection.Y

    local layout = Instance.new("UIListLayout", scroll)
    layout.Padding = UDim.new(0, 6)
    layout.SortOrder = Enum.SortOrder.LayoutOrder

    local padding = Instance.new("UIPadding", scroll)
    padding.PaddingTop = UDim.new(0, 10)
    padding.PaddingLeft = UDim.new(0, 10)
    padding.PaddingRight = UDim.new(0, 10)

    return scroll
end


-- == FUNGSI EXPANDABLE SECTION == --
local function createExpandableSection(parent, titleText, subItems, onClick)
    local section = Instance.new("Frame", parent)
    section.Size = UDim2.new(1, 0, 0, 40)
    section.BackgroundTransparency = 1
    section.AutomaticSize = Enum.AutomaticSize.Y
    section.Name = titleText .. "_Section"

    local layout = Instance.new("UIListLayout", section)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 5)

    local toggleBtn = Instance.new("TextButton", section)
    toggleBtn.Size = UDim2.new(1, -20, 0, 40)
    toggleBtn.Text = "▶ " .. titleText
    toggleBtn.TextColor3 = Color3.fromRGB(230, 230, 230)
    toggleBtn.Font = Enum.Font.GothamBold
    toggleBtn.TextSize = 18
    toggleBtn.BackgroundTransparency = 1
    toggleBtn.TextXAlignment = Enum.TextXAlignment.Left

    local subContainer = Instance.new("Frame", section)
    subContainer.Size = UDim2.new(1, 0, 0, 0)
    subContainer.AutomaticSize = Enum.AutomaticSize.Y
    subContainer.BackgroundTransparency = 1
    subContainer.Visible = false
    subContainer.Name = titleText .. "_SubContainer"
	subContainer.ClipsDescendants = true

    local subLayout = Instance.new("UIListLayout", subContainer)
    subLayout.SortOrder = Enum.SortOrder.LayoutOrder
    subLayout.Padding = UDim.new(0, 4)
	
	local subPadding = Instance.new("UIPadding", subContainer)
	subPadding.PaddingLeft = UDim.new(0, 15)

    for _, txt in ipairs(subItems) do
        local subBtn = Instance.new("TextButton", subContainer)
        subBtn.Size = UDim2.new(1, 0, 0, 30)
        subBtn.Text = "• " .. txt
        subBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
        subBtn.Font = Enum.Font.Gotham
        subBtn.TextSize = 16
        subBtn.BackgroundTransparency = 0.3
        subBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
        subBtn.BorderSizePixel = 0
		subBtn.TextXAlignment = Enum.TextXAlignment.Left
		local subBtnPadding = Instance.new("UIPadding", subBtn)
		subBtnPadding.PaddingLeft = UDim.new(0, 10)


        local corner = Instance.new("UICorner", subBtn)
        corner.CornerRadius = UDim.new(0, 6)

        subBtn.MouseButton1Click:Connect(function()
            if onClick then onClick(txt) end
        end)
    end

    toggleBtn.MouseButton1Click:Connect(function()
        subContainer.Visible = not subContainer.Visible
        toggleBtn.Text = (subContainer.Visible and "▼ " or "▶ ") .. titleText
    end)
end

-- [DIUBAH] Mengganti fungsi slider dengan fungsi input angka
local function createTransparencyInput(parent)
    local frame = Instance.new("Frame", parent)
    frame.Size = UDim2.new(1, -20, 0, 65)
    frame.BackgroundTransparency = 1
    frame.Name = "TransparencyInputFrame"
    
    local layout = Instance.new("UIListLayout", frame)
    layout.Padding = UDim.new(0, 5)

    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1, 0, 0, 20)
    title.Text = "UI Transparency (0-1)"
    title.TextColor3 = Color3.fromRGB(230, 230, 230)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 16
    title.BackgroundTransparency = 1
    title.TextXAlignment = Enum.TextXAlignment.Left

    local inputBox = Instance.new("TextBox", frame)
    inputBox.Size = UDim2.new(1, 0, 0, 35)
    inputBox.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    inputBox.TextColor3 = Color3.fromRGB(220, 220, 220)
    inputBox.Font = Enum.Font.Gotham
    inputBox.TextSize = 14
    inputBox.Text = tostring(mainFrame.BackgroundTransparency)
    inputBox.ClearTextOnFocus = false
    inputBox.PlaceholderText = "Enter a value from 0 to 1"

    local corner = Instance.new("UICorner", inputBox)
    corner.CornerRadius = UDim.new(0, 6)
    
    local padding = Instance.new("UIPadding", inputBox)
    padding.PaddingLeft = UDim.new(0, 10)

    -- Event ini berjalan ketika user menekan Enter atau klik di luar TextBox
    inputBox.FocusLost:Connect(function(enterPressed)
        local text = inputBox.Text
        local num = tonumber(text)

        if num then -- Cek jika input adalah angka
            -- Paksa angka berada di antara 0 dan 1
            num = math.clamp(num, 0, 1)
            mainFrame.BackgroundTransparency = num
            inputBox.Text = tostring(num) -- Perbarui teks ke nilai yang sudah divalidasi
        else -- Jika input bukan angka
            -- Kembalikan teks ke nilai transparansi yang valid sebelumnya
            inputBox.Text = tostring(mainFrame.BackgroundTransparency)
        end
    end)
end

-- == FUNGSI APPLY TEMA == --
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
    miniIcon.TextColor3 = theme.Accent
    miniIcon.BackgroundColor3 = theme.AccentSecondary
end


-- == DATA MENU DAN HALAMAN == --
local menuItems = {
    "Home","Main","Automatically","Inventory","Shop","Webhook","Misc","Settings","Settings UI"
}

local menuData = {
    ["Home"] = {"Welcome", "News", "Updates"},
    ["Main"] = {},
    ["Automatically"] = {},
    ["Inventory"] = {},
    ["Shop"] = {},
    ["Webhook"] = {},
    ["Misc"] = {},
    ["Settings"] = {},
    ["Settings UI"] = {}
}

local pageContainers = {}
for _, tabName in ipairs(menuItems) do
    local pageFrame = Instance.new("Frame", contentContainer)
    pageFrame.Size = UDim2.new(1, 0, 1, 0)
    pageFrame.BackgroundTransparency = 1
    pageFrame.Visible = false
    pageFrame.Name = tabName .. "_Page"

    local scroll = createScrollContainer(pageFrame)
    pageContainers[tabName] = scroll
end


-- == MENU SIDEBAR INTERAKTIF == --
local defaultColor = Color3.fromRGB(40, 40, 60)
local activeColor = Color3.fromRGB(80, 80, 255)
local hoverColor = Color3.fromRGB(60, 60, 90)

local menuButtons = {}

local function setContent(tabName, items)
    for name, container in pairs(pageContainers) do
        container.Parent.Visible = (name == tabName)
    end

    local scroll = pageContainers[tabName]
    if not scroll then return end

    if tabName ~= "Settings UI" then
		-- Hapus konten lama sebelum menambahkan yang baru
		for _, child in ipairs(scroll:GetChildren()) do
			if not child:IsA("UIListLayout") and not child:IsA("UIPadding") then
				child:Destroy()
			end
		end
		
        local contentTitle = Instance.new("TextLabel", scroll)
        contentTitle.Size = UDim2.new(1, -20, 0, 40)
        contentTitle.Text = tabName
        contentTitle.TextSize = 28
        contentTitle.Font = Enum.Font.SourceSansBold
        contentTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        contentTitle.BackgroundTransparency = 1
        contentTitle.TextXAlignment = Enum.TextXAlignment.Left

        if #items == 0 then
            local emptyLabel = Instance.new("TextLabel", scroll)
            emptyLabel.Size = UDim2.new(1, -20, 0, 30)
            emptyLabel.Text = "No items yet..."
            emptyLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
            emptyLabel.BackgroundTransparency = 1
            emptyLabel.Font = Enum.Font.Gotham
            emptyLabel.TextXAlignment = Enum.TextXAlignment.Left
        end
    end
end

for _, tabName in ipairs(menuItems) do
    local btn = Instance.new("TextButton", sidebar)
    btn.Size = UDim2.new(1, 0, 0, 30)
    btn.Text = tabName
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 16
    btn.BackgroundColor3 = defaultColor
    btn.BackgroundTransparency = 0.3
    btn.BorderSizePixel = 0
    btn.Name = "Tab_" .. tabName

    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim.new(0, 6)

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

    btn.MouseButton1Click:Connect(function()
        for _, b in pairs(menuButtons) do
            b.BackgroundColor3 = defaultColor
        end
        btn.BackgroundColor3 = activeColor
        setContent(tabName, menuData[tabName] or {})
    end)

    menuButtons[tabName] = btn
end


-- == DEFAULT HALAMAN SAAT START == --
setContent("Home", menuData["Home"])
menuButtons["Home"].BackgroundColor3 = activeColor


-- == INJECT KONTEN KE SETTINGS UI == --
local settingsScroll = pageContainers["Settings UI"]

-- Hanya buat konten jika belum ada
if #settingsScroll:GetChildren() <= 2 then
    createExpandableSection(settingsScroll, "Themes", {
        "Glassy Dark","Light","Ocean Blue","Crimson Red",
        "Midnight Purple","Mint Breeze","Cyber Neon",
        "Retro Sunset","Forest Night","Mono Gray"
    }, function(selectedTheme)
        applyTheme(selectedTheme)
    end)

    -- Membuat bagian "Transparency" secara manual untuk kontrol yang lebih baik
    local transparencySection = Instance.new("Frame", settingsScroll)
    transparencySection.Size = UDim2.new(1, 0, 0, 40)
    transparencySection.BackgroundTransparency = 1
    transparencySection.AutomaticSize = Enum.AutomaticSize.Y
    transparencySection.Name = "Transparency_Section"
    
    local tsLayout = Instance.new("UIListLayout", transparencySection)
    tsLayout.SortOrder = Enum.SortOrder.LayoutOrder
    tsLayout.Padding = UDim.new(0, 5)

    local transparencyToggle = Instance.new("TextButton", transparencySection)
    transparencyToggle.Size = UDim2.new(1, -20, 0, 40)
    transparencyToggle.Text = "▶ " .. "Transparency"
    transparencyToggle.TextColor3 = Color3.fromRGB(230, 230, 230)
    transparencyToggle.Font = Enum.Font.GothamBold
    transparencyToggle.TextSize = 18
    transparencyToggle.BackgroundTransparency = 1
    transparencyToggle.TextXAlignment = Enum.TextXAlignment.Left

    local transparencyContainer = Instance.new("Frame", transparencySection)
    transparencyContainer.Size = UDim2.new(1, 0, 0, 0)
    transparencyContainer.AutomaticSize = Enum.AutomaticSize.Y
    transparencyContainer.BackgroundTransparency = 1
    transparencyContainer.Visible = false
    transparencyContainer.Name = "Transparency_SubContainer"
	transparencyContainer.ClipsDescendants = true

	local tcLayout = Instance.new("UIListLayout", transparencyContainer)
    tcLayout.SortOrder = Enum.SortOrder.LayoutOrder
	
	local tcPadding = Instance.new("UIPadding", transparencyContainer)
	tcPadding.PaddingLeft = UDim.new(0, 15)

    -- [DIUBAH] Panggil fungsi baru untuk membuat input angka
    createTransparencyInput(transparencyContainer)

    -- Atur fungsi toggle
    transparencyToggle.MouseButton1Click:Connect(function()
        transparencyContainer.Visible = not transparencyContainer.Visible
        transparencyToggle.Text = (transparencyContainer.Visible and "▼ " or "▶ ") .. "Transparency"
    end)
end


-- == FUNGSI TOMBOL CLOSE & MINIMIZE == --
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


-- == LOADER SYSTEM == --

-- == KEY SYSTEM == --

-- == OBJECT TELEPORTER == --

-- == AUTO PLAY PIANO == --

-- == SCENE SCANNER == --
