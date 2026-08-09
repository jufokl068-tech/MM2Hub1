-- Delta MM2 Hub - Direkt Çalışan Arayüz
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local Workspace = game:GetService("Workspace")

-- Eğer daha önceden açık bir menü varsa temizle
if PlayerGui:FindFirstChild("DeltaMM2Hub") then
    PlayerGui.DeltaMM2Hub:Destroy()
end

-- Ana Ekran ve Arayüz (Execute edildiği an görünür)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DeltaMM2Hub"
ScreenGui.Parent = PlayerGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -190)
MainFrame.Size = UDim2.new(0, 320, 0, 380)
MainFrame.Visible = true -- Direkt görünür şekilde başlar

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

-- Başlık Çubuğu
local TitleBar = Instance.new("Frame")
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Color3.fromRGB(34, 34, 40)
TitleBar.Size = UDim2.new(1, 0, 0, 45)

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = TitleBar

local TitleText = Instance.new("TextLabel")
TitleText.Parent = TitleBar
TitleText.BackgroundTransparency = 1
TitleText.Size = UDim2.new(1, 0, 1, 0)
TitleText.Font = Enum.Font.GothamBold
TitleText.Text = "MM2 Ultimate Hub"
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.TextSize = 16

-- Buton Oluşturma Fonksiyonu
local function createButton(name, posY)
    local btn = Instance.new("TextButton")
    btn.Parent = MainFrame
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
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

-- Özellik Butonları
local EspBtn = createButton("Sheriff / Murder ESP", 0.17)
local SpeedBtn = createButton("Hız Hilesi (WalkSpeed)", 0.33)
local CoinFarmBtn = createButton("Otomatik Coin Toplama", 0.49)
local GunDropBtn = createButton("Sheriff Silahını Al (Drop)", 0.65)
local TeleportLobbyBtn = createButton("Lobiye Işınlan", 0.81)

-- 1. ESP Özelliği
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

-- 2. Hız Hilesi
SpeedBtn.MouseButton1Click:Connect(function()
    local char = Player.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = 24
        SpeedBtn.Text = "Hız Artırıldı (24)"
        SpeedBtn.TextColor3 = Color3.fromRGB(0, 255, 120)
    end
end)

-- 3. Coin Toplama
CoinFarmBtn.MouseButton1Click:Connect(function()
    CoinFarmBtn.Text = "Coin Toplama Çalışıyor..."
    task.spawn(function()
        while true do
            task.wait(0.5)
            local coinContainer = Workspace:FindFirstChild("CoinContainer") or Workspace:FindFirstChild("Normal")
            if coinContainer then
                for _, coin in pairs(coinContainer:GetChildren()) do
                    if coin:FindFirstChild("Hitbox") and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                        Player.Character.HumanoidRootPart.CFrame = coin.Hitbox.CFrame
                        task.wait(0.1)
                    end
                end
            end
        end
    end)
end)

-- 4. Silah Drop Bulma
GunDropBtn.MouseButton1Click:Connect(function()
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj.Name == "GunDrop" and obj:IsA("BasePart") and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            Player.Character.HumanoidRootPart.CFrame = obj.CFrame
            GunDropBtn.Text = "Silah Alındı!"
            GunDropBtn.TextColor3 = Color3.fromRGB(0, 255, 120)
            break
        end
    end
end)

-- 5. Lobiye Işınlanma
TeleportLobbyBtn.MouseButton1Click:Connect(function()
    if Workspace:FindFirstChild("Lobby") and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        Player.Character.HumanoidRootPart.CFrame = CFrame.new(0, 100, 0)
    end
end)

print("MM2 Hub Başarıyla Yüklendi ve Açıldı!")
