if not game:IsLoaded() then game.Loaded:Wait() end

--hello_dark54
local name = "Telekinesis";
local vers = "V9";

local cloneref = cloneref or function(o) return o end
local httpservice = cloneref(game:GetService("HttpService"))
local uis = cloneref(game:GetService("UserInputService"));
local cservice = cloneref(game:GetService("CollectionService"))
local coregui = cloneref(game:GetService("CoreGui"))
local sgui = cloneref(game:GetService("StarterGui"))
local debris = cloneref(game:GetService("Debris"));
local players = cloneref(game:GetService("Players"))
local randomguid = string.lower(httpservice:GenerateGUID(false));
local plr = players.LocalPlayer;
local cam = workspace.CurrentCamera;
local mb = uis.TouchEnabled;
local w = task.wait;
local notifs = true;
local tkcollisions = true;
local destroying = false;
local ctrlpressed = false;
local mousedown = false;
local curtool = nil
local curpoint = nil
local curBP = nil
local _Ins, _CF_new, _VTR_new = Instance.new, CFrame.new, Vector3.new;

local ScriptFolder = _Ins("Folder", coregui)
ScriptFolder.Name = randomguid
local SelectionFolder = _Ins("Folder", ScriptFolder)
SelectionFolder.Name = "SelectionObjects"
local Sounds = Instance.new("Folder", ScriptFolder)
Sounds.Name = "Sounds"
local SwitchWav = Instance.new("Sound", Sounds)
SwitchWav.SoundId = "rbxassetid://12222170"
SwitchWav.Volume = 0.1
local ElectronicpingshortWav = Instance.new("Sound", Sounds)
ElectronicpingshortWav.SoundId = "rbxassetid://12221990"
ElectronicpingshortWav.Volume = 0.1
local Explode = Instance.new("Sound", Sounds)
Explode.SoundId = "rbxasset://Sounds/Launching rocket.wav"
Explode.Volume = 0.5
local CollideWav = Instance.new("Sound", Sounds)
CollideWav.SoundId = "rbxasset://Sounds/collide.wav"
CollideWav.Volume = 0.25
local ClickfastWav = Instance.new("Sound", Sounds)
ClickfastWav.SoundId = "rbxassetid://12221976"
ClickfastWav.Volume = 0.1
local BassWav = Instance.new("Sound", Sounds)
BassWav.SoundId = "rbxassetid://12221944"
BassWav.Volume = 0.05
local KerplunkWav = Instance.new("Sound", Sounds)
KerplunkWav.SoundId = "rbxassetid://12222054"
KerplunkWav.Volume = 0.1
local HitWav = Instance.new("Sound", Sounds)
HitWav.SoundId = "rbxasset://Sounds/hit.wav"
HitWav.Volume = 0.025
local OldMouseClick = Instance.new("Sound", Sounds)
OldMouseClick.SoundId = "http://roblox.com/asset/?id=10209834"
OldMouseClick.Volume = 0.025
local Button = Instance.new("Sound", Sounds)
Button.SoundId = "http://www.roblox.com/asset/?id=12221967"
Button.Volume = 0.15
local UnSelectable = Instance.new("Sound", Sounds)
UnSelectable.SoundId = "http://roblox.com/asset/?id=10209668"
UnSelectable.Volume = 0.15
local Bzzt = Instance.new("Sound", Sounds)
Bzzt.SoundId = "http://www.roblox.com/asset/?id=11998777"
Bzzt.Volume = 0.15
local Bzzt2 = Instance.new("Sound", Sounds)
Bzzt2.SoundId = "http://www.roblox.com/asset/?id=11998796"
Bzzt2.Volume = 0.15
local Paintball = Instance.new("Sound", Sounds)
Paintball.SoundId = "rbxasset://sounds//paintball.wav"
Paintball.Volume = 0.5
local point = _Ins("Part", SelectionFolder);
point.CanCollide = false;
point.Locked = true;
point.Anchored = true;
point.CanQuery = false;
point.Shape = "Ball";
point.BrickColor = BrickColor.White();
point.Size = _VTR_new(0, 0, 0);
point.Material = Enum.Material.Neon;
point.Transparency = 0.996;
point.Position = _VTR_new(math.huge, math.huge, math.huge)
local mesh = _Ins("SpecialMesh", point);
mesh.MeshId = "rbxassetid://1111494591"
mesh.Scale = _VTR_new(-0.025, -0.025, -0.025);
local highlight = _Ins("Highlight", point);
highlight.FillTransparency = 0.7;
highlight.FillColor = Color3.fromRGB(255, 255, 255);
highlight.Adornee = point;
local pointlight = _Ins("PointLight", point);
pointlight.Range = 7.5;
pointlight.Color = Color3.fromRGB(255, 255, 255);
local selectionbox = _Ins("SelectionBox", SelectionFolder);
selectionbox.LineThickness = 0.015;
selectionbox.SurfaceTransparency = 0.9;
selectionbox.Color3 = Color3.fromRGB(255, 255, 255);
selectionbox.SurfaceColor3 = Color3.fromRGB(255, 255, 255);
selectionbox.Adornee = nil;
local selectionhighlight = _Ins("Highlight", SelectionFolder);
selectionhighlight.FillTransparency = 0.7;
selectionhighlight.FillColor = Color3.fromRGB(255, 255, 255);
selectionhighlight.Adornee = nil;
local BP = _Ins("BodyPosition", SelectionFolder);
BP.MaxForce = _VTR_new(math.huge * math.huge, math.huge * math.huge, math.huge * math.huge);
BP.P = BP.P * 3;

local killscript = function()
	mousedown = false;
	ctrlpressed = false
	destroying = true
	if not (CollideWav ~= nil and Sounds ~= nil) then
		CollideWav.PlayOnRemove = true
	end
	if curBP ~= nil then
		curBP:Destroy()
	end
	if curtool ~= nil then
		curtool:Destroy()
	end
	if curpoint ~= nil then
		curpoint:Destroy()
	end
	if ScriptFolder ~= nil then
		ScriptFolder:Destroy()
	end
	if script ~= nil then
		script:Destroy()
	end
end

local WaitForChildWhichIsA = function(parent, className)
	local child = parent:FindFirstChildWhichIsA(className)
	while not child or not child:IsA(className) do
		child = parent.ChildAdded:Wait()
	end
	return child
end

local SendNotification = function(title, text, duration, button1, button2, icon, toggled)
	if not notifs and not toggled then return end
	local notificationData = {
		Title = title or "Notification",
		Text = text or "This is a notification.",
		Duration = duration or 5
	}

	if button1 then
		notificationData.Button1 = button1
	end
	if button2 then
		notificationData.Button2 = button2
	end
	if icon then
		notificationData.Icon = icon
	end

	sgui:SetCore("SendNotification", notificationData)
end

local IsNetworkOwner = function(part)
	return not part:IsGrounded() and part.AssemblyRootPart.ReceiveAge == 0
end

local createtool = function(ft)
	w();

	local primary = plr.Character and (plr.Character.PrimaryPart or plr.Character:FindFirstChild("HumanoidRootPart") or plr.Character:FindFirstChild("Head"))
	local mousedown = false;
	local ctrlpressed = false;
	local found = false;
	local dist = nil;
	local object = nil;

	if (primary == nil or ScriptFolder == nil) then
		if ft and ft == false then
			UnSelectable:Play() 
			SendNotification("Failed to create tool", nil, nil, "Close")
			return
		else
			return false
		end
	end
	BassWav:Play()

	local mas = _Ins("Model");
	local tool = _Ins("Tool");
	tool.RequiresHandle = false;
	tool.CanBeDropped = false;
	tool.Name = name;
	tool.ToolTip = name .. " " .. vers;
	tool.Parent = mas;
	cservice:AddTag(tool, randomguid)
	curtool = tool
	local destroy = function()
		if ScriptFolder == nil then return end
		mousedown = false;
		ctrlpressed = false
		selectionbox.Adornee = nil
		selectionhighlight.Adornee = nil
		if (curBP ~= nil) then
			curBP:Destroy();
		end
		if (curtool ~= nil) then
			curtool:Destroy();
		end
		if (curpoint ~= nil) then
			curpoint:Destroy();
		end
	end
	local onButton1Down = function(mouse)
		if (primary == nil) or (tool == nil) then UnSelectable:Play() return end
		local success, errormessage = pcall(function()
			if (mousedown == true) then
				UnSelectable:Play()
				mousedown = false
				return;
			end
			mousedown = true;
			coroutine.resume(coroutine.create(function()
				ClickfastWav:Play()
				local p = point:Clone();
				curpoint = p
				while mousedown == true do
					if (primary == nil or tool == nil) then UnSelectable:Play() break end
					p.Parent = tool;
					if (object == nil) then
						mouse.TargetFilter = nil
						if (mouse.Target == nil) then
							local lv = _CF_new(primary.Position, mouse.Hit.p);
							p.CFrame = _CF_new(primary.Position + (lv.lookVector * 1000));
						else
							p.CFrame = _CF_new(mouse.Hit.p);
						end
					else
						break;
					end
					w();
				end
				p:Destroy();
				if (object == nil) then
					OldMouseClick:Play()
				else
					KerplunkWav:Play()
					SendNotification("Part Selected", "Selected part: \'" .. object.Name .. "\'.", 1, "Close")
					if not IsNetworkOwner(object) then
						SendNotification("Selected Part Not Claimed", "You currently do not own the part: \'" .. object.Name .. "\'.", 0.75, "Close")
					end
				end
			end));
			while mousedown == true do
				if (primary == nil or tool == nil) then UnSelectable:Play() break end
				if (mouse.Target ~= nil) then
					local t = mouse.Target;
					if not (t:IsGrounded()) then
						object = t;
						selectionbox.Adornee = object;
						selectionhighlight.Adornee = object;
						dist = (object.Position - primary.Position).magnitude;
						break;
					end
				end
				w();
			end
			local lastnetworkstate
			local lastnotiftime
			if (object ~= nil) then
				lastnetworkstate = IsNetworkOwner(object)
				lastnotiftime = 0
			end
			while mousedown == true do
				if (primary == nil or tool == nil) then UnSelectable:Play() break end
				if (object == nil) then
					UnSelectable:Play()
					SendNotification("Part Unselected", "Part was destroyed.", nil, "Close")
					break;
				end
				if object and (lastnetworkstate ~= nil and lastnotiftime ~= nil) then
					local currentnetworkstate = IsNetworkOwner(object)
					local currenttime = tick()
					if currentnetworkstate ~= lastnetworkstate then
						if currenttime >= lastnotiftime + 0.25 then
							if not currentnetworkstate then
								SendNotification("Part Unclaimed", "Lost ownership of the part: \'" .. object.Name .. "\'.", 0.75, "Close")
							else
								SendNotification("Part Claimed", "Successfully claimed part: \'" .. object.Name .. "\'.", 0.75, "Close")
							end
							lastnotiftime = currenttime
						end
						lastnetworkstate = currentnetworkstate
					end
				end

				if tkcollisions == false then
					mouse.TargetFilter = game
				else
					mouse.TargetFilter = nil
				end
				if object == nil then return end
				local lv = _CF_new(primary.Position, mouse.Hit.p);
				local BPClone = curBP or BP:Clone()
				BPClone.Parent = object;
				BPClone.Position = primary.Position + (lv.lookVector * dist);
				curBP = BPClone
				w();
			end
			if curBP ~= nil then
				curBP:Destroy();
				HitWav:Play()
			end
			curBP = nil
			object = nil;
			selectionbox.Adornee = nil;
			selectionhighlight.Adornee = nil;
			mouse.TargetFilter = nil
		end)
	end;
	local onKeyDown = function(key, mouse)
		local key = key:lower();

		if (key == "n") then
			if not ctrlpressed then return end
			Button:Play()
			settings().Physics.AreOwnersShown = not settings().Physics.AreOwnersShown;
			if settings().Physics.AreOwnersShown == true then
				SendNotification("NetworkOwners", "NetworkOwners Enabled.", 1, "Close", nil, nil, true)
			else
				SendNotification("NetworkOwners", "NetworkOwners Disabled.", 1, "Close", nil, nil, true)
			end
		end

		if (key == "m") then
			if not ctrlpressed then return end
			Button:Play()
			notifs = not notifs
			if notifs == false then
				SendNotification("Notifications Disabled", "Disabled Notifications.", 1, "Close", nil, nil, true)
			else
				SendNotification("Notifications Enabled", "Enabled Notifications.", 1, "Close", nil, nil, true)
			end
		end

		if (key == "t") then
			local mouse = plr:GetMouse();
			mouse.TargetFilter = nil;
			local char = plr.Character or workspace:FindFirstChild(plr.Name)
			local hrp = char and char:FindFirstChild("HumanoidRootPart")
			if not char or not hrp then
				SendNotification("Failed to TP", "HumanoidRootPart is missing.", 2.5, "Close")
				return
			end
			hrp.Velocity = Vector3.zero
			hrp.RotVelocity = Vector3.zero
			hrp.CFrame = _CF_new(mouse.Hit.X, mouse.Hit.Y + 3, mouse.Hit.Z, select(4, hrp.CFrame:components()))
			SendNotification("Teleport", "Teleported to mouse position.", 1, "Close")
			ElectronicpingshortWav:Play()
		end
		if (key == "p") then
			if not ctrlpressed then return end
			if destroying == true or object ~= nil then return end
			SendNotification("Killed Script!", "DEATH.... guh", 5, "ok")
			killscript()
		end

		if (key == "k") then
			if not ctrlpressed then return end
			Button:Play()
			tkcollisions = not tkcollisions
			if tkcollisions == false then
				SendNotification("TK Collisions Disabled", "Disabled Telekinesis Collisions.", 1, "Close", nil, nil, true)
			else
				SendNotification("TK Collisions Enabled", "Enabled Telekinesis Collisions.", 1, "Close", nil, nil, true)
			end
		end

		if (primary == nil or tool == nil or object == nil) then return end

		if (key == "q") then
			if (dist >= 5) then
				SwitchWav:Play()
				dist = dist - 5;
			end
		end
		if (key == "e") then
			SwitchWav:Play()
			dist = dist + 5;
		end
		if (key == "z") then
			if (dist ~= 100) then
				SwitchWav:Play()
				dist = 100;
			end
		end
		if (key == "x") then
			if (dist ~= 15) then
				SwitchWav:Play()
				dist = 15;
			end
		end
		if (key == "u") then
			if (dist ~= 1) then
				if not IsNetworkOwner(object) then 
					UnSelectable:Play() 
					SendNotification("Unable to perform action", "You currently do not own the part: \'" .. object.Name .. "\'.", 0.75, "Close")
					return 
				end	
				ElectronicpingshortWav:Play()
				local BX = _Ins("BodyGyro");
				BX.MaxTorque = _VTR_new(math.huge * math.huge, 0, math.huge * math.huge);
				BX.CFrame = BX.CFrame * CFrame.Angles(0, math.rad(45), 0);
				BX.D = 0;
				BX.Parent = object;
			end
		end
		if (key == "l") then
			if (dist ~= 1) then
				if not IsNetworkOwner(object) then 
					UnSelectable:Play() 
					SendNotification("Unable to perform action", "You currently do not own the part: \'" .. object.Name .. "\'.", 0.75, "Close")
					return 
				end	
				ElectronicpingshortWav:Play()
				local BX = _Ins("BodyVelocity");
				BX.MaxForce = _VTR_new(0, math.huge * math.huge, 0);
				BX.Velocity = _VTR_new(0, math.random(1, 5), 0);
				BX.Parent = object;
				mousedown = false;
			end
		end
		if (key == "c") then
			if not IsNetworkOwner(object) then 
				UnSelectable:Play() 
				SendNotification("Unable to perform action", "You currently do not own the part: \'" .. object.Name .. "\'.", 0.75, "Close")
				return 
			end	
			for _, v in pairs(object:GetChildren()) do
				if (v.className == "BodyGyro") and cservice:HasTag(v, randomguid) then
					UnSelectable:Play()
					return;
				end
			end
			ElectronicpingshortWav:Play()
			spawn(function()
				local curobj = object
				local BG = _Ins("BodyGyro");
				BG.MaxTorque = _VTR_new(math.huge * math.huge, math.huge * math.huge, math.huge * math.huge);
				--BG.CFrame = _CF_new(object.CFrame.p);
				BG.P = BG.P * 30;
				BG.Parent = curobj;
				cservice:AddTag(BG, randomguid)
				repeat w()
					if (curobj == nil) or (mousedown == false) then break end 
					curobj.Velocity = Vector3.zero
					curobj.RotVelocity = Vector3.zero
				until curobj.Rotation == Vector3.new(0,0,0) or curobj == nil or mousedown == false
				BG:Destroy()
			end)
		end
		if (key == "f") then
			if not IsNetworkOwner(object) then 
				UnSelectable:Play() 
				SendNotification("Unable to perform action", "You currently do not own the part: \'" .. object.Name .. "\'.", 0.75, "Close")
				return 
			end	
			local orgobj = object;
			local mouse = plr:GetMouse();
			mouse.TargetFilter = game;
			local mousePos = mouse.Hit.Position;
			local direction = (mousePos - primary.Position).Unit;
			mousedown = false;
			orgobj.Velocity = Vector3.zero
			orgobj.RotVelocity = Vector3.zero
			if not ctrlpressed then
				w()
				orgobj.Velocity = direction * 750
				Paintball:Play()
			else
				w()
				orgobj.Velocity = direction * 5000
				Explode:Play()
			end
		end
		if (key == "j") then
			if not ctrlpressed then return end
			if not IsNetworkOwner(object) then 
				UnSelectable:Play() 
				SendNotification("Unable to perform action", "You currently do not own the part: \'" .. object.Name .. "\'.", 0.75, "Close")
				return 
			end	
			for _, v in pairs(object:GetChildren()) do
				if (v.className == "BodyVelocity") and cservice:HasTag(v, randomguid) then
					UnSelectable:Play()
					SendNotification("Unable to perform action", "Part is already being destroyed.", 0.5, "Close")
					return;
				end
			end
			local orgobj = object;
			local objname = object.Name;
			local startTime = tick()
			local BX = _Ins("BodyVelocity");
			BX.MaxForce = _VTR_new(0, math.huge * math.huge, 0);
			BX.Velocity = _VTR_new(0, -10000, 0);
			BX.Parent = orgobj;
			cservice:AddTag(BX, randomguid)
			mousedown = false;
			ElectronicpingshortWav:Play()
			while true do
				if orgobj == nil or orgobj.Parent == nil then
					CollideWav:Play()
					SendNotification("Part Destroyed", "Destroyed part: \'" .. objname .. "\'.", 2.5, "Close")
					break
				end
				if BX == nil or BX.Parent == nil then break end
				local currentTime = tick()
				local elapsedTime = currentTime - startTime
				orgobj.Velocity = _VTR_new(0, -10000, 0);
				orgobj.RotVelocity = _VTR_new(0, -10000, 0);
				if elapsedTime >= 10 and BX ~= nil and orgobj ~= nil then 
					BX:Destroy()
					orgobj.Velocity = Vector3.zero
					orgobj.RotVelocity = Vector3.zero
					UnSelectable:Play()
					SendNotification("Failed to destroy", "Failed to destroy part: \'" .. objname .. "\'.", 1, "Close")
					break 
				end
				w()
			end
		end
	end;
	local onEquipped = function(mouse)
		Bzzt2:Play()
		local keymouse = mouse;
		mouse.Button1Down:Connect(function()
			onButton1Down(mouse);
		end);
		mouse.KeyDown:Connect(function(key)
			onKeyDown(key, mouse);
		end);
		uis.InputBegan:Connect(function(input, gpe)
			if gpe then
				return
			end
			if input.UserInputType == Enum.UserInputType.Keyboard then
				local keyCode = input.KeyCode
				if keyCode == Enum.KeyCode.LeftControl or keyCode == Enum.KeyCode.RightControl then
					ctrlpressed = true
				end
			end
		end)
		uis.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.Keyboard then
				local keyCode = input.KeyCode
				if keyCode == Enum.KeyCode.LeftControl or keyCode == Enum.KeyCode.RightControl then
					ctrlpressed = false
				end
			end
		end)
		if mb then
			uis.TouchLongPress:Connect(function()
				onKeyDown("f", mouse);
			end);
			uis.TouchEnded:Connect(function()
				mousedown = false;
			end);
		else
			mouse.Button1Up:Connect(function()
				mousedown = false;
			end);
		end
	end;
	tool.Equipped:Connect(onEquipped);
	tool.Unequipped:Connect(function()
		Bzzt:Play()
		mousedown = false;
	end);
	for i, v in pairs(mas:GetChildren()) do
		v.Parent = plr.Backpack;
	end
	mas:Destroy();
	if ft and ft == true then
		return true
	end
	spawn(function()
		while w() do
			if destroying then break end
			if (primary == nil) then
				local check = plr.Character and (plr.Character.PrimaryPart or plr.Character:FindFirstChild("HumanoidRootPart") or plr.Character:FindFirstChild("Head"))
				if check then
					primary = check
				else
					SendNotification("Tool Destroyed", "PrimaryPart is missing.", nil, "Close")
					destroy()
					break
				end
			elseif (tool == nil) then
				SendNotification("Tool Destroyed", "Tool was destroyed.", 1, "Close")
				destroy()
				break
			elseif (plr == nil) then
				killscript()
				break
			elseif (ScriptFolder == nil) then
				killscript()
			end
		end
	end)
end;
pcall(function()
	local tool = createtool(true)
	if tool == true then
		--Credits&PartClaim
		SendNotification(name .. " " .. vers, "Made by hello_dark54.", nil, "Close")
		print(name .. " " .. vers .. " loaded. Made by hello_dark54.");
		if gethiddenproperty and sethiddenproperty and not PARTCLAIM_LOADED then
			loadstring(game:HttpGet("https://raw.githubusercontent.com/randomguye/cool-scripts/refs/heads/main/scripts/PartClaim.lua"))();
			pcall(function() getgenv().PARTCLAIM_LOADED = true end)
		end
	else
		SendNotification("Failed to launch", "Failed to initiate script.", nil, "Close")
		warn("Failed to initiate script.")
		killscript()
		return
	end

	while w(.1) do
		if not plr then break end
		if destroying then break end
		local backpack = plr:FindFirstChildOfClass("Backpack")
		local primary = plr.Character and (plr.Character.PrimaryPart or plr.Character:FindFirstChild("HumanoidRootPart") or plr.Character:FindFirstChild("Head"))
		local canReceiveTool = primary and backpack
		local itemCount = 0
		if ScriptFolder == nil then
			SendNotification("Script Folder Destroyed!", "Destroying script..", 1, "Close")
			killscript()
			break
		end
		if backpack then
			for _, item in backpack:GetChildren() do
				if cservice:HasTag(item, randomguid) then
					itemCount = itemCount + 1
				end
			end
		end
		if plr.Character then
			for _, item in plr.Character:GetChildren() do
				if item:IsA("Tool") and cservice:HasTag(item, randomguid) then
					itemCount = itemCount + 1
				end
			end
		end
		if itemCount == 0 then
			if canReceiveTool then
				createtool()
			end
		elseif itemCount > 1 then
			if backpack then
				for _, item in backpack:GetChildren() do
					if cservice:HasTag(item, randomguid) then
						item:Destroy()
					end
				end
			end
			if plr.Character then
				for _, item in plr.Character:GetChildren() do
					if item:IsA("Tool") and cservice:HasTag(item, randomguid) then
						item:Destroy()
					end
				end
			end
			if canReceiveTool then
				createtool()
			end
		end
	end
end)
