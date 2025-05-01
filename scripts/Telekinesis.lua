--Solstice
local name = "Telekinesis";
local vers = "V8";
local plr = game:GetService("Players").LocalPlayer;
local uis = game:GetService("UserInputService");
local debris = game:GetService("Debris");
local cam = workspace.CurrentCamera;
local mb = uis.TouchEnabled;
local w = task.wait;
local _Ins, _CF_new, _VTR_new = Instance.new, CFrame.new, Vector3.new;
local createtool = function()
	w();
	local char = plr.Character;
	local human = char:FindFirstChildOfClass("Humanoid");
	local primary = char.PrimaryPart or char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Head");
	local object = nil;
	local mousedown = false;
	local found = false;
	local dist = nil;
	local mas = _Ins("Model", plr);
	local tool = _Ins("Tool");
	local viewnetworkowner = false
	
	if (primary == nil) or (human == nil) or (char == nil) then return end
	
	tool.RequiresHandle = false;
	tool.CanBeDropped = false;
	tool.Name = name;
	tool.ToolTip = name .. " " .. vers;
	tool.Parent = mas;
	local point = _Ins("Part");
	point.CanCollide = false;
	point.Locked = true;
	point.Anchored = true;
	point.CanQuery = false;
	point.Shape = "Ball";
	point.BrickColor = BrickColor.White();
	point.Size = _VTR_new(0, 0, 0);
	point.Material = Enum.Material.Neon;
	point.Transparency = 0.996;
	local mesh = _Ins("SpecialMesh");
	mesh.MeshId = "rbxassetid://1111494591"
	mesh.Scale = _VTR_new(-0.025, -0.025, -0.025);
	mesh.Parent = point;
	local highlight = _Ins("Highlight", point);
	highlight.FillTransparency = 0.7;
	highlight.FillColor = Color3.fromRGB(255, 255, 255);
	highlight.Adornee = point;
	local pointlight = _Ins("PointLight", point);
	pointlight.Range = 7.5;
	pointlight.Color = Color3.fromRGB(255, 255, 255);
	local selectionbox = _Ins("SelectionBox", cam);
	selectionbox.LineThickness = 0.025;
	selectionbox.SurfaceTransparency = 0.7;
	selectionbox.Color3 = Color3.fromRGB(255, 255, 255);
	selectionbox.SurfaceColor3 = Color3.fromRGB(255, 255, 255);
    	selectionbox.Adornee = nil;
	local selectionhighlight = _Ins("Highlight", selectionbox);
	selectionhighlight.FillTransparency = 0.7;
	selectionhighlight.FillColor = Color3.fromRGB(255, 255, 255);
	selectionhighlight.Adornee = nil;
	local objval = _Ins("ObjectValue");
	objval.Value = nil;
	objval.Name = "objval";
	objval.Parent = plr;
	local BP = _Ins("BodyPosition");
	BP.MaxForce = _VTR_new(math.huge * math.huge, math.huge * math.huge, math.huge * math.huge);
	BP.P = BP.P * 3;
	local cloneBP = BP:Clone();
	local ObjConnect = function(part)
		if (part == object) then
			objval = p;
		end
	end;
	local onButton1Down = function(mouse)
		if (primary == nil) or (human == nil) or (char == nil) or (tool == nil) then return end
		if (mousedown == true) then
			return;
		end
		mousedown = true;
		coroutine.resume(coroutine.create(function()
			local p = point:Clone();
			p.Parent = cam;
			while mousedown == true do
				if (primary == nil) or (human == nil) or (char == nil) or (tool == nil) then break end
				p.Parent = tool;
				if (object == nil) then
					if (mouse.Target == nil) then
						local lv = _CF_new(primary.Position, mouse.Hit.p);
						p.CFrame = _CF_new(primary.Position + (lv.lookVector * 1000));
					else
						p.CFrame = _CF_new(mouse.Hit.p);
					end
				else
					ObjConnect(object);
					break;
				end
				w();
			end
			p:Remove();
		end));
		while mousedown == true do
			if (primary == nil) or (human == nil) or (char == nil) or (tool == nil) then break end
			if (mouse.Target ~= nil) then
				local t = mouse.Target;
				if (t.Anchored == false) then
					object = t;
					if (object.Transparency > 0.996) then
						selectionbox.Adornee = object;
                        selectionhighlight.Adornee = nil;
					else
						selectionhighlight.Adornee = object;
                        selectionbox.Adornee = nil;
					end
					dist = (object.Position - primary.Position).magnitude;
					break;
				end
			end
			w();
		end
		while mousedown == true do
			if (primary == nil) or (human == nil) or (char == nil) or (tool == nil) then return end
			if ((object.Parent == nil) or (object == nil)) then
				if ((BP.Parent == nil) or (BP == nil)) then
					local regenBP = cloneBP:Clone();
					BP = regenBP;
				end
				break;
			end
			pcall(function()
				local lv = _CF_new(primary.Position, mouse.Hit.p);
				BP.Parent = object;
				BP.Position = primary.Position + (lv.lookVector * dist);
				w();
			end);
		end
		BP:Remove();
		object = nil;
		if (objval ~= nil) then
			objval.Value = nil;
		end
		selectionbox.Adornee = nil;
		selectionhighlight.Adornee = nil;
	end;
	local onKeyDown = function(key, mouse)
		if (primary == nil) or (human == nil) or (char == nil) or (tool == nil) or (object == nil) then return end
		local key = key:lower();
		local yesh = false;
		if (key == "q") then
			if (dist >= 5) then
				dist = dist - 5;
			end
		end
		if (key == "u") then
			if (dist ~= 1) then
				local BX = _Ins("BodyGyro");
				BX.MaxTorque = _VTR_new(math.huge * math.huge, 0, math.huge * math.huge);
				BX.CFrame = BX.CFrame * CFrame.Angles(0, math.rad(45), 0);
				BX.D = 0;
				BX.Parent = object;
			end
		end
		if (key == "p") then
			if (dist ~= 1) then
				local BX = _Ins("BodyVelocity");
				BX.MaxForce = _VTR_new(0, math.huge * math.huge, 0);
				BX.Velocity = _VTR_new(0, math.random(1, 5), 0);
				BX.Parent = object;
				mousedown = false;
			end
		end
		if (key == "l") then
			if (object == nil) then
				return;
			end
			for _, v in pairs(object:GetChildren()) do
				if (v.className == "BodyGyro") then
					return nil;
				end
			end
			object.Velocity = _VTR_new(0, 0, 0);
			object.RotVelocity = _VTR_new(0, 0, 0);
			local BG = _Ins("BodyGyro");
			BG.MaxTorque = _VTR_new(math.huge * math.huge, math.huge * math.huge, math.huge * math.huge);
			BG.CFrame = _CF_new(object.CFrame.p);
			BG.P = BG.P * 15;
			BG.Parent = object;
			debris:AddItem(BG, 0.5);
		end
		if (key == "y") then
			if (dist ~= 100) then
				dist = 100;
			end
		end
		if (key == "f") then
			local orgdist = dist;
			dist = dist + 100;
			w();
			dist = orgdist;
			mousedown = false;
		end
		if (key == "j") then
			local orgdist = dist;
			dist = 5000;
			w();
			dist = orgdist;
			mousedown = false;
		end
		if (key == "e") then
			dist = dist + 5;
		end
		if (key == "x") then
			if (dist ~= 17.5) then
				dist = 17.5;
			end
		end
		if (key == "r") then
			settings().Physics.AreOwnersShown = not settings().Physics.AreOwnersShown;
		end
	end;
	local onEquipped = function(mouse)
		local keymouse = mouse;
		mouse.Button1Down:connect(function()
			onButton1Down(mouse);
		end);
		mouse.KeyDown:connect(function(key)
			onKeyDown(key, mouse);
		end);
		if mb then
			uis.TouchLongPress:Connect(function()
				onKeyDown("f", mouse);
			end);
			uis.TouchEnded:Connect(function()
				mousedown = false;
			end);
		else
			mouse.Button1Up:connect(function()
				mousedown = false;
			end);
		end
	end;
	tool.Equipped:connect(onEquipped);
	tool.Unequipped:connect(function()
		mousedown = false;
	end);
	local destroy = function()
		mousedown = false;
		if (BP ~= nil) then
			BP:Remove();
		end
		point:Remove();
		selectionbox:Remove();
		if (objval ~= nil) then
			objval:Remove();
		end
		tool:Remove();
	end
	if human and not (primary == nil or human == nil or char == nil or tool == nil or object == nil) then
	human.Died:connect(function()
		destroy();
	end);
	else
		destroy();
	end
	for i, v in pairs(mas:GetChildren()) do
		v.Parent = plr.Backpack;
	end
	mas:Remove();
end;
createtool();
plr.CharacterAdded:Connect(function()
	createtool();
end);

--Credits
print(name .. " " .. vers .. " loaded. Made by Solstice.");

--Part Claim
loadstring(game:HttpGet("https://raw.githubusercontent.com/randomguye/cool-scripts/refs/heads/main/scripts/PartClaim.lua"))();
