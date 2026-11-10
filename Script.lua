-- ============================================================
-- PXZD HUB v3 - PARTE 1/4
-- INTRO A: Setup, rayos, lluvia, ojos iluminati
-- ============================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local IMAGE_ID = "rbxassetid://97787846637167"
local targetMode = "Head"

-- ============================================================
-- INTRO - GUI + FONDO
-- ============================================================
local introGui = Instance.new("ScreenGui")
introGui.Name = "PxzdIntro"
introGui.ResetOnSpawn = false
introGui.IgnoreGuiInset = true
introGui.DisplayOrder = 9999
introGui.Parent = PlayerGui

local bg = Instance.new("Frame")
bg.Size = UDim2.new(1, 0, 1, 0)
bg.BackgroundColor3 = Color3.fromRGB(2, 2, 8)
bg.BorderSizePixel = 0
bg.BackgroundTransparency = 1
bg.Parent = introGui
TweenService:Create(bg, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()

-- RAYOS giratorios
local rayContainer = Instance.new("Frame")
rayContainer.Size = UDim2.new(0, 900, 0, 900)
rayContainer.AnchorPoint = Vector2.new(0.5, 0.5)
rayContainer.Position = UDim2.new(0.5, 0, 0.5, 0)
rayContainer.BackgroundTransparency = 1
rayContainer.Parent = bg

local rays = {}
for i = 1, 18 do
    local ray = Instance.new("Frame")
    ray.Size = UDim2.new(0, 2, 0, 450)
    ray.AnchorPoint = Vector2.new(0.5, 1)
    ray.Position = UDim2.new(0.5, 0, 0.5, 0)
    ray.Rotation = i * (360 / 18)
    ray.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    ray.BackgroundTransparency = 1
    ray.BorderSizePixel = 0
    ray.Parent = rayContainer
    table.insert(rays, ray)
    task.delay(0.2, function()
        TweenService:Create(ray, TweenInfo.new(0.8), {BackgroundTransparency = 0.75}):Play()
    end)
end

-- LLUVIA
local rainDrops = {}
for i = 1, 45 do
    local drop = Instance.new("Frame")
    drop.Size = UDim2.new(0, 1, 0, math.random(18, 40))
    drop.Position = UDim2.new(math.random(), 0, -0.15, 0)
    drop.BackgroundColor3 = Color3.fromRGB(120, 190, 255)
    drop.BackgroundTransparency = math.random(50, 80) / 100
    drop.BorderSizePixel = 0
    drop.Parent = bg
    table.insert(rainDrops, drop)
end

-- OJOS ILUMINATI
local eyeStars = {}
for i = 1, 12 do
    local angle = (i / 12) * math.pi * 2
    local dist = math.random(230, 380) / 700
    local cx = 0.5 + math.cos(angle) * dist
    local cy = 0.5 + math.sin(angle) * dist

    local starFrame = Instance.new("Frame")
    starFrame.Size = UDim2.new(0, 60, 0, 60)
    starFrame.Position = UDim2.new(cx, -30, cy, -30)
    starFrame.BackgroundTransparency = 1
    starFrame.Parent = bg

    local triangle = Instance.new("TextLabel")
    triangle.Size = UDim2.new(1, 0, 1, 0)
    triangle.BackgroundTransparency = 1
    triangle.Text = "▲"
    triangle.TextColor3 = Color3.fromRGB(255, 215, 0)
    triangle.TextTransparency = 1
    triangle.Font = Enum.Font.GothamBold
    triangle.TextSize = 60
    triangle.Parent = starFrame

    local eye = Instance.new("Frame")
    eye.Size = UDim2.new(0, 20, 0, 12)
    eye.Position = UDim2.new(0.5, 0, 0.57, 0)
    eye.AnchorPoint = Vector2.new(0.5, 0.5)
    eye.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    eye.BorderSizePixel = 0
    eye.BackgroundTransparency = 1
    eye.Parent = starFrame
    Instance.new("UICorner", eye).CornerRadius = UDim.new(1, 0)
    local eyeStroke = Instance.new("UIStroke", eye)
    eyeStroke.Color = Color3.fromRGB(0, 150, 255)
    eyeStroke.Thickness = 1.5
    eyeStroke.Transparency = 1

    local pupil = Instance.new("Frame")
    pupil.Size = UDim2.new(0, 6, 0, 6)
    pupil.Position = UDim2.new(0.5, 0, 0.5, 0)
    pupil.AnchorPoint = Vector2.new(0.5, 0.5)
    pupil.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    pupil.BorderSizePixel = 0
    pupil.BackgroundTransparency = 1
    pupil.Parent = eye
    Instance.new("UICorner", pupil).CornerRadius = UDim.new(1, 0)

    table.insert(eyeStars, {
        frame = starFrame, triangle = triangle, eye = eye,
        pupil = pupil, stroke = eyeStroke,
        baseY = cy, phase = math.random() * math.pi * 2
    })

    task.delay(0.3 + i * 0.08, function()
        TweenService:Create(triangle, TweenInfo.new(0.5), {TextTransparency = 0.35}):Play()
        TweenService:Create(eye, TweenInfo.new(0.5), {BackgroundTransparency = 0}):Play()
        TweenService:Create(pupil, TweenInfo.new(0.5), {BackgroundTransparency = 0}):Play()
        TweenService:Create(eyeStroke, TweenInfo.new(0.5), {Transparency = 0.3}):Play()
    end)
end-- ============================================================
-- PXZD HUB v3 - PARTE 2/4
-- INTRO B: Glow, anillos, texto Pxzd, animaciones y fade
-- ============================================================

-- Glow central
local glow = Instance.new("Frame")
glow.Size = UDim2.new(0, 320, 0, 320)
glow.Position = UDim2.new(0.5, 0, 0.5, 0)
glow.AnchorPoint = Vector2.new(0.5, 0.5)
glow.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
glow.BackgroundTransparency = 1
glow.Parent = bg
Instance.new("UICorner", glow).CornerRadius = UDim.new(1, 0)
local glowStroke = Instance.new("UIStroke", glow)
glowStroke.Color = Color3.fromRGB(0, 150, 255)
glowStroke.Thickness = 2
glowStroke.Transparency = 1
TweenService:Create(glowStroke, TweenInfo.new(0.6), {Transparency = 0.25}):Play()

-- Anillos
local rings = {}
for i, data in ipairs({{size = 200, speed = 80}, {size = 280, speed = -60}}) do
    local ring = Instance.new("Frame")
    ring.Size = UDim2.new(0, data.size, 0, data.size)
    ring.AnchorPoint = Vector2.new(0.5, 0.5)
    ring.Position = UDim2.new(0.5, 0, 0.5, 0)
    ring.BackgroundTransparency = 1
    ring.Parent = bg
    Instance.new("UICorner", ring).CornerRadius = UDim.new(1, 0)
    local st = Instance.new("UIStroke", ring)
    st.Color = Color3.fromRGB(0, 150, 255)
    st.Thickness = 2
    st.Transparency = 1
    rings[i] = {stroke = st, speed = data.speed}
    task.delay(0.4, function()
        TweenService:Create(st, TweenInfo.new(0.5), {Transparency = 0.2}):Play()
    end)
end

-- Texto Pxzd
local pxzd = Instance.new("TextLabel")
pxzd.Size = UDim2.new(0, 450, 0, 110)
pxzd.AnchorPoint = Vector2.new(0.5, 0.5)
pxzd.Position = UDim2.new(0.5, 0, 0.5, 0)
pxzd.BackgroundTransparency = 1
pxzd.Text = "Pxzd"
pxzd.TextColor3 = Color3.fromRGB(120, 220, 255)
pxzd.TextScaled = true
pxzd.Font = Enum.Font.GothamBlack
pxzd.TextTransparency = 1
pxzd.Parent = bg
local pxzdStroke = Instance.new("UIStroke", pxzd)
pxzdStroke.Color = Color3.fromRGB(0, 150, 255)
pxzdStroke.Thickness = 3
pxzdStroke.Transparency = 1

task.delay(0.8, function()
    TweenService:Create(pxzd, TweenInfo.new(0.8), {TextTransparency = 0}):Play()
    TweenService:Create(pxzdStroke, TweenInfo.new(0.8), {Transparency = 0}):Play()
end)

-- Flash eléctrico
task.spawn(function()
    task.wait(1.6)
    for i = 1, 4 do
        pxzdStroke.Color = Color3.fromRGB(255, 255, 255)
        task.wait(0.08)
        pxzdStroke.Color = Color3.fromRGB(0, 150, 255)
        task.wait(0.15)
    end
end)

-- Animación maestra
local running = true
task.spawn(function()
    while running do
        local dt = RunService.RenderStepped:Wait()
        local t = tick()
        rayContainer.Rotation = rayContainer.Rotation + 8 * dt
        for _, drop in ipairs(rainDrops) do
            local ny = drop.Position.Y.Scale + dt * 1.6
            if ny > 1.1 then
                drop.Position = UDim2.new(math.random(), 0, -0.15, 0)
            else
                drop.Position = UDim2.new(drop.Position.X.Scale, 0, ny, 0)
            end
        end
        for _, e in ipairs(eyeStars) do
            local offset = math.sin(t * 1.8 + e.phase) * 8
            e.frame.Position = UDim2.new(e.frame.Position.X.Scale, -30, e.baseY, -30 + offset)
            e.frame.Rotation = e.frame.Rotation + 15 * dt
        end
        for _, ring in ipairs(rings) do
            ring.stroke.Color = Color3.fromRGB(0, 150, 255)
            ring.stroke.Thickness = 2 + math.sin(t * 4) * 0.5
        end
    end
end)

-- Fade out
task.delay(6.2, function()
    TweenService:Create(pxzd, TweenInfo.new(0.6), {TextTransparency = 1}):Play()
    TweenService:Create(pxzdStroke, TweenInfo.new(0.6), {Transparency = 1}):Play()
    for _, ray in ipairs(rays) do
        TweenService:Create(ray, TweenInfo.new(0.6), {BackgroundTransparency = 1}):Play()
    end
    for _, drop in ipairs(rainDrops) do
        TweenService:Create(drop, TweenInfo.new(0.6), {BackgroundTransparency = 1}):Play()
    end
    for _, e in ipairs(eyeStars) do
        TweenService:Create(e.triangle, TweenInfo.new(0.6), {TextTransparency = 1}):Play()
        TweenService:Create(e.eye, TweenInfo.new(0.6), {BackgroundTransparency = 1}):Play()
        TweenService:Create(e.pupil, TweenInfo.new(0.6), {BackgroundTransparency = 1}):Play()
        TweenService:Create(e.stroke, TweenInfo.new(0.6), {Transparency = 1}):Play()
    end
    for _, ring in ipairs(rings) do
        TweenService:Create(ring.stroke, TweenInfo.new(0.6), {Transparency = 1}):Play()
    end
    TweenService:Create(glowStroke, TweenInfo.new(0.6), {Transparency = 1}):Play()
    TweenService:Create(bg, TweenInfo.new(0.6), {BackgroundTransparency = 1}):Play()
end)

task.delay(7, function()
    running = false
    introGui:Destroy()
end)-- ============================================================
-- PXZD HUB v3 - PARTE 3/4
-- UI: Panel arrastrable, sliders, target selector, imagen
-- ============================================================

local mainGui = Instance.new("ScreenGui")
mainGui.Name = "PxzdHub"
mainGui.ResetOnSpawn = false
mainGui.IgnoreGuiInset = true
mainGui.Parent = PlayerGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 290, 0, 400)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(14, 14, 24)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false
mainFrame.Parent = mainGui
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 10)
local mainStroke = Instance.new("UIStroke", mainFrame)
mainStroke.Color = Color3.fromRGB(0, 150, 255)
mainStroke.Thickness = 1
mainStroke.Transparency = 0.2
local mainGrad = Instance.new("UIGradient", mainFrame)
mainGrad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(22, 22, 38)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 8, 18)),
}
mainGrad.Rotation = 135

-- Header arrastrable
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 45)
header.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
header.BackgroundTransparency = 0.65
header.BorderSizePixel = 0
header.Parent = mainFrame
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 10)
local headerFix = Instance.new("Frame")
headerFix.Size = UDim2.new(1, 0, 0, 12)
headerFix.Position = UDim2.new(0, 0, 1, -12)
headerFix.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
headerFix.BackgroundTransparency = 0.65
headerFix.BorderSizePixel = 0
headerFix.Parent = header

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -60, 1, 0)
title.Position = UDim2.new(0, 14, 0, 0)
title.BackgroundTransparency = 1
title.Text = "PXZD HUB"
title.TextColor3 = Color3.fromRGB(120, 220, 255)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Font = Enum.Font.GothamBlack
title.TextSize = 18
title.Parent = header

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 28, 0, 28)
closeBtn.Position = UDim2.new(1, -36, 0.5, -14)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
closeBtn.Parent = header
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1, 0)

local content = Instance.new("Frame")
content.Size = UDim2.new(1, -30, 1, -60)
content.Position = UDim2.new(0, 15, 0, 55)
content.BackgroundTransparency = 1
content.Parent = mainFrame

local aimbotBtn = Instance.new("TextButton")
aimbotBtn.Size = UDim2.new(1, 0, 0, 42)
aimbotBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
aimbotBtn.Text = "ACTIVE AIMBOT"
aimbotBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
aimbotBtn.Font = Enum.Font.GothamBold
aimbotBtn.TextSize = 14
aimbotBtn.Parent = content
Instance.new("UICorner", aimbotBtn).CornerRadius = UDim.new(0, 7)
local aimbotBtnStroke = Instance.new("UIStroke", aimbotBtn)
aimbotBtnStroke.Color = Color3.fromRGB(80, 80, 100)
aimbotBtnStroke.Thickness = 1

local fovValue = 150
local smoothValue = 0.3
local aimbotEnabled = false

local function createSlider(parent, yPos, minVal, maxVal, defaultVal, name, callback)
    local c = Instance.new("Frame")
    c.Size = UDim2.new(1, 0, 0, 50)
    c.Position = UDim2.new(0, 0, 0, yPos)
    c.BackgroundTransparency = 1
    c.Parent = parent

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 20)
    label.BackgroundTransparency = 1
    label.Text = name .. ": " .. string.format("%.1f", defaultVal)
    label.TextColor3 = Color3.fromRGB(170, 170, 190)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = Enum.Font.Gotham
    label.TextSize = 13
    label.Parent = c

    local track = Instance.new("Frame")
    track.Size = UDim2.new(1, 0, 0, 7)
    track.Position = UDim2.new(0, 0, 0, 30)
    track.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    track.BorderSizePixel = 0
    track.Parent = c
    Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((defaultVal - minVal)/(maxVal - minVal), 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    fill.BorderSizePixel = 0
    fill.Parent = track
    Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 14, 0, 14)
    knob.Position = UDim2.new((defaultVal - minVal)/(maxVal - minVal), -7, 0.5, -7)
    knob.BackgroundColor3 = Color3.new(1,1,1)
    knob.Parent = track
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

    local dragging = false
    local function setVal(pos)
        local relX = pos.X - track.AbsolutePosition.X
        local p = math.clamp(relX / track.AbsoluteSize.X, 0, 1)
        local v = minVal + (maxVal - minVal) * p
        fill.Size = UDim2.new(p, 0, 1, 0)
        knob.Position = UDim2.new(p, -7, 0.5, -7)
        label.Text = name .. ": " .. string.format("%.1f", v)
        callback(v)
    end
    track.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            setVal(input.Position)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            setVal(input.Position)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

createSlider(content, 52, 50, 500, fovValue, "FOV", function(v) fovValue = v end)
createSlider(content, 108, 0.1, 1, smoothValue, "Smoothness", function(v) smoothValue = v end)

-- Target Part selector
local targetLabel = Instance.new("TextLabel")
targetLabel.Size = UDim2.new(1, 0, 0, 20)
targetLabel.Position = UDim2.new(0, 0, 0, 165)
targetLabel.BackgroundTransparency = 1
targetLabel.Text = "Target Part"
targetLabel.TextColor3 = Color3.fromRGB(170, 170, 190)
targetLabel.TextXAlignment = Enum.TextXAlignment.Left
targetLabel.Font = Enum.Font.GothamBold
targetLabel.TextSize = 13
targetLabel.Parent = content

local targetBtnContainer = Instance.new("Frame")
targetBtnContainer.Size = UDim2.new(1, 0, 0, 32)
targetBtnContainer.Position = UDim2.new(0, 0, 0, 188)
targetBtnContainer.BackgroundTransparency = 1
targetBtnContainer.Parent = content

local targetButtons = {}
local function makeTargetBtn(text, xScale)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.32, 0, 1, 0)
    btn.Position = UDim2.new(xScale, 0, 0, 0)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(180, 180, 180)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.Parent = targetBtnContainer
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    local st = Instance.new("UIStroke", btn)
    st.Color = Color3.fromRGB(80, 80, 100)
    st.Thickness = 1
    table.insert(targetButtons, {btn = btn, stroke = st})
    return btn
end

local headBtn = makeTargetBtn("Head", 0)
local chestBtn = makeTargetBtn("Chest", 0.34)
local randomBtn = makeTargetBtn("Random", 0.68)

local function selectTarget(name)
    targetMode = name
    for _, tb in ipairs(targetButtons) do
        if tb.btn.Text == name then
            tb.btn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
            tb.btn.TextColor3 = Color3.new(1,1,1)
            tb.stroke.Color = Color3.fromRGB(100, 200, 255)
        else
            tb.btn.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
            tb.btn.TextColor3 = Color3.fromRGB(180, 180, 180)
            tb.stroke.Color = Color3.fromRGB(80, 80, 100)
        end
    end
end

headBtn.MouseButton1Click:Connect(function() selectTarget("Head") end)
chestBtn.MouseButton1Click:Connect(function() selectTarget("Chest") end)
randomBtn.MouseButton1Click:Connect(function() selectTarget("Random") end)
selectTarget("Head")

local teamLabel = Instance.new("TextLabel")
teamLabel.Size = UDim2.new(1, 0, 0, 22)
teamLabel.Position = UDim2.new(0, 0, 0, 235)
teamLabel.BackgroundTransparency = 1
teamLabel.Text = "✓ Team Check"
teamLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
teamLabel.TextXAlignment = Enum.TextXAlignment.Left
teamLabel.Font = Enum.Font.Gotham
teamLabel.TextSize = 13
teamLabel.Parent = content

-- Botón flotante con imagen
local openBtn = Instance.new("ImageButton")
openBtn.Size = UDim2.new(0, 65, 0, 65)
openBtn.Position = UDim2.new(0, 20, 0.5, -32)
openBtn.BackgroundColor3 = Color3.fromRGB(14, 14, 24)
openBtn.Image = IMAGE_ID
openBtn.Parent = mainGui
Instance.new("UICorner", openBtn).CornerRadius = UDim.new(1, 0)
local openBtnStroke = Instance.new("UIStroke", openBtn)
openBtnStroke.Color = Color3.fromRGB(0, 150, 255)
openBtnStroke.Thickness = 2

-- Drag del panel por header
local panelDragging = false
local panelDragStart, panelDragOrigin

local function isOnClose(pos)
    local cp = closeBtn.AbsolutePosition
    local cs = closeBtn.AbsoluteSize
    return pos.X >= cp.X and pos.X <= cp.X + cs.X and pos.Y >= cp.Y and pos.Y <= cp.Y + cs.Y
end

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        if isOnClose(input.Position) then return end
        panelDragging = true
        panelDragStart = input.Position
        panelDragOrigin = mainFrame.Position
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if panelDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local d = input.Position - panelDragStart
        mainFrame.Position = UDim2.new(
            panelDragOrigin.X.Scale, panelDragOrigin.X.Offset + d.X,
            panelDragOrigin.Y.Scale, panelDragOrigin.Y.Offset + d.Y
        )
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        panelDragging = false
    end
end)

-- Drag + click del botón imagen
local imgStart, imgStartPos
local imgDragging, imgMoved = false, false

openBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        imgStartPos = openBtn.Position
        imgStart = input.Position
        imgDragging = true
        imgMoved = false
        local moveConn, endConn
        moveConn = UserInputService.InputChanged:Connect(function(inp)
            if imgDragging and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
                local d = inp.Position - imgStart
                if d.Magnitude > 5 then imgMoved = true end
                if imgMoved then
                    openBtn.Position = UDim2.new(
                        imgStartPos.X.Scale, imgStartPos.X.Offset + d.X,
                        imgStartPos.Y.Scale, imgStartPos.Y.Offset + d.Y
                    )
                end
            end
        end)
        endConn = UserInputService.InputEnded:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
                imgDragging = false
                moveConn:Disconnect()
                endConn:Disconnect()
                if not imgMoved then
                    mainFrame.Visible = not mainFrame.Visible
                end
            end
        end)
    end
end)

closeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
end)

-- FOV circle
local hasDrawing = (typeof(Drawing) == "table") and Drawing.new
local fovCircleDrawing, fovCircleFrame

if hasDrawing then
    fovCircleDrawing = Drawing.new("Circle")
    fovCircleDrawing.Thickness = 2
    fovCircleDrawing.Color = Color3.fromRGB(0, 150, 255)
    fovCircleDrawing.Filled = false
    fovCircleDrawing.NumSides = 64
    fovCircleDrawing.Transparency = 1
    fovCircleDrawing.Visible = false
else
    fovCircleFrame = Instance.new("Frame")
    fovCircleFrame.BackgroundTransparency = 1
    fovCircleFrame.Visible = false
    fovCircleFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    fovCircleFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    fovCircleFrame.Parent = mainGui
    Instance.new("UICorner", fovCircleFrame).CornerRadius = UDim.new(1, 0)
    local st = Instance.new("UIStroke", fovCircleFrame)
    st.Color = Color3.fromRGB(0, 150, 255)
    st.Thickness = 2
end

-- Auto-abrir al terminar la intro
task.delay(7, function()
    if mainFrame and mainFrame.Parent then
        mainFrame.Visible = true
    end
end)-- ============================================================
-- PXZD HUB v3 - PARTE 4/4
-- AIMBOT: Head/Chest/Random + Team Check + LOS + FOV
-- ============================================================

RunService.RenderStepped:Connect(function()
    if hasDrawing then
        if aimbotEnabled then
            fovCircleDrawing.Visible = true
            fovCircleDrawing.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
            fovCircleDrawing.Radius = fovValue
            fovCircleDrawing.Color = Color3.fromRGB(0, 150, 255)
        else
            fovCircleDrawing.Visible = false
        end
    else
        if aimbotEnabled then
            fovCircleFrame.Visible = true
            fovCircleFrame.Size = UDim2.new(0, fovValue * 2, 0, fovValue * 2)
        else
            fovCircleFrame.Visible = false
        end
    end
end)

local function isTeammate(player)
    if not player or player == LocalPlayer then return false end
    if player.Team and LocalPlayer.Team and player.Team == LocalPlayer.Team then return true end
    if player.TeamColor and LocalPlayer.TeamColor and player.TeamColor == LocalPlayer.TeamColor then return true end
    return false
end

local function hasLOS(targetPart)
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    local exclude = {targetPart.Parent}
    if LocalPlayer.Character then table.insert(exclude, LocalPlayer.Character) end
    params.FilterDescendantsInstances = exclude
    local origin = Camera.CFrame.Position
    local diff = targetPart.Position - origin
    local result = Workspace:Raycast(origin, diff, params)
    return result == nil
end

local function getTargetPart(character)
    if targetMode == "Head" then
        return character:FindFirstChild("Head") or character:FindFirstChild("HumanoidRootPart")
    elseif targetMode == "Chest" then
        return character:FindFirstChild("UpperTorso")
            or character:FindFirstChild("Torso")
            or character:FindFirstChild("HumanoidRootPart")
    else
        local parts = {}
        local head = character:FindFirstChild("Head")
        local torso = character:FindFirstChild("UpperTorso") or character:FindFirstChild("Torso")
        local hrp = character:FindFirstChild("HumanoidRootPart")
        if head then table.insert(parts, head) end
        if torso then table.insert(parts, torso) end
        if hrp then table.insert(parts, hrp) end
        if #parts == 0 then return nil end
        return parts[math.random(1, #parts)]
    end
end

local function getTarget()
    local best, bestDist = nil, math.huge
    local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid and humanoid.Health > 0 and not isTeammate(player) then
                local targetPart = getTargetPart(player.Character)
                if targetPart then
                    local screenPos, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
                    if onScreen then
                        local d = (Vector2.new(screenPos.X, screenPos.Y) - center).Magnitude
                        if d <= fovValue and d < bestDist and hasLOS(targetPart) then
                            bestDist = d
                            best = targetPart
                        end
                    end
                end
            end
        end
    end
    return best
end

RunService.RenderStepped:Connect(function()
    if not aimbotEnabled then return end
    local target = getTarget()
    if target then
        local targetCF = CFrame.lookAt(Camera.CFrame.Position, target.Position)
        Camera.CFrame = Camera.CFrame:Lerp(targetCF, smoothValue)
    end
end)

aimbotBtn.MouseButton1Click:Connect(function()
    aimbotEnabled = not aimbotEnabled
    if aimbotEnabled then
        aimbotBtn.Text = "AIMBOT: ON"
        aimbotBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
        aimbotBtn.TextColor3 = Color3.new(1,1,1)
        aimbotBtnStroke.Color = Color3.fromRGB(100, 200, 255)
        TweenService:Create(mainStroke, TweenInfo.new(0.3), {Color = Color3.fromRGB(0, 200, 255)}):Play()
    else
        aimbotBtn.Text = "ACTIVE AIMBOT"
        aimbotBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
        aimbotBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
        aimbotBtnStroke.Color = Color3.fromRGB(80, 80, 100)
        TweenService:Create(mainStroke, TweenInfo.new(0.3), {Color = Color3.fromRGB(0, 150, 255)}):Play()
    end
end)

print("[PXZD HUB v3] Cargado. Intro: 7s | Target: " .. targetMode)
