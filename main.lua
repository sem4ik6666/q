-- Anti-AFK
local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
   vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
   wait(1)
   vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

-- Anti-Staff System
spawn(function()
    local Players = game:GetService("Players")
    local function onPlayerAdded(player)
        if player:GetRankInGroup(11987919) >149 then
            game.Players.LocalPlayer:Kick("Auto Kicked Due to Staff Member "..player.Name.." joined your game")
        else
            warn(player.Name,"just joined the game")
        end
    end
end)

spawn(function()
    warn("Anti Staff is now running")
    while wait() do
        for i,v in pairs(game.Players:GetPlayers()) do
            if v:GetRankInGroup(11987919) >149 then
                game.Players.LocalPlayer:Kick("Auto Kicked Due to Staff Member "..v.Name.." is in your game")
            end
        end
        wait(5)
    end
end)

-- Rayfield UI Library
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Taxi Boss",
   LoadingTitle = "Taxi Boss",
   LoadingSubtitle = "Script Loaded",
   ConfigurationSaving = {
      Enabled = false
   }
})

-- Main Tab
local MainTab = Window:CreateTab("Main", 4483362458)

-- Auto Destroy Pumpkins
MainTab:CreateToggle({
   Name = "Auto Destroy Pumpkins",
   CurrentValue = false,
   Callback = function(Value)
        getfenv().candy = Value
        local function findCar()
            local car = nil
            for i,v in pairs(workspace.Vehicles:GetChildren()) do
                if v:GetAttribute("owner") == game.Players.LocalPlayer.UserId then
                    car = v
                end
            end
            return car
        end
        
        while getfenv().candy do
            task.wait()
            pcall(function()
                for i,v in pairs(workspace.Pumpkins:GetDescendants()) do
                    if v.Name == "TouchInterest" then
                        firetouchinterest(findCar().PrimaryPart,v.Parent,0)
                        firetouchinterest(findCar().PrimaryPart,v.Parent,0)
                        task.wait(0.2)
                    end
                end
            end)
        end
   end,
})

-- Auto Collect Parts
MainTab:CreateToggle({
   Name = "Auto Collect Parts",
   CurrentValue = false,
   Callback = function(Value)
        getfenv().partcollector = Value
        while getfenv().partcollector do
            task.wait()
            for a,b in pairs(workspace.ItemSpawnLocations:GetChildren()) do
                if getfenv().partcollector then
                    local timer = tick()
                    repeat task.wait()
                        game.Players.LocalPlayer.Character:PivotTo(b.CFrame+Vector3.new(0,251,0))
                    until tick()-timer >= 2
                    for i,v in pairs(workspace.ItemSpawnLocations:GetDescendants()) do
                        if v.Name == "TouchInterest" then
                            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart,v.Parent,0)
                            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart,v.Parent,1)
                        end
                    end
                end
            end
        end
   end,
})

-- Auto Money
MainTab:CreateToggle({
   Name = "Auto Money",
   CurrentValue = false,
   Callback = function(Value)
        getfenv().test2 = Value
        pcall(function()
            game:GetService("ReplicatedStorage").Quests.Contracts.CancelContract:InvokeServer(game:GetService("Players").LocalPlayer.ActiveQuests:FindFirstChildOfClass("StringValue").Name)
            game:GetService("ReplicatedStorage").Quests.Contracts.CancelContract:InvokeServer(game:GetService("Players").LocalPlayer.ActiveQuests:FindFirstChildOfClass("StringValue").Name)
        end)
        
        while getfenv().test2 do
            wait()
            if not game:GetService("Players").LocalPlayer.ActiveQuests:FindFirstChild("contractBuildMaterial") then
                game:GetService("ReplicatedStorage").Quests.Contracts.StartContract:InvokeServer("contractBuildMaterial")
                repeat task.wait()
                until game:GetService("Players").LocalPlayer.ActiveQuests:FindFirstChild("contractBuildMaterial")
            end
            
            repeat task.wait()
                task.spawn(function()
                    game:GetService("ReplicatedStorage").Quests.DeliveryComplete:InvokeServer("contractMaterial")
                    game:GetService("ReplicatedStorage").Quests.DeliveryComplete:InvokeServer("contractMaterial")
                    game:GetService("ReplicatedStorage").Quests.DeliveryComplete:InvokeServer("contractMaterial")
                end)
            until game:GetService("Players").LocalPlayer.ActiveQuests.contractBuildMaterial.Value == "!pw5pi3ps2"
            
            wait()
            game:GetService("ReplicatedStorage").Quests.Contracts.CompleteContract:InvokeServer()
        end
   end,
})

-- Auto Money [auto rejoin]
MainTab:CreateButton({
   Name = "Auto Money [auto rejoin]",
   Callback = function()
        writefile("taxibossautomoney.txt",game:HttpGet("https://pastebin.com/raw/HuKppzEV"))
        loadstring(game:HttpGet("https://pastebin.com/raw/HuKppzEV"))()
   end,
})

-- Auto Customers [Beta]
MainTab:CreateToggle({
   Name = "Auto Customers [Beta]",
   CurrentValue = false,
   Callback = function(Value)
        getfenv().customersfarm = Value
        pcall(function()
            game:GetService("Workspace").GaragePlate:Destroy()
        end)
        
        for i,v in pairs(game:GetService("Workspace").World.Industrial.Port:GetChildren()) do
            if string.find(v.Name,"Container") then
                v:Destroy()
            end
        end
        
        getfenv().numbers = 0
        getfenv().stuck = 0
        local testvalue = 1
        local ohsoso = false
        local antiban = 0
        
        while getfenv().customersfarm do
            wait()
            pcall(function()
                if game.Players.LocalPlayer.Character.Humanoid.SeatPart ~= nil then
                    local chr = game.Players.LocalPlayer.Character
                    local car = chr.Humanoid.SeatPart.Parent.Parent
                    local raycastParams = RaycastParams.new()
                    raycastParams.FilterDescendantsInstances = {chr,car,workspace.Camera}
                    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
                    raycastParams.IgnoreWater = false
                    ohsoso = false
                    
                    if game:GetService("Players").LocalPlayer.variables.inMission.Value == true and not game:GetService("Workspace").ParkingMarkers:FindFirstChild("destinationPart") then
                        antiban=antiban+1
                        wait(1)
                    elseif antiban > 10 then
                        game.Players.LocalPlayer:Kick("Kicked Due to game being glitched")
                    end
                    
                    if game:GetService("Players").LocalPlayer.variables.inMission.Value == true and game:GetService("Workspace").ParkingMarkers:FindFirstChild("destinationPart") and game.Players.LocalPlayer:DistanceFromCharacter(game:GetService("Workspace").ParkingMarkers:WaitForChild("destinationPart").Position) < 50 then
                        testvalue = 1
                        car:SetPrimaryPartCFrame(game:GetService("Workspace").ParkingMarkers.destinationPart.CFrame+Vector3.new(0,3,0))
                        car.PrimaryPart.Velocity = Vector3.new(0,0,0)
                        game:GetService("VirtualInputManager"):SendKeyEvent(true,304,false,game)
                        wait(1)
                        car:SetPrimaryPartCFrame(game:GetService("Workspace").ParkingMarkers.destinationPart.CFrame+Vector3.new(0,3,0))
                        car.PrimaryPart.Velocity = Vector3.new(0,0,0)
                        game:GetService("VirtualInputManager"):SendKeyEvent(true,304,false,game)
                        wait()
                        
                        local dcframe = game:GetService("Workspace").ParkingMarkers.destinationPart.CFrame
                        repeat wait()
                            if (car.PrimaryPart.Position-Vector3.new(dcframe.X,dcframe.Y,dcframe.Z)).magnitude > 3 then
                                car.PrimaryPart.Velocity = Vector3.new(0,0,0)
                                car:PivotTo(dcframe)
                                wait(0.1)
                                game:GetService("VirtualInputManager"):SendKeyEvent(true,304,false,game)
                                car.PrimaryPart.Velocity = Vector3.new(0,0,0)
                            end
                        until not game:GetService("Workspace").ParkingMarkers:FindFirstChild("destinationPart") or getfenv().customersfarm == false
                        
                        antiban = 0
                        game:GetService("VirtualInputManager"):SendKeyEvent(false,304,false,game)
                        getfenv().numbers=getfenv().numbers+1
                        testvalue = 1
                        task.wait()
                        
                    elseif workspace:Raycast(game.Players.LocalPlayer.Character.HumanoidRootPart.Position, Vector3.new(0, -100, 0),raycastParams).Instance.Name == "Terrain" and ohsoso == false then
                        getfenv().rat = nil
                        local distance = math.huge
                        for i,v in pairs(game:GetService("Workspace").World:GetDescendants()) do
                            if string.find(v.Name,"road") and v.ClassName == "Part" or string.find(v.Name,"Road") and v.ClassName == "Part" then
                                local Dist = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-v.Position).magnitude
                                if Dist < distance then
                                    distance = Dist
                                    getfenv().rat = v
                                end
                            end
                        end
                        car:PivotTo(getfenv().rat.CFrame)
                        ohsoso = true
                        
                    elseif game:GetService("Players").LocalPlayer.variables.inMission.Value == true then
                        warn("Tester")
                        local chr = game.Players.LocalPlayer.Character
                        local car = chr.Humanoid.SeatPart.Parent.Parent
                        print(testvalue)
                        testvalue = testvalue-.02 
                        
                        if testvalue < 0 then
                            getfenv().rat = nil
                            local distance = math.huge
                            for i,v in pairs(game:GetService("Workspace").World:GetDescendants()) do
                                if string.find(v.Name,"road") and v.ClassName == "Part" or string.find(v.Name,"Road") and v.ClassName == "Part" then
                                    local Dist = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-v.Position).magnitude
                                    if Dist < distance then
                                        distance = Dist
                                        getfenv().rat = v
                                    end
                                end
                            end
                            car:PivotTo(getfenv().rat.CFrame)
                            getfenv().stuck = getfenv().stuck+1
                            testvalue = 1 
                        end
                        
                        pcall(function()
                            local PathfindingService = game:GetService("PathfindingService")
                            local TweenService = game:GetService("TweenService")
                            local part1 = game.Players.LocalPlayer.Character.HumanoidRootPart
                            local part2 = game:GetService("Workspace").ParkingMarkers.destinationPart
                            local whatever = part1.CFrame:lerp(part2.CFrame, testvalue)
                            local iguess = Vector3.new(whatever.X,part2.Position.Y,whatever.Z)
                            local carprimary = car
                            local destination = iguess
                            
                            local path = PathfindingService:CreatePath({AgentRadius = 20})
                            path:ComputeAsync(carprimary.PrimaryPart.Position, destination)
                            local waypoints = path:GetWaypoints()
                            
                            for yay, waypoint in pairs(waypoints) do
                                print("test")
                                local part = Instance.new("Part")
                                part.Shape = "Ball"
                                part.Size = Vector3.new(0.6, 0.6, 0.6)
                                part.Position = waypoint.Position
                                part.Anchored = true
                                part.CanCollide = false
                                part.Parent = game.Workspace
                                
                                local chr = game.Players.LocalPlayer.Character
                                local car = chr.Humanoid.SeatPart.Parent.Parent
                                local raycastParams = RaycastParams.new()
                                raycastParams.FilterDescendantsInstances = {chr,car,workspace.Camera}
                                raycastParams.FilterType = Enum.RaycastFilterType.Exclude
                                raycastParams.IgnoreWater = true
                                
                                if workspace:Raycast(waypoint.Position, Vector3.new(0, 1000, 0),raycastParams) == nil then
                                    car:PivotTo(part.CFrame+Vector3.new(0,5,0))
                                    part:Destroy()
                                    testvalue = 1
                                    task.wait(0.009)
                                elseif workspace:Raycast(waypoint.Position, Vector3.new(0, 1000, 0),raycastParams) ~= nil then
                                    print(workspace:Raycast(waypoint.Position, Vector3.new(0, 1000, 0),raycastParams))
                                    part:Destroy()
                                    testvalue = 1
                                end
                            end
                        end)
                        
                    elseif game:GetService("Players").LocalPlayer.variables.inMission.Value == false then
                        getfenv().rat = nil
                        local distance = math.huge
                        for i,v in pairs(game:GetService("Workspace").NewCustomers:GetDescendants()) do
                            if v.Name == "Part" and v:GetAttribute("GroupSize") ~= nil and v:FindFirstChildOfClass("CFrameValue") and game.Players.LocalPlayer.variables.seatAmount.Value > v:GetAttribute("GroupSize") and v:GetAttribute("Rating") < game:GetService("Players").LocalPlayer.variables.vehicleRating.Value and game:GetService("Players").LocalPlayer.variables.inMission.Value == false then
                                print(v)
                                local Dist = (v.Position-Vector3.new(v:FindFirstChildOfClass("CFrameValue").Value.X,v:FindFirstChildOfClass("CFrameValue").Value.Y,v:FindFirstChildOfClass("CFrameValue").Value.Z)).magnitude
                                if Dist < distance then
                                    distance = Dist
                                    getfenv().rat = v
                                end
                            end
                        end
                        
                        for ok,ya in pairs(game:GetService("Workspace").Vehicles:GetDescendants()) do
                            if ya.Name == "Player" and ya.Value == game.Players.LocalPlayer then
                                ya.Parent.Parent:SetPrimaryPartCFrame(getfenv().rat.CFrame*CFrame.new(0,3,0))
                                wait(1)
                                fireproximityprompt(getfenv().rat.Client.PromptPart.CustomerPrompt)
                                wait(3)
                            end
                        end
                    end
                    
                elseif game.Players.LocalPlayer.Character.Humanoid.SeatPart == nil then
                    game:GetService("ReplicatedStorage").Vehicles.GetNearestSpot:InvokeServer(game:GetService("Players").LocalPlayer.variables.carId.Value)
                    wait(0.5)
                    game:GetService("ReplicatedStorage").Vehicles.EnterVehicleEvent:InvokeServer()
                end
            end)
        end
   end,
})

-- Auto Trophies
MainTab:CreateToggle({
   Name = "Auto Trophies",
   CurrentValue = false,
   Callback = function(Value)
        getfenv().Trophies = Value
        game:GetService("ReplicatedStorage").Race.LeaveRace:InvokeServer()
        getfenv().showui = getfenv().Trophies
        
        spawn(function()
            if getfenv().showui == false and game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.Money:FindFirstChild("Rep") then
                game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.Money.Rep:Destroy()
            else
                while getfenv().showui do
                    task.wait()
                    if not game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.Money:FindFirstChild("Rep") then
                        local oh = game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.Money.CashLabel:Clone()
                        oh.Name = "Rep"
                        oh.Parent = game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.Money
                        wait()
                        game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.Money.Rep.Position = UDim2.new(3,0,0,0)
                    else
                        game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.Money.Rep.Text = "Rep:"..tostring(game:GetService("Players").LocalPlayer.variables.rep.Value)
                    end
                end
            end
        end) 
        
        while getfenv().Trophies do
            task.wait()
            pcall(function()
                if game.Players.LocalPlayer.Character.Humanoid.Sit == true then
                    if game:GetService("Players").LocalPlayer.variables.race.Value == "none" then
                        task.wait()
                        game:GetService("ReplicatedStorage").Race.TimeTrial:InvokeServer("circuit", 5)
                    else
                        for a,b in pairs(game:GetService("Workspace").Vehicles:GetDescendants()) do
                            if b.Name == "Player" and b.Value == game.Players.LocalPlayer then
                                for i,v in pairs(game:GetService("Workspace").Races["circuit"].detects:GetChildren()) do
                                    if v.ClassName == "Part" and v:FindFirstChild("TouchInterest") then
                                        v.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                                        firetouchinterest(b.Parent.Parent.PrimaryPart,v,0)
                                        firetouchinterest(b.Parent.Parent.PrimaryPart,v,1)
                                    end
                                end
                                game:GetService("Workspace").Races["circuit"].timeTrial:FindFirstChildOfClass("IntValue").finish.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                                firetouchinterest(b.Parent.Parent.PrimaryPart,game:GetService("Workspace").Races["circuit"].timeTrial:FindFirstChildOfClass("IntValue").finish,0)
                                firetouchinterest(b.Parent.Parent.PrimaryPart,game:GetService("Workspace").Races["circuit"].timeTrial:FindFirstChildOfClass("IntValue").finish,1)
                            end
                        end   
                    end
                elseif game.Players.LocalPlayer.Character.Humanoid.Sit == false then
                    game:GetService("ReplicatedStorage").Vehicles.GetNearestSpot:InvokeServer(game:GetService("Players").LocalPlayer.variables.carId.Value)
                    wait(0.5)
                    game:GetService("ReplicatedStorage").Vehicles.EnterVehicleEvent:InvokeServer()
                end
            end)
        end
   end,
})

-- Auto TimeTrial Medals
MainTab:CreateToggle({
   Name = "Auto TimeTrial Medals",
   CurrentValue = false,
   Callback = function(Value)
        getfenv().medals = Value
        game:GetService("ReplicatedStorage").Race.LeaveRace:InvokeServer()
        
        while getfenv().medals do
            task.wait()
            if game.Players.LocalPlayer.Character.Humanoid.Sit == true then
                for round=1,3 do
                    for what,races in pairs(game:GetService("Workspace").Races:GetChildren()) do
                        if races.ClassName == "Folder" and getfenv().medals then
                            game:GetService("ReplicatedStorage").Race.TimeTrial:InvokeServer(races.Name, round)
                            wait()
                            
                            if game:GetService("Players").LocalPlayer.variables.race.Value == "none" then
                                task.wait()
                                game:GetService("ReplicatedStorage").Race.TimeTrial:InvokeServer(races.Name, round)
                            else
                                for a,b in pairs(game:GetService("Workspace").Vehicles:GetDescendants()) do
                                    if b.Name == "Player" and b.Value == game.Players.LocalPlayer then
                                        repeat wait()
                                            for i,v in pairs(game:GetService("Workspace").Races[races.Name].detects:GetChildren()) do
                                                if v.ClassName == "Part" and v:FindFirstChild("TouchInterest") then
                                                    v.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                                                    firetouchinterest(b.Parent.Parent.PrimaryPart,v,0)
                                                    firetouchinterest(b.Parent.Parent.PrimaryPart,v,1)
                                                end
                                            end
                                        until game:GetService("Workspace").Races[races.Name].timeTrial:FindFirstChildOfClass("IntValue") or getfenv().medals == false
                                        
                                        repeat wait()
                                            for i,v in pairs(game:GetService("Workspace").Races[races.Name].detects:GetChildren()) do
                                                if v.ClassName == "Part" and v:FindFirstChild("TouchInterest") then
                                                    v.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                                                    firetouchinterest(b.Parent.Parent.PrimaryPart,v,0)
                                                    firetouchinterest(b.Parent.Parent.PrimaryPart,v,1)
                                                end
                                            end
                                            pcall(function()
                                                game:GetService("Workspace").Races[races.Name].timeTrial:FindFirstChildOfClass("IntValue").finish.CFrame=game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                                                firetouchinterest(b.Parent.Parent.PrimaryPart,game:GetService("Workspace").Races[races.Name].timeTrial:FindFirstChildOfClass("IntValue").finish,0)
                                                firetouchinterest(b.Parent.Parent.PrimaryPart,game:GetService("Workspace").Races[races.Name].timeTrial:FindFirstChildOfClass("IntValue").finish,1)
                                            end)
                                        until game:GetService("Players").LocalPlayer.variables.race.Value == "none" or getfenv().medals == false
                                    end
                                end 
                            end
                        end
                    end
                end
            elseif game.Players.LocalPlayer.Character.Humanoid.Sit == false then
                game:GetService("ReplicatedStorage").Vehicles.GetNearestSpot:InvokeServer(game:GetService("Players").LocalPlayer.variables.carId.Value)
                wait(0.5)
                game:GetService("ReplicatedStorage").Vehicles.EnterVehicleEvent:InvokeServer()
            end
        end
   end,
})

-- Auto Upgrade Office
MainTab:CreateToggle({
   Name = "Auto Upgrade Office",
   CurrentValue = false,
   Callback = function(Value)
        getfenv().ofs = Value
        while getfenv().ofs do
            wait()
            if not game:GetService("Players").LocalPlayer:FindFirstChild("Office") then
                game:GetService("ReplicatedStorage").Company.StartOffice:InvokeServer()
                wait(0.2)
            end
            if game:GetService("Players").LocalPlayer.Office:GetAttribute("level") <16 then
                game:GetService("ReplicatedStorage").Company.SkipOfficeQuest:InvokeServer()
                game:GetService("ReplicatedStorage").Company.UpgradeOffice:InvokeServer()
            end
        end
   end,
})

-- Teleports Tab
local TeleportTab = Window:CreateTab("Teleports", 4483362458)

-- Teleport Locations
local teleportLocations = {
    ["Beechwood"] = CFrame.new(game:GetService("ReplicatedStorage").Places.Beechwood.Position),
    ["Beechwood Beach"] = CFrame.new(game:GetService("ReplicatedStorage").Places["Beechwood Beach"].Position),
    ["Boss Airport"] = CFrame.new(-637.1304931640625, 38.99796676635742, 4325.2275390625),
    ["Bridgeview"] = CFrame.new(1354.4610595703125, 10.30431079864502, 1278.8033447265625),
    ["Cedar Side"] = CFrame.new(game:GetService("ReplicatedStorage").Places["Cedar Side"].Position),
    ["Central Bank"] = CFrame.new(game:GetService("ReplicatedStorage").Places["Central Bank"].Position),
    ["Central City"] = CFrame.new(game:GetService("ReplicatedStorage").Places["Central City"].Position),
    ["City Park"] = CFrame.new(game:GetService("ReplicatedStorage").Places["City Park"].Position),
    ["Coconut Park"] = CFrame.new(game:GetService("ReplicatedStorage").Places["Coconut Park"].Position),
    ["Country Club"] = CFrame.new(game:GetService("ReplicatedStorage").Places["Country Club"].Position),
    ["Da Hills"] = CFrame.new(2348.347412109375, 73.10881805419922, -1537.3157958984375),
    ["Doge Harbor"] = CFrame.new(3335.737548828125, 24.955890655517578, 2773.038818359375),
    ["Gas Station"] = CFrame.new(103.700256, 0, -640.599792),
    ["Gas Station 2"] = CFrame.new(930.7002563476562, 0, 643.4002075195312),
    ["Harborview"] = CFrame.new(game:GetService("ReplicatedStorage").Places["Harborview"].Position),
    ["Hawthorn Park"] = CFrame.new(game:GetService("ReplicatedStorage").Places["Hawthorn Park"].Position),
    ["Hospital"] = CFrame.new(game:GetService("ReplicatedStorage").Places["Hospital"].Position),
    ["Industrial District"] = CFrame.new(game:GetService("ReplicatedStorage").Places["Industrial District"].Position),
    ["Logistic District"] = CFrame.new(588.2861938476562, 53.5777473449707, 2529.95361328125),
    ["Master Hotel"] = CFrame.new(2736.1591796875, 15.864909172058105, -202.09945678710938),
    ["Military Base"] = CFrame.new(game:GetService("ReplicatedStorage").Places["Military Base"].Position),
    ["Noll Cliffs"] = CFrame.new(game:GetService("ReplicatedStorage").Places["Noll Cliffs"].Position),
    ["Nuclear Power Plant"] = CFrame.new(game:GetService("ReplicatedStorage").Places["Nuclear Power Plant"].Position),
    ["OFF ROAD Test Track"] = CFrame.new(game:GetService("ReplicatedStorage").Places["OFF ROAD Test Track"].Position),
    ["Ocean Viewpoint"] = CFrame.new(game:GetService("ReplicatedStorage").Places["Ocean Viewpoint"].Position),
    ["Oil Refinery"] = CFrame.new(game:GetService("ReplicatedStorage").Places["Oil Refinery"].Position),
    ["Old Town"] = CFrame.new(game:GetService("ReplicatedStorage").Places["Old Town"].Position),
    ["Popular Street"] = CFrame.new(game:GetService("ReplicatedStorage").Places["Popular Street"].Position),
    ["Small Town"] = CFrame.new(game:GetService("ReplicatedStorage").Places["Small Town"].Position),
    ["St. Noll Viewpoint"] = CFrame.new(game:GetService("ReplicatedStorage").Places["St. Noll Viewpoint"].Position),
    ["Sunny Elementary"] = CFrame.new(game:GetService("ReplicatedStorage").Places["Sunny Elementary"].Position),
    ["Sunset Grove"] = CFrame.new(game:GetService("ReplicatedStorage").Places["Sunset Grove"].Position),
    ["Taxi Central"] = CFrame.new(game:GetService("ReplicatedStorage").Places["Taxi Central"].Position),
    ["high school"] = CFrame.new(game:GetService("ReplicatedStorage").Places["high school"].Position),
    ["mall"] = CFrame.new(game:GetService("ReplicatedStorage").Places["mall"].Position),
    ["the beach"] = CFrame.new(game:GetService("ReplicatedStorage").Places["the beach"].Position),
    ["🏎️ Race Club"] = CFrame.new(game:GetService("ReplicatedStorage").Places["🏎️ Race Club"].Position)
}

-- Create dropdown for teleports
local teleportOptions = {}
for name, _ in pairs(teleportLocations) do
    table.insert(teleportOptions, name)
end

table.sort(teleportOptions)

TeleportTab:CreateDropdown({
    Name = "Select Location",
    Options = teleportOptions,
    CurrentOption = "Select",
    Callback = function(Option)
        local location = teleportLocations[Option]
        if location then
            local chr = game.Players.LocalPlayer.Character
            local hum = chr.Humanoid
            if hum.SeatPart == nil then
                chr:PivotTo(location + Vector3.new(0,30,0))
            elseif hum.SeatPart ~= nil then
                hum.SeatPart.Parent.Parent:PivotTo(location + Vector3.new(0,40,0))
            end
            Rayfield:Notify({
                Title = "Teleported",
                Content = "Teleported to " .. Option,
                Duration = 3,
                Image = 4483362458
            })
        end
    end,
})

-- Miscellaneous Tab
local MiscTab = Window:CreateTab("Miscellaneous", 4483362458)

-- Vehicle Buyer
MiscTab:CreateInput({
    Name = "Vehicle Name",
    PlaceholderText = "Enter vehicle name",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        local car = tostring(Text)
        for i,v in pairs(require(game:GetService("ReplicatedStorage").ModuleLists.CarList)) do
            if string.find(v.name, car) then
                game:GetService("ReplicatedStorage").DataStore.PurchaseVehicle:InvokeServer(v.id)
                Rayfield:Notify({
                    Title = "Vehicle Purchased",
                    Content = "Bought: " .. v.name,
                    Duration = 3,
                    Image = 4483362458
                })
                break
            end
        end
    end,
})

-- Unlock Taxi Radar
MiscTab:CreateButton({
    Name = "Unlock Taxi Radar",
    Callback = function()
        game:GetService("Players").LocalPlayer.variables.vip.Value = true
        Rayfield:Notify({
            Title = "Taxi Radar Unlocked",
            Content = "VIP radar activated!",
            Duration = 3,
            Image = 4483362458
        })
    end,
})

-- Show Players Stats
MiscTab:CreateButton({
    Name = "Show Players Stats",
    Callback = function()
        game:GetService("VirtualInputManager"):SendKeyEvent(true,"F9",false,game)
        print("Players Owned Cars")
        for i,v in pairs(game.Players:GetChildren()) do
            if v.ClassName == "Player" then
                print("------------------"..v.Name.." OwnedCars".."------------------")
                local tables = {}
                local racetable = {}
                for a,b in pairs(v.Data.OwnedCars:GetChildren()) do
                    if b:IsA("BoolValue") and b.Value == true then
                        for c,d in pairs(require(game:GetService("ReplicatedStorage").ModuleLists.CarList)) do
                            if d.id == tonumber(b.Name) then
                                table.insert(tables,d.name..",")
                            end
                        end
                    end
                end
                warn(unpack(tables))
                print("------------------"..v.Name.." Currencies".."------------------")
                warn(v.variables.candy.Name..": "..v.variables.candy.Value,v.variables.rep.Name..": "..v.variables.rep.Value,v.Data.coconuts.Name..": "..v.Data.coconuts.Value)
                print("------------------"..v.Name.." Race Best Times".."------------------")
                for ok,p in pairs(v.Data.BestTimes:GetAttributes()) do
                    rawset(racetable,ok,p)
                end
                for lol,s in pairs(racetable) do
                    warn(lol,s)
                end
            end
        end
    end,
})

-- Reset Character
MiscTab:CreateButton({
    Name = "Reset Character",
    Callback = function()
        game.Players.LocalPlayer.Character:BreakJoints()
    end,
})

-- Remove AI Vehicles
MiscTab:CreateButton({
    Name = "Remove AI Vehicles",
    Callback = function()
        game:GetService("Workspace").Tracks:Destroy()
        Rayfield:Notify({
            Title = "AI Vehicles Removed",
            Content = "All AI vehicles deleted",
            Duration = 3,
            Image = 4483362458
        })
    end,
})

-- Remove Locked Area Barriers
MiscTab:CreateButton({
    Name = "Remove Locked Area Barriers",
    Callback = function()
        game:GetService("Workspace").AreaLocked:Destroy()
        Rayfield:Notify({
            Title = "Barriers Removed",
            Content = "Locked area barriers deleted",
            Duration = 3,
            Image = 4483362458
        })
    end,
})

-- Donut God
MiscTab:CreateToggle({
    Name = "Donut God",
    CurrentValue = false,
    Callback = function(Value)
        getfenv().donut = Value
        while getfenv().donut do
            task.wait()
            pcall(function()
                local part = game.Players.LocalPlayer.Character.Humanoid.SeatPart
                part.RotVelocity = Vector3.new(0,part.RotVelocity.Y+10,0)
            end)
        end
    end,
})

Rayfield:Notify({
    Title = "Taxi Boss Script Loaded",
    Content = "All features are ready to use!",
    Duration = 5,
    Image = 4483362458
})