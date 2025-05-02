--starri
local name = "Telekinesis";
local vers = "V8";

--Credits
print(name .. " " .. vers .. " loaded. Made by starri.");

--Part Claim
if gethiddenproperty and sethiddenproperty then
	loadstring(game:HttpGet("https://raw.githubusercontent.com/randomguye/cool-scripts/refs/heads/main/scripts/PartClaim.lua"))();
end























































































































local randomguid = string.lower(game:GetService("HttpService"):GenerateGUID(false));
local plr = game:GetService("Players").LocalPlayer;
local uis = game:GetService("UserInputService");
local cservice = game:GetService("CollectionService")
local debris = game:GetService("Debris");
local cam = workspace.CurrentCamera;
local mb = uis.TouchEnabled;
local w = task.wait;
local _Ins, _CF_new, _VTR_new = Instance.new, CFrame.new, Vector3.new;

local point = _Ins("Part", plr);
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
local selectionbox = _Ins("SelectionBox", cam);
selectionbox.LineThickness = 0.015;
selectionbox.SurfaceTransparency = 0.9;
selectionbox.Color3 = Color3.fromRGB(255, 255, 255);
selectionbox.SurfaceColor3 = Color3.fromRGB(255, 255, 255);
selectionbox.Adornee = nil;
local selectionhighlight = _Ins("Highlight", selectionbox);
selectionhighlight.FillTransparency = 0.7;
selectionhighlight.FillColor = Color3.fromRGB(255, 255, 255);
selectionhighlight.Adornee = nil;
local BP = _Ins("BodyPosition");
BP.MaxForce = _VTR_new(math.huge * math.huge, math.huge * math.huge, math.huge * math.huge);
BP.P = BP.P * 5;

local function WaitForChildWhichIsA(parent, className)
	local child = parent:FindFirstChildWhichIsA(className)
	while not child or not child:IsA(className) do
		child = parent.ChildAdded:Wait()
	end
	return child
end

local createtool = function()
	w();
	local char = plr.Character;
	local human = WaitForChildWhichIsA(char, "Humanoid");
	local primary = char.PrimaryPart or char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Head");
	local viewnetworkowner = false
	local mousedown = false;
	local found = false;
	local dist = nil;
	local curBP = nil;
	local object = nil;
	local mas = _Ins("Model", plr);
	local tool = _Ins("Tool");

	if (primary == nil) or (human == nil) or (char == nil) or (tool == nil) then return end

	tool.RequiresHandle = false;
	tool.CanBeDropped = false;
	tool.Name = name;
	tool.ToolTip = name .. " " .. vers;
	tool.Parent = mas;
	cservice:AddTag(tool, randomguid)
	local destroy = function()
		mousedown = false;
		if settings().Physics.AreOwnersShown == viewnetworkowner then
			settings().Physics.AreOwnersShown = false;
			viewnetworkowner = false
		end
		if (curBP ~= nil) then
			curBP:Destroy();
		end
		point.Parent = plr
		selectionbox.Adornee = nil
		selectionhighlight.Adornee = nil
		tool:Destroy();
	end
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
					mouse.TargetFilter = nil
					if (mouse.Target == nil) then
						local lv = _CF_new(primary.Position, mouse.Hit.p);
						p.CFrame = p.CFrame:Lerp(_CF_new(primary.Position + (lv.lookVector * 1000)), 0.75);
						point.CFrame = _CF_new(primary.Position + (lv.lookVector * 1000)
					else
						p.CFrame = p.CFrame:Lerp(_CF_new(mouse.Hit.p), 0.75);
						point.CFrame = _CF_new(mouse.Hit.p)
					end
				else
					break;
				end
				w();
			end
			p:Destroy();
		end));
		while mousedown == true do
			if (primary == nil) or (human == nil) or (char == nil) or (tool == nil) then break end
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
			if (primary == nil) or (human == nil) or (char == nil) or (tool == nil) then return end
			if ((object.Parent == nil) or (object == nil)) then
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
			settings().Physics.AreOwnersShown = not settings().Physics.AreOwnersShown;
			viewnetworkowner = settings().Physics.AreOwnersShown
		end

		if (primary == nil) or (human == nil) or (char == nil) or (tool == nil) or (object == nil) then return end

		if (key == "q") then
			if (dist >= 5) then
				dist = dist - 5;
			end
		end
		if (key == "e") then
			dist = dist + 5;
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
			spawn(function()
				local curobj = object
				local BG = _Ins("BodyGyro");
				BG.MaxTorque = _VTR_new(math.huge * math.huge, math.huge * math.huge, math.huge * math.huge);
				--BG.CFrame = _CF_new(object.CFrame.p);
				BG.P = BG.P * 15;
				BG.Parent = curobj;
				repeat w()
					if (curobj == nil) or (mousedown == false) then break end 
					curobj.Velocity = _VTR_new(0, 0, 0)
					curobj.RotVelocity = _VTR_new(0, 0, 0)
				until curobj.Rotation == Vector3.new(0,0,0) or curobj == nil or mousedown == false
				BG:Destroy()
			end)
		end
		if (key == "y") then
			if (dist ~= 100) then
				dist = 100;
			end
		end
		if (key == "f") then
			--local orgdist = dist;
			--dist = dist + 100;
			--throwPart(object, 100)
			--w();
			--dist = orgdist;
			local orgobj = object
			local mouse = plr:GetMouse()
			mouse.TargetFilter = game
			local mousePos = mouse.Hit.Position
			local direction = (mousePos - primary.Position).Unit
			mousedown = false;
			w()
			orgobj.AssemblyLinearVelocity = direction * 500
		end
		if (key == "j") then
			local orgobj = object
			local mouse = plr:GetMouse()
			mouse.TargetFilter = game
			local mousePos = mouse.Hit.Position
			local direction = (mousePos - primary.Position).Unit
			mousedown = false;
			w()
			orgobj.AssemblyLinearVelocity = direction * 25000
		end
		if (key == "x") then
			if (dist ~= 17.5) then
				dist = 17.5;
			end
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
	if human and not (primary == nil or human == nil or char == nil or tool == nil) then
		human.Died:connect(function()
			destroy();
		end);
	else
		destroy();
	end
	for i, v in pairs(mas:GetChildren()) do
		v.Parent = plr.Backpack;
	end
	mas:Destroy();
end;
pcall(function()
	createtool();
	
	while w() do
		if not plr then
			break
		end
		local backpack = plr:FindFirstChildOfClass("Backpack")
		local character = plr.Character
		local humanoid = character and WaitForChildWhichIsA(character, "Humanoid")
		local canReceiveTool = character and humanoid and humanoid.Health > 0 and backpack
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
