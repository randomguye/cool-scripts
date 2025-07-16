if not game:IsLoaded() then game.Loaded:Wait() end

--hello_dark54
local name = "Telekinesis";
local vers = "V12";

local cloneref = cloneref or function(o) return o end
local httpservice = cloneref(game:GetService("HttpService"))
local uis = cloneref(game:GetService("UserInputService"));
local inservice = cloneref(game:GetService("InsertService"))
local cservice = cloneref(game:GetService("CollectionService"))
local coregui = cloneref(game:GetService("CoreGui"))
local sgui = cloneref(game:GetService("StarterGui"))
local debris = cloneref(game:GetService("Debris"));
local players = cloneref(game:GetService("Players"))
local randomguid = string.lower(httpservice:GenerateGUID(false));
local ReGui = loadstring(game:HttpGet('https://raw.githubusercontent.com/depthso/Dear-ReGui/refs/heads/main/ReGui.lua'))()
local PrefabsId = "rbxassetid://" .. ReGui.PrefabsId
local plr = players.LocalPlayer;
local cam = workspace.CurrentCamera;
local mb = uis.TouchEnabled;
local w = task.wait;
local notifs = true;
local applyatcenterofmass = true;
local tkcollisions = true;
local BPresponsiveness
local destroying = false;
local ctrlpressed = false;
local mousedown = false;
local curtool = nil
local curpoint = nil
local cura = nil
local ignore = {plr.Character}
local destroypart = {}
local _Ins, _CF_new, _VTR_new = Instance.new, CFrame.new, Vector3.new;
ReGui:Init({
	Prefabs = inservice:LoadLocalAsset(PrefabsId)
})

local ScriptFolder = _Ins("Folder", coregui)
ScriptFolder.Name = randomguid
local WorkspaceFolder = _Ins("Folder", workspace)
WorkspaceFolder.Name = randomguid
local ForcesFolder = _Ins("Folder", WorkspaceFolder)
ForcesFolder.Name = "Forces"
local Temp = _Ins("Folder", WorkspaceFolder)
Temp.Name = "Temporary"
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
mesh.Scale = _VTR_new(-0.0125, -0.0125, -0.0125);
local highlight = _Ins("Highlight", point);
highlight.FillTransparency = 0.7;
highlight.FillColor = Color3.fromRGB(255, 255, 255);
highlight.Adornee = point;
local pointlight = _Ins("PointLight", point);
pointlight.Range = 2.5;
pointlight.Brightness = 0.25
pointlight.Color = Color3.fromRGB(255, 255, 255);
local attachment0 = Instance.new("Attachment", point)
local attachment1 = Instance.new("Attachment", point)
local trail = Instance.new("Trail", point)
trail.Color = ColorSequence.new(Color3.new(1, 1, 1))
trail.Transparency = NumberSequence.new{
	NumberSequenceKeypoint.new(0, 1),
	NumberSequenceKeypoint.new(0.35, 0.25),
	NumberSequenceKeypoint.new(1, 1)
}
trail.LightEmission = 1
trail.Lifetime = 0.25
trail.FaceCamera = true
trail.Attachment0 = attachment0
trail.Attachment1 = attachment1
attachment0.Position = Vector3.new(-0.025, 0, 0)
attachment1.Position = Vector3.new(0.025, 0, 0)
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
local BP = _Ins("AlignPosition", ForcesFolder);
BP.Mode = Enum.PositionAlignmentMode.OneAttachment
BP.MaxForce = "inf"--_VTR_new(math.huge * math.huge, math.huge * math.huge, math.huge * math.huge); 
BP.Responsiveness = BP.Responsiveness * 3;
BP.ApplyAtCenterOfMass = true
local SettingsWindow = ReGui:Window({
	Title = "Telekinesis | Anti",
	Size = UDim2.fromOffset(300, 600),
	NoClose = true
})

local rayResult = function(x, y)
  	local unitRay = cam:ViewportPointToRay(x, y)
	local params = RaycastParams.new()
	params.FilterDescendantsInstances = ignore
	params.FilterType = Enum.RaycastFilterType.Exclude
  	return workspace:Raycast(unitRay.Origin, unitRay.Direction * 1000, params)
end

local killscript = function()
	mousedown = false;
	ctrlpressed = false
	destroying = true
	if not (CollideWav == nil and Sounds == nil) then
		CollideWav.PlayOnRemove = true
	end
	if cura ~= nil then
		cura:Destroy()
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
	if (part == nil or part.AssemblyRootPart == nil) then return false end
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
	tool.TextureId = "rbxassetid://87584126977170"
	tool.Parent = mas;
	cservice:AddTag(tool, randomguid)
	curtool = tool
	local destroy = function()
		if ScriptFolder == nil then return end
		mousedown = false;
		ctrlpressed = false
		selectionbox.Adornee = nil
		selectionhighlight.Adornee = nil
		if (cura ~= nil) then
			cura:Destroy();
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
			table.clear(ignore)
			table.insert(ignore, plr.Character)
			coroutine.resume(coroutine.create(function()
				ClickfastWav:Play()
				local p = point:Clone();
				curpoint = p
				while mousedown == true do
					if (primary == nil or tool == nil) then UnSelectable:Play() break end
					p.Parent = tool;
					local mousePos = uis:GetMouseLocation()
					local result = rayResult(mousePos.X, mousePos.Y)
					if (object == nil) then
						if result == nil then
							local unitray = cam:ViewportPointToRay(mousePos.X, mousePos.Y)
							p.CFrame = _CF_new(unitray.Origin + (unitray.Direction * 1000));
						else
							p.CFrame = _CF_new(result.Position);
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
				end
			end));
			while mousedown == true do
				if (primary == nil or tool == nil) then UnSelectable:Play() break end
				local mousePos = uis:GetMouseLocation()
				local result = rayResult(mousePos.X, mousePos.Y)
				if (result and result.Instance ~= nil) then
					local t = result.Instance;
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
				SendNotification("Part Selected", "Selected part: \'" .. object.Name .. "\'.", 1, "Close")
				if object and not IsNetworkOwner(object) then
					SendNotification("Selected Part Not Claimed", "You currently do not own the part: \'" .. object.Name .. "\'.", 0.65, "Close")
				end
			end
			while mousedown == true do
				if (primary == nil or tool == nil) then UnSelectable:Play() break end
				if (object == nil) then
					UnSelectable:Play()
					SendNotification("Part Unselected", "Part was destroyed.", nil, "Close")
					break;
				end
				if object ~= nil and (lastnetworkstate ~= nil and lastnotiftime ~= nil) then
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
				if object == nil then return end
				local mousePos = uis:GetMouseLocation()
				local result = rayResult(mousePos.X, mousePos.Y)
				local objconnections = object:GetConnectedParts(true)
				for i,v in pairs(objconnections) do
					if v:IsA("BasePart") and v ~= nil then
						table.insert(ignore, v)
					end
				end
				table.insert(ignore, object)
				local attachment = cura or _Ins("Attachment", object)
				BP.Attachment0 = attachment
				if result and tkcollisions == true then
					local lv = _CF_new(primary.Position, result.Position);
					BP.Position = primary.Position + (lv.lookVector * dist);
					--local BPClone = curBP or BP:Clone()
					--BPClone.Parent = object;
					--BPClone.Position = primary.Position + (lv.lookVector * dist);
				else
					local lv = cam:ViewportPointToRay(mousePos.X, mousePos.Y)
					BP.Position = primary.Position + (lv.Direction * dist)
				end
				cura = attachment
				w();
			end
			if cura ~= nil then
				cura:Destroy();
				HitWav:Play()
			end
			cura = nil
			object = nil;
			BP.Attachment0 = nil
			selectionbox.Adornee = nil;
			selectionhighlight.Adornee = nil;
			table.clear(ignore)
			table.insert(ignore, plr.Character)
		end)
		if errormessage then
			warn(errormessage)
		end
	end;
	local onKeyDown = function(key, mouse)
		local key = key:lower();

		if (key == "t") then
			local mousePos = uis:GetMouseLocation()
			local result = rayResult(mousePos.X, mousePos.Y)
			local char = plr.Character or workspace:FindFirstChild(plr.Name)
			local hrp = char and char:FindFirstChild("HumanoidRootPart")
			if not char or not hrp then
				SendNotification("Failed to TP", "HumanoidRootPart is missing.", 2.5, "Close")
				return
			end
			hrp.AssemblyLinearVelocity = Vector3.zero
			hrp.AssemblyAngularVelocity = Vector3.zero
			if result then
				hrp.CFrame = _CF_new(result.Position.X, result.Position.Y + 3, result.Position.Z, select(4, hrp.CFrame:components()))
			else
				local unitray = cam:ViewportPointToRay(mousePos.X, mousePos.Y)
				hrp.CFrame = _CF_new(hrp.Position + (unitray.Direction * 1000))
			end
			SendNotification("Teleport", "Teleported to mouse position.", 0.25, "Close")
			ElectronicpingshortWav:Play()
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
		if (key == "r") then
			local setdist = 100
			SwitchWav:Play()
			if not ctrlpressed then
				if (dist ~= setdist) then
					dist = setdist
				end
			else
				dist = dist + setdist;
			end
		end
		if (key == "x") then
			local setdist = 15
			SwitchWav:Play()
			if not ctrlpressed then
				if (dist ~= setdist) then
					dist = setdist
				end
			else
				dist = dist + setdist;
			end
		end
		if (key == "") then
			if (dist ~= 1) then
				if not IsNetworkOwner(object) then 
					UnSelectable:Play() 
					SendNotification("Unable to perform action", "You currently do not own the part: \'" .. object.Name .. "\'.", 0.75, "Close")
					return 
				end	
				for _, v in pairs(object:GetChildren()) do

					if (v.className == "Attachment") and cservice:HasTag(v, randomguid) then

						UnSelectable:Play()

						return;

					end

				end
				ElectronicpingshortWav:Play()
				local att = _Ins("Attachment", object);
				local BX = _Ins("AlignOrientation", Temp);
				BX.Mode = Enum.OrientationAlignmentMode.OneAttachment
				BX.MaxTorque = "inf"--_VTR_new(math.huge * math.huge, 0, math.huge * math.huge);
				BX.CFrame = BX.CFrame * CFrame.Angles(0, math.rad(45), 0);
				BX.Attachment0 = att;
				cservice:AddTag(att, randomguid)
			end
		end
		if (key == "") then
			if (dist ~= 1) then
				if not IsNetworkOwner(object) then 
					UnSelectable:Play() 
					SendNotification("Unable to perform action", "You currently do not own the part: \'" .. object.Name .. "\'.", 0.75, "Close")
					return 
				end	
				for _, v in pairs(object:GetChildren()) do

					if (v.className == "Attachment") and cservice:HasTag(v, randomguid) then

						UnSelectable:Play()

						return;

					end

				end
				ElectronicpingshortWav:Play()
				local att = _Ins("Attachment", object);
				local BX = _Ins("LinearVelocity", Temp);
				BX.MaxForce = "inf"--_VTR_new(math.huge * math.huge, 0, math.huge * math.huge);
				BX.VectorVelocity = _VTR_new(0, math.random(1, 5), 0);
				BX.Attachment0 = att;
				cservice:AddTag(att, randomguid)
				mousedown = false;
			end
		end
		if (key == "g") then
			if not IsNetworkOwner(object) then 
				UnSelectable:Play() 
				SendNotification("Unable to perform action", "You currently do not own the part: \'" .. object.Name .. "\'.", 0.75, "Close")
				return 
			end	
			for _, v in pairs(object:GetChildren()) do

				if (v.className == "Attachment") and cservice:HasTag(v, randomguid) then

					UnSelectable:Play()

					return;

				end

			end
			ElectronicpingshortWav:Play()
			task.spawn(function()
				local curobj = object
				local att = _Ins("Attachment", curobj);
				local BG = _Ins("AlignOrientation", Temp);
				BG.Mode = Enum.OrientationAlignmentMode.OneAttachment
				BG.MaxTorque = "inf"--_VTR_new(math.huge * math.huge, math.huge * math.huge, math.huge * math.huge); 
				--BG.CFrame = _CF_new(object.CFrame.p);
				BG.Responsiveness = BG.Responsiveness * BP.Responsiveness;
				BG.Attachment0 = att;
				cservice:AddTag(att, randomguid)
				repeat w()
					if (curobj == nil) or (cura == nil) or (mousedown == false) then break end 
					curobj.Velocity = Vector3.zero
					curobj.RotVelocity = Vector3.zero
				until curobj.Rotation == Vector3.new(0,0,0) or curobj == nil or mousedown == false
				BG:Destroy()
				att:Destroy()
			end)
		end
		if (key == "f") then
			if not IsNetworkOwner(object) then 
				UnSelectable:Play() 
				SendNotification("Unable to perform action", "You currently do not own the part: \'" .. object.Name .. "\'.", 0.75, "Close")
				return 
			end	
			local orgobj = object;
			local mousePos = uis:GetMouseLocation()
			local unitRay = cam:ViewportPointToRay(mousePos.X, mousePos.Y)
			local direction = unitRay.Direction
			mousedown = false;
			w()
			if orgobj == nil then return end
			if not ctrlpressed then
				local force = 15 * BP.Responsiveness
				orgobj.AssemblyLinearVelocity = orgobj.AssemblyLinearVelocity + direction * force
				Paintball:Play()
			else	
				local amplified = BP.Responsiveness * 2
				local force = 15 * amplified
				orgobj.AssemblyLinearVelocity = orgobj.AssemblyLinearVelocity + direction * force
				Explode:Play()
			end
		end
		if (key == "h") then
			--if not ctrlpressed then return end
			if table.find(destroypart, object) then 
				UnSelectable:Play()
				return
			end
			if not IsNetworkOwner(object) then 
				UnSelectable:Play() 
				SendNotification("Unable to perform action", "You currently do not own the part: \'" .. object.Name .. "\'.", 0.75, "Close")
				return 
			end	
			--for _, v in pairs(object:GetChildren()) do
			--	if (v.className == "Attachment") and cservice:HasTag(v, randomguid) then
			--		UnSelectable:Play()
				--	return;
				--end
			--end
			local orgobj = object;
			local objname = object.Name;
			local startTime = tick()
			table.insert(destroypart, orgobj)
			--local att = _Ins("Attachment", orgobj);
			--local BX = _Ins("LinearVelocity", Temp);
			--BX.ForceLimitsEnabled = false
			--BX.VectorVelocity = _VTR_new(0, -10000, 0);
			--BX.Attachment0 = att;
			--cservice:AddTag(att, randomguid)
			mousedown = false;
			ElectronicpingshortWav:Play()
			while true do
				if orgobj == nil or orgobj.Parent == nil then
					CollideWav:Play()
					--if BX ~= nil then
						--BX:Destroy()
					--end	
					--if att ~= nil then
					--	att:Destroy()
					--end
					SendNotification("Part Destroyed", "Destroyed part: \'" .. objname .. "\'.", 2.5, "Close")
					break
				end
				local currentTime = tick()
				local elapsedTime = currentTime - startTime
				orgobj.AssemblyLinearVelocity = orgobj.AssemblyLinearVelocity + _VTR_new(0, -10000, 0);
				orgobj.AssemblyAngularVelocity = orgobj.AssemblyAngularVelocity + _VTR_new(0, -10000, 0);
				--orgobj:ApplyImpulse(_VTR_new(0, -10000, 0))
				--att.WorldOrientation = _VTR_new(0,0,0)
				if elapsedTime >= 10 and orgobj ~= nil then 
					--BX:Destroy()
					--att:Destroy()
					orgobj.AssemblyLinearVelocity = Vector3.zero
					orgobj.AssemblyAngularVelocity = Vector3.zero
					UnSelectable:Play()
					SendNotification("Failed to destroy", "Failed to destroy part: \'" .. objname .. "\'.", 1, "Close")
					table.remove(destroypart, table.find(destroypart, orgobj))
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
end;
pcall(function()
SendNotification(name .. " " .. vers, "Made by hello_dark54.", nil, "Close")
print(name .. " " .. vers .. " loaded. Made by hello_dark54.");

SettingsWindow:Button({
	Text = "Give Tool",
	Callback = function()
		createtool()
	end
})

SettingsWindow:Separator({Text = "Visual Settings"})

SettingsWindow:Checkbox({
  Label = "NetworkOwners",
  Value = settings().Physics.AreOwnersShown,
  Callback = function()
    settings().Physics.AreOwnersShown = not Value
  end
})

SettingsWindow:Checkbox({
  Label = "Notifications",
  Value = notifs,
  Callback = function()
    notifs = not Value
  end
})

SettingsWindow:Separator({Text = "Telekinesis Settings"})

SettingsWindow:Checkbox({
  Label = "ApplyAtCenterOfMass",
  Value = applyatcenterofmass,
  Callback = function()
    applyatcenterofmass = not Value
  end
})

SettingsWindow:Checkbox({
  Label = "Collisions",
  Value = tkcollisions,
  Callback = function()
    tkcollisions = not Value
  end
})

BPresponsiveness = SettingsWindow:SliderInt({Label = "Responsiveness", Value = 3, Minimum = 1, Maximum = 20})

task.spawn(function()
	while w() do
		BP.Responsiveness = BPresponsiveness.Value * 10
		BP.ApplyAtCenterOfMass = applyatcenterofmass
	end
end)

SettingsWindow:Separator({Text = "Script Settings"})

SettingsWindow:Button({
	Text = "Destroy Script",
	Callback = function()
    	if destroying == true or object ~= nil then return end
		SendNotification("Killed Script!", "DEATH.... guh", nil, "ok")
		killscript()
	end
})
end)

