--hello_dark54
local name = "Telekinesis";
local vers = "V10";

--Credits
print(name .. " " .. vers .. " loaded. Made by hello_dark54.");

--Part Claim
if gethiddenproperty and sethiddenproperty then
	loadstring(game:HttpGet("https://raw.githubusercontent.com/randomguye/cool-scripts/refs/heads/main/scripts/PartClaim.lua"))();
end





















































































































task.wait()

local randomguid = string.lower(game:GetService("HttpService"):GenerateGUID(false));
local plr = game:GetService("Players").LocalPlayer;
local uis = game:GetService("UserInputService");
local cservice = game:GetService("CollectionService")
local sgui = game:GetService("StarterGui")
local debris = game:GetService("Debris");
local cam = workspace.CurrentCamera;
local mb = uis.TouchEnabled;
local w = task.wait;
local success = false
local _Ins, _CF_new, _VTR_new = Instance.new, CFrame.new, Vector3.new;

local ScriptFolder = _Ins("Folder", game)
ScriptFolder.Name = "TelekinesisMain"
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

local WaitForChildWhichIsA = function(parent, className)
	local child = parent:FindFirstChildWhichIsA(className)
	while not child or not child:IsA(className) do
		child = parent.ChildAdded:Wait()
	end
	return child
end

local SendNotification = function(title, text, duration, button1, button2, icon)
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
	local char = plr.Character;
	local human = WaitForChildWhichIsA(char, "Humanoid");
	local primary = char.PrimaryPart or char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Head");
	local mousedown = false;
	local ctrlpressed = false;
	local found = false;
	local dist = nil;
	local curBP = nil;
	local object = nil;

	if (primary == nil) or (human == nil) or (human.Health < 1) or (char == nil) then
		if ft == false then
			UnSelectable:Play() 
			SendNotification("Failed to create tool", nil, nil, "Close")
			return
		else
			success = false
			return
		end
	end
	BassWav:Play()

	local mas = _Ins("Model", plr);
	local tool = _Ins("Tool");
	tool.RequiresHandle = false;
	tool.CanBeDropped = false;
	tool.Name = name;
	tool.ToolTip = name .. " " .. vers;
	tool.Parent = mas;
	cservice:AddTag(tool, randomguid)
	local destroy = function()
		mousedown = false;
		if (curBP ~= nil) then
			curBP:Destroy();
		end
		point.Parent = SelectionFolder
		selectionbox.Adornee = nil
		selectionhighlight.Adornee = nil
		tool:Destroy();
	end
	local onButton1Down = function(mouse)
		if (primary == nil) or (human == nil) or (human.Health < 1) or (char == nil) or (tool == nil) then UnSelectable:Play() return end
		if (mousedown == true) then
			UnSelectable:Play()
			mousedown = false
			return;
		end
		mousedown = true;
		coroutine.resume(coroutine.create(function()
			ClickfastWav:Play()
			local p = point:Clone();
			p.Parent = cam;
			while mousedown == true do
				if (primary == nil) or (human == nil) or (human.Health < 1) or (char == nil) or (tool == nil) then UnSelectable:Play() break end
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
			if object == nil then
				OldMouseClick:Play()
			else
				KerplunkWav:Play()
			end
		end));
		while mousedown == true do
			if (primary == nil) or (human == nil) or (human.Health < 1) or (char == nil) or (tool == nil) then UnSelectable:Play() break end
			if (mouse.Target ~= nil) then
				local t = mouse.Target;
				if (t.Anchored == false) then
					object = t;
					selectionbox.Adornee = object;
					selectionhighlight.Adornee = object;
					dist = (object.Position - primary.Position).magnitude;
					break;
				end
			end
			w();
		end
		while mousedown == true do
			if (primary == nil) or (human == nil) or (human.Health < 1) or (char == nil) or (tool == nil) then UnSelectable:Play() break end
			if ((object.Parent == nil) or (object == nil)) then
				UnSelectable:Play()
				SendNotification("Unselected", "Part was destroyed.", nil, "Close")
				break;
			end
			mouse.TargetFilter = game
			pcall(function()
				if object == nil then return end
				local lv = _CF_new(primary.Position, mouse.Hit.p);
				local BPClone = curBP or BP:Clone()
				BPClone.Parent = object;
				BPClone.Position = primary.Position + (lv.lookVector * dist);
				curBP = BPClone
			end);
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
	end;
	local onKeyDown = function(key, mouse)
		local key = key:lower();
		local yesh = false;

		if (key == "r") then
			if not ctrlpressed then return end
			Button:Play()
			settings().Physics.AreOwnersShown = not settings().Physics.AreOwnersShown;
		end

		if (primary == nil) or (human == nil) or (human.Health < 1) or (char == nil) or (tool == nil) or (object == nil) then return end

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
		if (key == "y") then
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
				if not IsNetworkOwner(object) then UnSelectable:Play() return end
				ElectronicpingshortWav:Play()
				local BX = _Ins("BodyGyro");
				BX.MaxTorque = _VTR_new(math.huge * math.huge, 0, math.huge * math.huge);
				BX.CFrame = BX.CFrame * CFrame.Angles(0, math.rad(45), 0);
				BX.D = 0;
				BX.Parent = object;
			end
		end
		if (key == "p") then
			if (dist ~= 1) then
				if not IsNetworkOwner(object) then UnSelectable:Play() return end
				ElectronicpingshortWav:Play()
				local BX = _Ins("BodyVelocity");
				BX.MaxForce = _VTR_new(0, math.huge * math.huge, 0);
				BX.Velocity = _VTR_new(0, math.random(1, 5), 0);
				BX.Parent = object;
				mousedown = false;
			end
		end
		if (key == "l") then
			if not IsNetworkOwner(object) then UnSelectable:Play() return end
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
				BG.P = BG.P * 100;
				BG.Parent = curobj;
				cservice:AddTag(BG, randomguid)
				repeat w()
					if (curobj == nil) or (mousedown == false) then break end 
					curobj.Velocity = _VTR_new(0, 0, 0)
					curobj.RotVelocity = _VTR_new(0, 0, 0)
				until curobj.Rotation == Vector3.new(0,0,0) or curobj == nil or mousedown == false
				BG:Destroy()
			end)
		end
		if (key == "f") then
			if not IsNetworkOwner(object) then UnSelectable:Play() return end
			local orgobj = object;
			local mouse = plr:GetMouse();
			mouse.TargetFilter = game;
			local mousePos = mouse.Hit.Position;
			local direction = (mousePos - primary.Position).Unit;
			mousedown = false;
			if not ctrlpressed then
				w()
				orgobj.Velocity = direction * 1000
				Paintball:Play()
			else
				w()
				orgobj.Velocity = direction * 5000
				Explode:Play()
			end
		end
		if (key == "j") then
			if not IsNetworkOwner(object) then UnSelectable:Play() return end
			for _, v in pairs(object:GetChildren()) do
				if (v.className == "BodyVelocity") and cservice:HasTag(v, randomguid) then
					UnSelectable:Play()
					return;
				end
			end
			local orgobj = object;
			local startTime = tick()
			local BX = _Ins("BodyVelocity");
			BX.MaxForce = _VTR_new(0, math.huge * math.huge, 0);
			BX.Velocity = _VTR_new(0, -10000, 0);
			BX.Parent = orgobj;
			cservice:AddTag(BX, randomguid)
			mousedown = false;
			ElectronicpingshortWav:Play()
			while true do
				if orgobj == nil or orgobj.Parent == nil then CollideWav:Play() break end
				if BX == nil or BX.Parent == nil then break end
				local currentTime = tick()
				local elapsedTime = currentTime - startTime
				if elapsedTime >= 15 and BX ~= nil and orgobj ~= nil then 
					BX:Destroy()
					UnSelectable:Play()
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
	if human and not (primary == nil or human == nil or human.Health < 1 or char == nil or tool == nil) then
		human.Died:Connect(function()
			destroy();
		end);
	else
		destroy();
	end
	for i, v in pairs(mas:GetChildren()) do
		v.Parent = plr.Backpack;
	end
	mas:Destroy();
	if ft == true then
		success = true
	end
end;
pcall(function()
	createtool(true)
	if success == true then
		SendNotification(name .. " " .. vers, "Made by hello_dark54.", nil, "Close")
	else
		SendNotification("Failed to launch", "Failed to initiate script.", nil, "Close")
		ScriptFolder:Destroy()
		script:Destroy()
		return
	end

	while w() do
		if not plr then
			break
		end
		local backpack = plr:FindFirstChildOfClass("Backpack")
		local character = plr.Character
		local primary = character.PrimaryPart or character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Head")
		local humanoid = character and WaitForChildWhichIsA(character, "Humanoid")
		local canReceiveTool = character and primary and humanoid and humanoid.Health > 0 and backpack
		local itemCount = 0
		if backpack then
			for _, item in backpack:GetChildren() do
				if cservice:HasTag(item, randomguid) then
					itemCount = itemCount + 1
				end
			end
		end
		if character then
			for _, item in character:GetChildren() do
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
			if character then
				for _, item in character:GetChildren() do
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

