-- Delta MM2 Pro Hub - Stabil Sürüm
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local Workspace = game:GetService("Workspace")

if PlayerGui:FindFirstChild("DeltaMM2Hub") then
    PlayerGui.DeltaMM2Hub:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DeltaMM2Hub"
ScreenGui.Parent = PlayerGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -190)
MainFrame.Size = UDim2.new(0, 320, 0, 380)
MainFrame.Visible = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

local TitleBar = Instance.new("Frame")
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
TitleBar.Size = UDim2.new(1, 0, 0, 45)

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = TitleBar

local TitleText = Instance.new("TextLabel")
TitleText.Parent = TitleBar
TitleText.BackgroundTransparency = 1
TitleText.Size = UDim2.new(1, 0, 1, 0)
TitleText.Font = Enum.Font.GothamBold
TitleText.Text = "MM2 Pro Hub"
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.TextSize = 16

local function createButton(name, posY)
    local btn = Instance.new("TextButton")
    btn.Parent = MainFrame
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    btn.Position = UDim2.new(0.07, 0, posY, 0)
    btn.Size = UDim2.new(0.86, 0, 0, 42)
    btn.Font = Enum.Font.GothamSemibold
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(240, 240, 240)
    btn.TextSize = 14
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn
    
    return btn
end

local EspBtn = createButton("Sheriff / Murder ESP", 0.17)
local SpeedBtn = createButton("Hız Hilesi (WalkSpeed)", 0.33)
local CoinFarmBtn = createButton("Coin Teleport (Oto)", 0.49)
local GunDropBtn = createButton("Silah Drop Bul", 0.65)
local CloseBtn = createButton("Menüyü Kapat", 0.81)

EspBtn.MouseButton1Click:Connect(function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= Player and p.Character then
            if not p.Character:FindFirstChild("Highlight") then
                local hl = Instance.new("Highlight")
                hl.Parent = p.Character
                hl.Adornee = p.Character
                hl.FillColor = Color3.fromRGB(255, 0, 0)
                hl.OutlineColor = Color3.fromRGB(255, 255, 255)
            end
        end
    end
    EspBtn.Text = "ESP Aktif Edildi!"
    EspBtn.TextColor3 = Color3.fromRGB(0, 255, 120)
end)

SpeedBtn.MouseButton1Click:Connect(function()
    local char = Player.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = 25
        SpeedBtn.Text = "Hız: 25 Yapıldı"
        SpeedBtn.TextColor3 = Color3.fromRGB(0, 255, 120)
    end
end)

CoinFarmBtn.MouseButton1Click:Connect(function()
    CoinFarmBtn.Text = "Coin Toplanıyor..."
    task.spawn(function()
        while true do
            task.wait(0.4)
            pcall(function()
                local coins = Workspace:FindFirstChild("CoinContainer") or Workspace:FindFirstChild("Normal")
                if coins and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                    for _, coin in pairs(coins:GetChildren()) do
                        if coin:FindFirstChild("Hitbox") then
                            Player.Character.HumanoidRootPart.CFrame = coin.Hitbox.CFrame
                            task.wait(0.1)
                        end
                    end
                end
            end)
        end
    end)
end)

GunDropBtn.MouseButton1Click:Connect(function()
    pcall(function()
        for _, obj in pairs(Workspace:GetDescendants()) do
            if obj.Name == "GunDrop" and obj:IsA("BasePart") and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                Player.Character.HumanoidRootPart.CFrame = obj.CFrame
                GunDropBtn.Text = "Silah Alındı!"
                GunDropBtn.TextColor3 = Color3.fromRGB(0, 255, 120)
                break
            end
        end
    end)
end)

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)
