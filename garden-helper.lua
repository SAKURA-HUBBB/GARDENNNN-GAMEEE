-- 🌸 Sakura Garden Helper dengan Floating Logo Button
-- By Sakura Developer

-- Load Orion UI Library
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()

-- Variabel toggle cheat
getgenv().AutoFarm = false
getgenv().AutoUpgrade = false
getgenv().AutoSteal = false

-- == FUNGSI GUI UTAMA ==
function OpenMainGUI()
    local Window = OrionLib:MakeWindow({
        Name = "🌸 Sakura Garden Helper",
        HidePremium = false,
        SaveConfig = true,
        ConfigFolder = "GardenHelper"
    })

    local AutoTab = Window:MakeTab({
        Name = "🌾 Auto Farm",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })

    AutoTab:AddToggle({
        Name = "🌱 Auto Farm Sendiri",
        Default = false,
        Callback = function(state)
            getgenv().AutoFarm = state
            if state then
                task.spawn(function()
                    while getgenv().AutoFarm do
                        for _,v in pairs(workspace:GetDescendants()) do
                            if v.Name == "Plant" and v:FindFirstChild("Harvest") then
                                fireclickdetector(v.Harvest.ClickDetector)
                            end
                        end
                        task.wait(0.3)
                    end
                end)
            end
        end
    })

    AutoTab:AddToggle({
        Name = "😈 Auto Steal Tanaman Orang",
        Default = false,
        Callback = function(state)
            getgenv().AutoSteal = state
            if state then
                task.spawn(function()
                    while getgenv().AutoSteal do
                        for _,v in pairs(workspace:GetDescendants()) do
                            if v.Name == "Plant" and v:FindFirstChild("Owner") then
                                if v.Owner.Value ~= game.Players.LocalPlayer then
                                    if v:FindFirstChild("Harvest") then
                                        fireclickdetector(v.Harvest.ClickDetector)
                                    end
                                end
                            end
                        end
                        task.wait(0.5)
                    end
                end)
            end
        end
    })

    AutoTab:AddToggle({
        Name = "⬆ Auto Upgrade",
        Default = false,
        Callback = function(state)
            getgenv().AutoUpgrade = state
            if state then
                task.spawn(function()
                    while getgenv().AutoUpgrade do
                        local upgrade = workspace:FindFirstChild("UpgradeShop")
                        if upgrade and upgrade:FindFirstChild("ProximityPrompt") then
                            fireproximityprompt(upgrade.ProximityPrompt)
                        end
                        task.wait(2)
                    end
                end)
            end
        end
    })

    local MoveTab = Window:MakeTab({
        Name = "🏃 Movement",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })

    MoveTab:AddSlider({
        Name = "WalkSpeed",
        Min = 16,
        Max = 200,
        Default = 50,
        Color = Color3.fromRGB(0,255,0),
        Increment = 1,
        Callback = function(v)
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v
        end    
    })

    MoveTab:AddSlider({
        Name = "JumpPower",
        Min = 50,
        Max = 300,
        Default = 120,
        Color = Color3.fromRGB(255,0,0),
        Increment = 5,
        Callback = function(v)
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = v
        end    
    })

    local MiscTab = Window:MakeTab({
        Name = "💰 Misc",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })

    MiscTab:AddButton({
        Name = "💸 Infinite Coins (Client)",
        Callback = function()
            local stats = game.Players.LocalPlayer:FindFirstChild("leaderstats")
            if stats and stats:FindFirstChild("Coins") then
                stats.Coins.Value = 999999999
            end
            OrionLib:MakeNotification({
                Name = "Done!",
                Content = "Coins set to 999999999 (client side)",
                Image = "rbxassetid://4483345998",
                Time = 3
            })
        end    
    })

    MiscTab:AddButton({
        Name = "🌀 Teleport ke Shop",
        Callback = function()
            local char = game.Players.LocalPlayer.Character
            if workspace:FindFirstChild("UpgradeShop") then
                char:MoveTo(workspace.UpgradeShop.Position)
            end
        end    
    })

    OrionLib:Init()
end

-- == FLOATING BUTTON LOGO ==
local CoreGui = game:GetService("CoreGui")
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = CoreGui

local OpenButton = Instance.new("ImageButton")
OpenButton.Size = UDim2.new(0, 60, 0, 60)
OpenButton.Position = UDim2.new(0, 20, 0, 200) -- pojok kiri
OpenButton.Image = "rbxassetid://7743878858" -- logo (ganti kalau mau)
OpenButton.BackgroundTransparency = 0.2
OpenButton.BackgroundColor3 = Color3.fromRGB(255, 192, 203)
OpenButton.Parent = ScreenGui

-- Tooltip kecil
local TextLabel = Instance.new("TextLabel")
TextLabel.Text = "Klik Logo 🌸"
TextLabel.Size = UDim2.new(0, 80, 0, 20)
TextLabel.Position = UDim2.new(0, 0, 1, 0)
TextLabel.TextColor3 = Color3.fromRGB(255,255,255)
TextLabel.BackgroundTransparency = 1
TextLabel.Parent = OpenButton

-- Saat klik logo → buka GUI utama
OpenButton.MouseButton1Click:Connect(function()
    OpenButton.Visible = false -- hilangin logo setelah klik
    OpenMainGUI() -- panggil GUI utama
end)

-- Notifikasi awal
game.StarterGui:SetCore("SendNotification",{
    Title = "🌸 Sakura Garden Helper",
    Text = "Klik logo kecil di kiri untuk membuka menu!",
    Duration = 6
})
