local firstrun = false
if not getgenv().AutoArrestRan then
    firstrun = true
end
getgenv().AutoArrestRan = true
local vu1 = loadstring([=[return function(input, andlist, orlist)
    input = input or false
    andlist = andlist or {}
    orlist = orlist or {}
    local output = {}
    for _,v in pairs(getgc(input)) do
        if input and type(v) == "table" then
            local isLegit = true
            for _,andItem in pairs(andlist) do
                if rawget(v, andItem) == nil then
                    isLegit = false
                end
            end
            if isLegit then
                if #orlist == 0 then
                    table.insert(output, v)
                else
                    for _,orItem in pairs(orlist) do
                        if rawget(v, orItem) ~= nil then
                            table.insert(output, v)
                            break
                        end
                    end
                end
            end
        elseif not input then
            table.insert(output, v)
        end
    end
    return output
end
]=])()
function VelocityTeleport(p2, p3, p4, p5)
    local v6 = Vector3.new(p2, p3, p4)
    local v7 = Vector3.new(math.huge, math.huge, math.huge)
    local v8 = Instance.new("BodyVelocity")
    v8.MaxForce = v7
    v8.Velocity = Vector3.new(0, 0, 0)
    v8.Parent = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
    while wait() do
        local v9 = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position
        local v10 = (v6 - v9).unit
        if (v6 - v9).magnitude < p5 / 30 then
            v8:Destroy()
            for _ = 1, 10 do
                game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(v6)
                game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
            end
            break
        end
        v8.Velocity = v10 * p5
    end
end
function aboveplayer(p11)
    if not (game:GetService("Players"):FindFirstChild(p11) and game:GetService("Players")[p11].Character and game:GetService("Players")[p11].Character:FindFirstChild("HumanoidRootPart")) then
        return true
    end
    local v12 = RaycastParams.new()
    v12.FilterType = Enum.RaycastFilterType.Blacklist
    local v13 = {
        workspace.Terrain,
        workspace.Prison.Items.ProhibitedAreas,
        workspace.Ignore,
        workspace.Vehicles
    }
    local v14, v15, v16 = pairs(game:GetService("Players"):GetPlayers())
    while true do
        local v17
        v16, v17 = v14(v15, v16)
        if v16 == nil then
            break
        end
        table.insert(v13, v17.Character)
    end
    v12.FilterDescendantsInstances = v13
    return workspace:Raycast(game:GetService("Players")[p11].Character.HumanoidRootPart.Position, Vector3.new(0, 800, 0), v12)
end
function obstaclesbetween(_)
    return false
end
function isincrimbase(p18)
    if not (game:GetService("Players"):FindFirstChild(p18) and game:GetService("Players")[p18].Character and game:GetService("Players")[p18].Character:FindFirstChild("HumanoidRootPart")) then
        return true
    end
    local v19 = RaycastParams.new()
    v19.FilterType = Enum.RaycastFilterType.Blacklist
    local v20 = {
        workspace.Terrain,
        workspace.Prison.Items.ProhibitedAreas,
        workspace.Ignore,
        workspace.Vehicles
    }
    local v21, v22, v23 = pairs(game:GetService("Players"):GetPlayers())
    while true do
        local v24
        v23, v24 = v21(v22, v23)
        if v23 == nil then
            break
        end
        table.insert(v20, v24.Character)
    end
    v19.FilterDescendantsInstances = v20
    local v25 = workspace:Raycast(game:GetService("Players")[p18].Character.HumanoidRootPart.Position, Vector3.new(0, 800, 0), v19)
    if v25 then
        local v26 = v25.Instance
        local v27, v28, v29 = pairs(workspace.CriminalBase:GetDescendants())
        while true do
            local v30
            v29, v30 = v27(v28, v29)
            if v29 == nil then
                break
            end
            if v30.Name == v26.Name then
                return true
            end
        end
    end
    return false
end
function CheckArrestable(p31)
    if not (p31.Team and p31.Character) then
        return false
    end
    local v32
    if p31.Team.Name == "Criminals" or p31.Team.Name == "Villains" then
        v32 = true
    elseif p31.Team.Name ~= "Prisoners" then
        v32 = false
    else
        v32 = p31.Character:FindFirstChild("Arrestable")
    end
    return v32
end
local vu33 = {}
function findproxID()
    local v34, v35, v36 = pairs(vu1(true, {
        "Name",
        "OriginObject",
        "ID"
    }))
    while true do
        local v37
        v36, v37 = v34(v35, v36)
        if v36 == nil then
            break
        end
        if (rawget(v37, "Name") == "player_interaction_arrest" or rawget(v37, "Name") == "player_interaction_eject") and rawget(v37, "OriginObject").Parent then
            local v38, v39, v40 = pairs(vu33)
            local v41 = false
            while true do
                local v42
                v40, v42 = v38(v39, v40)
                if v40 == nil then
                    break
                end
                if v42[1] == rawget(v37, "OriginObject").Parent.Name .. rawget(v37, "Name") and v42[2] == tostring(rawget(v37, "ID")) then
                    v41 = true
                end
            end
            if not v41 then
                table.insert(vu33, {
                    rawget(v37, "OriginObject").Parent.Name .. rawget(v37, "Name"),
                    tostring(rawget(v37, "ID"))
                })
            end
        end
    end
end
local v43 = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
local vu44 = vu33
local vu45 = {}
for _ = 1, 2 do
    findproxID()
    local v46, v47, v48 = ipairs(game:GetService("Players"):GetPlayers())
    while true do
        local vu49
        v48, vu49 = v46(v47, v48)
        if v48 == nil then
            break
        end
        if aboveplayer(game:GetService("Players").LocalPlayer.Name) then
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Ralyes Hub",
                Text = "Roof above detected."
            })
            break
        end
        local v50, v51, v52 = pairs(vu44)
        local v53 = false
        while true do
            local v54
            v52, v54 = v50(v51, v52)
            if v52 == nil then
                break
            end
            if v54[1] == vu49.Name .. "player_interaction_arrest" then
                v53 = true
            end
        end
        if v53 and (table.find(vu45, vu49) == nil and (vu49 ~= game:GetService("Players").LocalPlayer and (CheckArrestable(vu49) and not (aboveplayer(vu49.Name) or isincrimbase(vu49.Name))))) then
            pcall(function()
                findproxID()
                print("[ProBaconHub] | Now arresting: ", vu49.Name)
                table.insert(vu45, vu49)
                if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Handcuffs") then
                    game:GetService("Players").LocalPlayer.Character.Humanoid:EquipTool(game:GetService("Players").LocalPlayer.Backpack.Handcuffs)
                end
                VelocityTeleport(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame.X, 800, game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame.Z, 750)
                game:GetService("RunService").Heartbeat:Wait()
                VelocityTeleport(vu49.Character.HumanoidRootPart.CFrame.X, 800, vu49.Character.HumanoidRootPart.CFrame.Z, 750)
                VelocityTeleport(vu49.Character.HumanoidRootPart.CFrame.X, 800, vu49.Character.HumanoidRootPart.CFrame.Z, 750)
                game:GetService("RunService").Heartbeat:Wait()
                if not (aboveplayer(vu49.Name) or isincrimbase(vu49.Name)) then
                    while not obstaclesbetween(vu49.Name) and (vu49.Character.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).magnitude >= 5 do
                        VelocityTeleport(vu49.Character.HumanoidRootPart.CFrame.X, vu49.Character.HumanoidRootPart.CFrame.Y, vu49.Character.HumanoidRootPart.CFrame.Z, 600)
                        game:GetService("RunService").Heartbeat:Wait()
                    end
                    if not obstaclesbetween(vu49.Name) then
                        local v55 = os.clock()
                        local v56, v57, v58 = pairs(vu44)
                        local v59 = nil
                        while true do
                            local v60
                            v58, v60 = v56(v57, v58)
                            if v58 == nil then
                                break
                            end
                            if v60[1] == vu49.Name .. "player_interaction_eject" then
                                v59 = v60[2]
                            end
                        end
                        while v59 ~= nil and (vu49.Character.Humanoid.SeatPart ~= nil and os.clock() - v55 <= 7) do
                            if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Handcuffs") then
                                game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Handcuffs").Parent = game:GetService("Players").LocalPlayer.Character
                            end
                            game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = vu49.Character.HumanoidRootPart.CFrame
                            game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Velocity = vu49.Character.HumanoidRootPart.Velocity
                            game:GetService("ReplicatedStorage"):WaitForChild("RedEvent"):FireServer({
                                ["\0"] = {
                                    "InteractBegin",
                                    tostring(v59)
                                }
                            }, {})
                            task.wait()
                            game:GetService("ReplicatedStorage"):WaitForChild("RedEvent"):FireServer({
                                ["\0"] = {
                                    "InteractRun",
                                    tostring(v59)
                                }
                            }, {})
                            task.wait(0.01)
                        end
                        local v61, v62, v63 = pairs(vu44)
                        local v64 = nil
                        while true do
                            local v65
                            v63, v65 = v61(v62, v63)
                            if v63 == nil then
                                break
                            end
                            if v65[1] == vu49.Name .. "player_interaction_arrest" then
                                v64 = v65[2]
                            end
                        end
                        for _ = 1, 15 do
                            if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Handcuffs") then
                                game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Handcuffs").Parent = game:GetService("Players").LocalPlayer.Character
                            end
                            game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = vu49.Character.HumanoidRootPart.CFrame
                            game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Velocity = vu49.Character.HumanoidRootPart.Velocity
                            if v64 ~= nil then
                                game:GetService("ReplicatedStorage"):WaitForChild("RedEvent"):FireServer({
                                    ["\0"] = {
                                        "InteractBegin",
                                        tostring(v64)
                                    }
                                }, {})
                                game:GetService("ReplicatedStorage"):WaitForChild("RedEvent"):FireServer({
                                    ["\0"] = {
                                        "InteractRun",
                                        tostring(v64)
                                    }
                                }, {})
                            end
                            task.wait(0.0001)
                        end
                    end
                end
            end)
        end
    end
end
if not aboveplayer(game:GetService("Players").LocalPlayer.Name) then
    VelocityTeleport(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame.X, 800, game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame.Z, 750)
    game:GetService("RunService").Heartbeat:Wait()
    VelocityTeleport(v43.X, 800, v43.Z, 750)
    game:GetService("RunService").Heartbeat:Wait()
    VelocityTeleport(v43.X, v43.Y, v43.Z, 750)
end
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Ralyes Hub",
    Text = "Auto arrest ended.."
})
local PlaceID = game.PlaceId
local AllIDs = {}
local foundAnything = ""
local actualHour = os.date("!*t").hour
local Deleted = false
local File = pcall(function()
    AllIDs = game:GetService('HttpService'):JSONDecode(readfile("NotSameServers.json"))
end)
if not File then
    table.insert(AllIDs, actualHour)
    writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
end
local function TPReturner()
    local Site
    if foundAnything == "" then
        Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
    else
        Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
    end
    local ID = ""
    if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
        foundAnything = Site.nextPageCursor
    end
    local num = 0
    for i, v in pairs(Site.data) do
        local Possible = true
        ID = tostring(v.id)
        if tonumber(v.maxPlayers) > tonumber(v.playing) then
            for _, Existing in pairs(AllIDs) do
                if num ~= 0 then
                    if ID == tostring(Existing) then
                        Possible = false
                    end
                else
                    if tonumber(actualHour) ~= tonumber(Existing) then
                        local delFile = pcall(function()
                            delfile("NotSameServers.json")
                            AllIDs = {}
                            table.insert(AllIDs, actualHour)
                        end)
                    end
                end
                num = num + 1
            end
            if Possible == true then
                table.insert(AllIDs, ID)
                task.wait()
                pcall(function()
                    writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
                    task.wait()
                    game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
                end)
                task.wait(4)
            end
        end
    end
end
function Teleport()
    while task.wait() do
        pcall(function()
            TPReturner()
            if foundAnything ~= "" then
                TPReturner()
            end
        end)
    end
end
if firstrun then
    pcall((queue_on_teleport or queueonteleport or queueteleport), "getgenv().AutoArrestRan = true; loadstring(game:HttpGet(\"https://raw.githubusercontent.com/rex-rbx/MadCity2/refs/heads/main/AutoArrest.lua\"))()")
end
Teleport()
