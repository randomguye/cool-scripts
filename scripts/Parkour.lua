local plr = game:GetService("Players").LocalPlayer;
local UIS = game:GetService("UserInputService");
local GuiService = game:GetService("GuiService");
local rs = game:GetService("RunService");
local TouchGui = plr:WaitForChild("PlayerGui"):FindFirstChild("TouchGui");
local camera = workspace.CurrentCamera;
local char = plr.Character or plr.CharacterAdded:Wait();
local root = char:WaitForChild("HumanoidRootPart");
local torso = char:WaitForChild("Torso");
local leftarm = char:WaitForChild("Left Arm");
local rightarm = char:WaitForChild("Right Arm");
local leftleg = char:WaitForChild("Left Leg");
local rightleg = char:WaitForChild("Right Leg");
local rightShoulder = torso:WaitForChild("Right Shoulder");
local leftShoulder = torso:WaitForChild("Left Shoulder");
local hum = char:WaitForChild("Humanoid");
local befh = hum.Health;
local rppos = Vector3.new(0, 0, 0);
local sliding = false;
local landed = false;
local pressspacebeforeland = false;
local landdel = false;
local camerakill = false;
local mobile = false;
local downed = false;
local downeddel = false;
local walkingmode = false;
local dodgedel = false;
local rollering = false;
local humdowner = false;
local wallrunable = false;
local wallrunning = false;
local hitfloor = false;
local leftwallrunning = false;
local rightwallrunning = false;
local onfloor = false;
local frontwallrunning = false;
local fronthit = false;
local backjumpdel = false;
local backhit = false;
local rolldel = false;
local wallrundel = false;
local ledgeavailable = true;
local holding = false;
local cdown = false;
local spacedown = false;
local tappeda = false;
local tappeds = false;
local tappedd = false;
local tappedw = false;
local colormansup = 255;
local flowmax = 35;
local flowmin = 16;
local crouchspeed = 8;
local tricksinarow = 0;
local tricktime = 0;
local timestanding = 0;
local combattime = 0;
local floorpositiony = 0;
local updateSpeed = 0.5 / 2;
local killermancamfov = 0;
local beforelandy = 0;
local flowermax = flowmax - flowmin;
local flow = flowmin;
local ignorelist = {char};
local slidingsound = Instance.new("Sound", root);
slidingsound.SoundId = "rbxassetid://4086205029";
slidingsound.PlaybackSpeed = 1.25;
slidingsound.Looped = true;
slidingsound.Volume = 0.75;
local wallrunningsound = Instance.new("Sound", root);
wallrunningsound.SoundId = "rbxassetid://401049343";
wallrunningsound.PlaybackSpeed = 1;
wallrunningsound.Looped = true;
wallrunningsound.Volume = 0.75;
local rollingsound = Instance.new("Sound", root);
rollingsound.SoundId = "rbxassetid://2985734522";
rollingsound.PlaybackSpeed = 1;
rollingsound.Volume = 0.75;
local bodymovesound = Instance.new("Sound", root);
bodymovesound.SoundId = "rbxassetid://152206206";
bodymovesound.PlaybackSpeed = 0.945;
bodymovesound.Volume = 2.35;
local downedsound = Instance.new("Sound", root);
downedsound.SoundId = "rbxassetid://178088040";
downedsound.PlaybackSpeed = 1;
downedsound.Volume = 3;
local jumplandsoundthingy = Instance.new("Sound", root);
jumplandsoundthingy.SoundId = "rbxassetid://6079431954";
jumplandsoundthingy.PlaybackSpeed = 0.785;
jumplandsoundthingy.Volume = 2;
local winder = Instance.new("Sound",root);
winder.SoundId = "rbxasset://sounds/action_falling.ogg";
winder.Volume = 0;
winder.PlaybackSpeed = 1;
winder.Looped = true;
winder:Play();
local windercloth = Instance.new("Sound",root);
windercloth.SoundId = "rbxassetid://866649671";
windercloth.Volume = 0;
windercloth.PlaybackSpeed = 1;
windercloth.Looped = true;
windercloth:Play();
local leftwallrunanim = Instance.new("Animation", hum);
leftwallrunanim.AnimationId = "rbxassetid://180426354";
local leftwallrunanimplay = hum:LoadAnimation(leftwallrunanim);
local downedanim1 = Instance.new("Animation", hum);
downedanim1.AnimationId = "rbxassetid://282574440";
local downedanim1play = hum:LoadAnimation(downedanim1);
local rightwallrunanim = Instance.new("Animation", hum);
rightwallrunanim.AnimationId = "rbxassetid://180426354";
local rightwallrunanimplay = hum:LoadAnimation(rightwallrunanim);
local verticalwallrunanim = Instance.new("Animation", hum);
verticalwallrunanim.AnimationId = "rbxassetid://180426354";
local verticalwallrunanimplay = hum:LoadAnimation(verticalwallrunanim);
local roll = Instance.new("Animation", hum);
roll.AnimationId = "rbxassetid://180612465";
local rollplay = hum:LoadAnimation(roll);
local crouching = Instance.new("Animation", hum);
crouching.AnimationId = "rbxassetid://287325678";
local crouchingplay = hum:LoadAnimation(crouching);
local springjump = Instance.new("Animation", hum);
springjump.AnimationId = "rbxassetid://287325678";
local springjumpplay = hum:LoadAnimation(springjump);
local dodging = Instance.new("Animation", hum);
dodging.AnimationId = "rbxassetid://287325678";
local dodgingplay = hum:LoadAnimation(dodging);
local slidinganim = Instance.new("Animation", hum);
slidinganim.AnimationId = "rbxassetid://132546884";
local slidingplay = hum:LoadAnimation(slidinganim);
local holdingon = Instance.new("Animation", hum);
holdingon.AnimationId = "rbxassetid://148831003";
local HA = hum:LoadAnimation(holdingon);
local climbingstuffs = Instance.new("Animation", hum);
climbingstuffs.AnimationId = "rbxassetid://125750702";
local CA = hum:LoadAnimation(climbingstuffs);
local colorparkourkill = Instance.new("ColorCorrectionEffect", camera);
colorparkourkill.Saturation = 0;
colorparkourkill.TintColor = Color3.new(1, 1, 1);
function randomclothrollsound(truth)
	coroutine.resume(coroutine.create(function()
		if (truth ~= nil) then
			local s = Instance.new("Sound", root);
			s.Volume = 0.8 + (math.random(1, 6) * 0.05);
			s.PlaybackSpeed = 0.8 + (math.random(1, 6) * 0.05);
			local rannum = math.random(1, 5);
			if (rannum == 1) then
				s.SoundId = "rbxassetid://4086203738";
			elseif (rannum == 2) then
				s.SoundId = "rbxassetid://4086203442";
			elseif (rannum == 3) then
				s.SoundId = "rbxassetid://4086203142";
			elseif (rannum == 4) then
				s.SoundId = "rbxassetid://4086203973";
			else
				s.SoundId = "rbxassetid://4307029050";
			end
			s:Play();
			game:GetService("Debris"):AddItem(s, 4);
		else
			local s = Instance.new("Sound", root);
			s.Volume = 0.25 + (math.random(1, 6) * 0.05);
			s.PlaybackSpeed = 0.8 + (math.random(1, 6) * 0.05);
			local rannum = math.random(1, 7);
			if (rannum == 1) then
				s.SoundId = "rbxassetid://3929467229";
			elseif (rannum == 2) then
				s.SoundId = "rbxassetid://3929467449";
			elseif (rannum == 3) then
				s.SoundId = "rbxassetid://3929467655";
			elseif (rannum == 4) then
				s.SoundId = "rbxassetid://3929467888";
			elseif (rannum == 5) then
				s.SoundId = "rbxassetid://4458760046";
			elseif (rannum == 6) then
				s.SoundId = "rbxassetid://4458760518";
			else
				s.SoundId = "rbxassetid://4458759938";
			end
			s:Play();
			game:GetService("Debris"):AddItem(s, 4);
		end
	end));
end
local gyro = Instance.new("BodyGyro", torso);
gyro.D = 200;
gyro.P = 1800;
local cameratilterman = 0;
local springjumpdel = false;
local gobackroll = false;
local befpower = gyro.P;
gyro.P = befpower;
gyro.MaxTorque = Vector3.new(0, 0, 0);
local runvel = Instance.new("BodyVelocity", root);
runvel.MaxForce = Vector3.new(0, 0, 0);
runvel.P = math.huge;
hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false);
hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false);
hum.WalkSpeed = 20;
hum.JumpPower = 50;
if (UIS.TouchEnabled and not UIS.KeyboardEnabled and not UIS.MouseEnabled and not UIS.GamepadEnabled and not GuiService:IsTenFootInterface()) then
	mobile = true;
	jb = TouchGui:WaitForChild("TouchControlFrame"):WaitForChild("JumpButton");
	jb.MouseButton1Down:Connect(function()
		wallrunabletrue();
		wallruncheck();
	end);
end
hum.Died:Connect(function()
	camerakill = true;
	game:GetService("Debris"):AddItem(colorparkourkill, game:GetService("Players").RespawnTime);
end);
UIS.InputEnded:Connect(function(input, gamestuff)
	if (input.KeyCode == Enum.KeyCode.S) then
		if gamestuff then
			return;
		end
		gobackroll = false;
	end
end);
UIS.InputBegan:Connect(function(input, gamestuff)
	if (input.KeyCode == Enum.KeyCode.N) then
		if gamestuff then
			return;
		end
		if (walkingmode == false) then
			walkingmode = true;
		else
			walkingmode = false;
		end
	end
	if (input.KeyCode == Enum.KeyCode.S) then
		if gamestuff then
			return;
		end
		gobackroll = true;
	end
	if (downed == true) then
		return;
	end
	if (sliding == true) then
		return;
	end
	if (input.KeyCode == Enum.KeyCode.A) then
		if (hitfloor == false) then
			return;
		end
		if gamestuff then
			return;
		end
		if (tappeda == false) then
			tappeda = true;
			task.wait(0.25);
			tappeda = false;
		elseif (dodgedel == false) then
			dodgedel = true;
			dodgingplay:Play();
			randomclothrollsound();
			local bv = Instance.new("BodyVelocity", char:WaitForChild("Head"));
			bv.Velocity = (root.CFrame.RightVector * -flow * 2) + Vector3.new(0, flow / 2, 0);
			bv.MaxForce = Vector3.new(99999, 99999, 99999);
			bv.P = math.huge;
			task.wait(0.1);
			bv:Destroy();
			task.wait(0.2);
			dodgingplay:Stop();
			dodgedel = false;
		end
	end
	if (input.KeyCode == Enum.KeyCode.S) then
		if (hitfloor == false) then
			return;
		end
		if gamestuff then
			return;
		end
		if (tappeds == false) then
			tappeds = true;
			task.wait(0.25);
			tappeds = false;
		elseif (dodgedel == false) then
			dodgedel = true;
			dodgingplay:Play();
			randomclothrollsound();
			local bv = Instance.new("BodyVelocity", char:WaitForChild("Head"));
			bv.Velocity = (root.CFrame.LookVector * -flow * 2) + Vector3.new(0, flow / 2, 0);
			bv.MaxForce = Vector3.new(99999, 99999, 99999);
			bv.P = math.huge;
			task.wait(0.1);
			bv:Destroy();
			task.wait(0.2);
			dodgingplay:Stop();
			dodgedel = false;
		end
	end
	if (input.KeyCode == Enum.KeyCode.D) then
		if (hitfloor == false) then
			return;
		end
		if gamestuff then
			return;
		end
		if (tappedd == false) then
			tappedd = true;
			task.wait(0.25);
			tappedd = false;
		elseif (dodgedel == false) then
			dodgedel = true;
			dodgingplay:Play();
			randomclothrollsound();
			local bv = Instance.new("BodyVelocity", char:WaitForChild("Head"));
			bv.Velocity = (root.CFrame.RightVector * flow * 2) + Vector3.new(0, flow / 2, 0);
			bv.MaxForce = Vector3.new(99999, 99999, 99999);
			bv.P = math.huge;
			task.wait(0.1);
			bv:Destroy();
			task.wait(0.2);
			dodgingplay:Stop();
			dodgedel = false;
		end
	end
	if (input.KeyCode == Enum.KeyCode.W) then
		if gamestuff then
			return;
		end
		if (hitfloor == false) then
			return;
		end
		if (tappedw == false) then
			tappedw = true;
			task.wait(0.25);
			tappedw = false;
		elseif (dodgedel == false) then
			dodgedel = true;
			dodgingplay:Play();
			randomclothrollsound();
			local bv = Instance.new("BodyVelocity", char:WaitForChild("Head"));
			bv.Velocity = (root.CFrame.LookVector * flow * 2) + Vector3.new(0, flow / 2, 0);
			bv.MaxForce = Vector3.new(99999, 99999, 99999);
			bv.P = 99999999999999;
			task.wait(0.1);
			bv:Destroy();
			task.wait(0.2);
			dodgingplay:Stop();
			dodgedel = false;
		end
	end
end);
local player = plr;
local character = char;
local rootpart, head = root, char:FindFirstChild("Head");
rs:BindToRenderStep("CameraOffset", Enum.RenderPriority.Character.Value + 1, function()
	local offsetman = 1.5;
	if (sliding == true) then
		offsetman = 0;
	end
	local distance = (character.Head.Position - camera.CoordinateFrame.Position).magnitude;
	if (distance <= 1) then
		rightShoulder.C0 = rightShoulder.C0:lerp((camera.CoordinateFrame * CFrame.new(1, -1, 0)):toObjectSpace(torso.CFrame):inverse() * CFrame.Angles(0, math.pi / 2, 0), updateSpeed);
		leftShoulder.C0 = leftShoulder.C0:lerp((camera.CoordinateFrame * CFrame.new(-1, -1, 0)):toObjectSpace(torso.CFrame):inverse() * CFrame.Angles(0, -math.pi / 2, 0), updateSpeed);
	else
		rightShoulder.C0 = rightShoulder.C0:lerp(CFrame.new(1, 0.5, 0) * CFrame.Angles(0, math.pi / 2, 0), updateSpeed);
		leftShoulder.C0 = leftShoulder.C0:lerp(CFrame.new(-1, 0.5, 0) * CFrame.Angles(0, -math.pi / 2, 0), updateSpeed);
	end
	hum.CameraOffset = (rootpart.CFrame + Vector3.new(0, offsetman, 0)):pointToObjectSpace(head.CFrame.p);
	if (camerakill == false) then
		killermancamfov = 20 * (flow / flowermax);
		colorparkourkill.TintColor = Color3.new(1, colormansup / 255, colormansup / 255);
		colormansup = colormansup + 5;
		if (colormansup > 255) then
			colormansup = 255;
		end
		cam.FieldOfView = 50 + killermancamfov;
		cam.CFrame = cam.CFrame * CFrame.Angles(0, 0, math.rad(cameratilterman));
	end
end);
local function round(number, decimalPlaces)
	number = math.round(number * (10 ^ decimalPlaces)) * (10 ^ -decimalPlaces);
end
function downer()
	flow = flow - (flowmax / 10);
	downedanim1play:Play();
	colormansup = colormansup - 60;
	downedsound:Play();
	randomclothrollsound(true);
	downed = true;
	hum.JumpPower = 0;
	downeddel = true;
	coroutine.resume(coroutine.create(function()
		local tiltnumb = 0;
		local rannum = math.random(1, 4);
		if (rannum == 1) then
			tiltnumb = 80;
		elseif (rannum == 2) then
			tiltnumb = 50;
		elseif (rannum == 3) then
			tiltnumb = -80;
		else
			tiltnumb = -50;
		end
		local cameratilterman2 = tiltnumb * 0.2;
		local cameratiltermax = cameratilterman2;
		local sinnerman = 1;
		local sinnerman2 = 0;
		for i = 20, 1, -1 do
			rs.PreRender:Wait();
			if (camerakill == true) then
				return;
			end
			sinnerman = sinnerman - 0.05;
			sinnerman2 = math.sin(sinnerman * 1.25);
			cameratilterman2 = cameratiltermax * sinnerman2;
			cam.CFrame = cam.CFrame * CFrame.Angles(0, 0, math.rad(cameratilterman2));
		end
		task.wait(1);
		downeddel = false;
	end));
end
hum.HealthChanged:Connect(function()
	colorparkourkill.Saturation = -1 + (hum.Health / hum.MaxHealth);
	if ((hum.Health / hum.MaxHealth) < 0.25) then
		if (humdowner == false) then
			humdowner = true;
			downer();
		end
	end
	if (hum.Health < befh) then
		combattime = 18;
		local damagetiltmax = befh - hum.Health;
		round(damagetiltmax, 1);
		colormansup = colormansup - (damagetiltmax * 4.25);
		local cameratilterman2 = math.random(damagetiltmax * -20, damagetiltmax * 20);
		cameratilterman2 = cameratilterman2 * 0.05;
		local cameratilterman3 = math.random(damagetiltmax * -20, damagetiltmax * 20);
		cameratilterman3 = cameratilterman3 * 0.0008675;
		local cameratiltermax = cameratilterman2;
		local cameratiltermax2 = cameratilterman3;
		local sinnerman = 1;
		local sinnerman2 = 0;
		for i = 10, 1, -1 do
			rs.PreRender:Wait();
			sinnerman = sinnerman - 0.1;
			sinnerman2 = math.sin(sinnerman * 1.25);
			cameratilterman2 = cameratiltermax * sinnerman2;
			cameratilterman3 = cameratiltermax2 * sinnerman2;
			cam.CFrame = cam.CFrame * CFrame.Angles(math.rad(cameratilterman3), 0, math.rad(cameratilterman2));
		end
	end
	befh = hum.Health;
end);
function tilterepic(maxnumbman, slideringman)
	coroutine.resume(coroutine.create(function()
		if (maxnumbman ~= 0) then
			local sinnerman = 0;
			local slidingtruth = false;
			if (slideringman ~= nil) then
				if (slideringman == true) then
					slidingtruth = true;
				end
			end
			for i = 20, 1, -1 do
				if (slidingtruth == false) then
					if (wallrunning == false) then
						return;
					end
				end
				if (slidingtruth == true) then
					if (sliding == false) then
						return;
					end
				end
				rs.PreRender:Wait();
				if (camerakill == true) then
					return;
				end
				sinnerman = sinnerman + 0.05;
				sinnerman = math.sin(sinnerman * 1.25);
				cameratilterman = maxnumbman * sinnerman;
			end
		else
			local cameratiltermax = cameratilterman;
			local sinnerman = 1;
			local sinnerman2 = 0;
			for i = 10, 1, -1 do
				rs.PreRender:Wait();
				if (camerakill == true) then
					return;
				end
				sinnerman = sinnerman - 0.1;
				sinnerman2 = math.sin(sinnerman * 1.25);
				cameratilterman = cameratiltermax * sinnerman2;
			end
			task.wait();
			cameratilterman = 0;
		end
	end));
end
function roll()
	if (sliding == true) then
		return;
	end
	if (hitfloor == false) then
		return;
	end
	if (wallrunning == true) then
		return;
	end
	if (rolldel == true) then
		return;
	end
	rolldel = true;
	randomclothrollsound(true);
	rollingsound.TimePosition = 0.3;
	rollingsound:Play();
	root.Velocity = Vector3.new(0, 0, 0);
	local x, y, z = root.CFrame:ToEulerAnglesYXZ();
	rollering = true;
	tricksinarow = tricksinarow + 1;
	local rollmancf = CFrame.new(Vector3.new(root.Position.X, floorpositiony + 1.5, root.Position.Z)) * CFrame.Angles(0, y, 0);
	root.CFrame = rollmancf;
	task.wait();
	root.Velocity = Vector3.new(0, 0, 0);
	flow = flow + ((flowmax - flowmin) / 8);
	runvel.Velocity = root.CFrame.LookVector * hum.WalkSpeed;
	local bp = Instance.new("BodyPosition", torso);
	bp.Position = Vector3.new(0, floorpositiony, 0);
	bp.MaxForce = Vector3.new(0, 999999999, 0);
	bp.P = 25000;
	hum.PlatformStand = true;
	runvel.MaxForce = Vector3.new(99999, 99999, 99999);
	gyro.CFrame = rollmancf;
	gyro.P = 99999;
	gyro.MaxTorque = Vector3.new(99999, 99999, 99999);
	rollplay:Play();
	local lookcfog = cam.CFrame;
	local angle = 0;
	rollplay:AdjustSpeed(0);
	rollplay.TimePosition = 1;
	local rotatenumb = -18;
	if (gobackroll == true) then
		rotatenumb = 18;
	end
	for i = 20, 1, -1 do
		rs.Heartbeat:Wait();
		if (camerakill == true) then
			return;
		end
		runvel.MaxForce = Vector3.new(99999, 99999, 99999);
		runvel.Velocity = rollmancf.LookVector * -rotatenumb * 3;
		gyro.CFrame = gyro.CFrame * CFrame.Angles(math.rad(rotatenumb), 0, 0);
		root.CFrame = gyro.CFrame;
	end
	runvel.MaxForce = Vector3.new(0, 0, 0);
	rollplay:Stop();
	hum.PlatformStand = false;
	rollering = false;
	bp:Destroy();
	gyro.P = befpower;
	runvel.MaxForce = Vector3.new(0, 0, 0);
	gyro.MaxTorque = Vector3.new(0, 0, 0);
	root.Velocity = Vector3.new(0, 0, 0);
	root.Velocity = Vector3.new(0, 0, 0);
	rolldel = false;
	if (rotatenumb == 18) then
		cam.CFrame = lookcfog;
	end
	task.wait();
end
UIS.InputBegan:Connect(function(input, g)
	if (input.KeyCode == Enum.KeyCode.C) then
		if g then
			return;
		end
		cdown = true;
	end
	if (input.KeyCode == Enum.KeyCode.P) then
		if g then
			return;
		end
		hum:TakeDamage(1);
	end
end);
UIS.InputEnded:Connect(function(input, g)
	if (input.KeyCode == Enum.KeyCode.C) then
		if g then
			return;
		end
		cdown = false;
	end
end);
cam = camera;
UIS.InputBegan:Connect(function(input, gamestuff)
	if (input.KeyCode == Enum.KeyCode.X) then
		if (camerakill == true) then
			return;
		end
		if gamestuff then
			return;
		end
		if (camerakill == false) then
			for i = 5, 1, -1 do
				rs.PreRender:Wait();
				if (camerakill == true) then
					return;
				end
				cam.CFrame = cam.CFrame * CFrame.Angles(0, math.rad(35), 0);
			end
		end
	end
end);
coroutine.resume(coroutine.create(function()
	while true do
		if (camerakill == true) then
			return;
		end
		rs.PreRender:Wait();
		if (combattime > 0.05) then
			combattime = combattime - 0.01;
		else
			combattime = 0;
		end
		if ((rolldel == true) or (downed == true)) then
			if (camerakill == true) then
				return;
			end
			cam.CFrame = char:WaitForChild("Head").CFrame;
		end
		if (camerakill == false) then
			winder.Volume = root.Velocity.Magnitude * 0.00125;
			if (winder.Volume > 1.25) then
				winder.Volume = 1.25;
			end
			--winder.PlaybackSpeed = root.Velocity.Magnitude * 0.005;
			--if (winder.PlaybackSpeed > 1.5) then
			--	winder.PlaybackSpeed = 1.5;
			--end
			windercloth.Volume = root.Velocity.Magnitude * 0.001;
			if (windercloth.Volume > 1) then
				windercloth.Volume = 1;
			end
			--windercloth.PlaybackSpeed = root.Velocity.Magnitude * 0.005;
			--if (windercloth.PlaybackSpeed > 1.25) then
			--	windercloth.PlaybackSpeed = 1.25;
			--end
		end
		if ((rolldel == false) and (wallrunning == false) and (sliding == false) and (downed == false) and (holding == false)) then
			hum.AutoRotate = true;
			if (slidingsound.IsPlaying == true) then
				slidingsound:Stop();
			end
			if (wallrunningsound.IsPlaying == true) then
				wallrunningsound:Stop();
			end
		else
			hum.AutoRotate = false;
			if (wallrunning == true) then
				if (wallrunningsound.IsPlaying == false) then
					wallrunningsound:Play();
				end
			elseif (wallrunningsound.IsPlaying == true) then
				wallrunningsound:Stop();
			end
			if (sliding == true) then
				if (slidingsound.IsPlaying == false) then
					slidingsound:Play();
				end
			elseif (slidingsound.IsPlaying == true) then
				slidingsound:Stop();
			end
		end
	end
end));
function wallrunabletrue()
	coroutine.resume(coroutine.create(function()
		if (hitfloor == true) then
			return;
		end
		wallrunable = true;
		task.wait(0.05);
		wallrunable = false;
	end));
end
function verticalwallrun(grav2)
	coroutine.resume(coroutine.create(function()
		if (wallrundel == true) then
			return;
		end
		if (wallrunning == true) then
			return;
		end
		if (downed == true) then
			return;
		end
		if (cdown == true) then
			return;
		end
		if (wallrunable == false) then
			return;
		end
		if fronthit then
			local rr = Ray.new(root.Position, root.CFrame.LookVector * 5);
			local rhit, ray, rpoint = workspace:FindPartOnRayWithIgnoreList(rr, ignorelist);
			if rhit then
				if rhit then
					wallrunning = false;
					task.wait();
					tilterepic(0);
					tricksinarow = tricksinarow + 1;
					wallrunning = true;
					gyro.CFrame = CFrame.new(root.Position, root.Position + rpoint) * CFrame.Angles(math.rad(-22), math.rad(180), 0);
					gyro.MaxTorque = Vector3.new(99999, 99999, 99999);
					local grav = grav2 - 11;
					runvel.Velocity = Vector3.new(0, grav, 0);
					runvel.MaxForce = Vector3.new(99999, 99999, 99999);
					wallrunable = false;
					hum.PlatformStand = true;
					randomclothrollsound();
					verticalwallrunanimplay:Play();
					while wallrunning == true do
						rs.PreRender:Wait();
						if (camerakill == true) then
							return;
						end
						grav = grav - 0.8;
						local r2 = Ray.new(root.Position, root.CFrame.LookVector * 5);
						local hit, ray, point = workspace:FindPartOnRayWithIgnoreList(r2, ignorelist);
						if hit then
							if hitfloor then
								wallrunning = false;
							end
							if (cdown == true) then
								wallrunning = false;
							end
							if hit then
								gyro.CFrame = CFrame.new(ray + (root.CFrame.LookVector * -2), ray + (root.CFrame.LookVector * -2) + point) * CFrame.Angles(math.rad(-22), math.rad(180), 0);
								runvel.Velocity = Vector3.new(0, grav, 0);
								gyro.P = befpower;
								if (wallrunable == true) then
									wallrunning = false;
									gyro.MaxTorque = Vector3.new(0, 0, 0);
									hum.PlatformStand = false;
									randomclothrollsound();
									jumplandsoundthingy:Play();
									local rannum = math.random(1, 3);
									if (rannum == 1) then
										jumplandsoundthingy.SoundId = "rbxassetid://6079433272";
									elseif (rannum == 2) then
										jumplandsoundthingy.SoundId = "rbxassetid://6079432684";
									else
										jumplandsoundthingy.SoundId = "rbxassetid://6079431954";
									end
									bodymovesound:Play();
									hum.PlatformStand = false;
									runvel.velocity = (root.CFrame.LookVector * -hum.WalkSpeed) + Vector3.new(0, 30, 0);
									task.wait(0.22);
								end
							else
								wallrunning = false;
							end
						else
							wallrunning = false;
						end
					end
					hum.PlatformStand = false;
					verticalwallrunanimplay:Stop();
					gyro.MaxTorque = Vector3.new(0, 0, 0);
					runvel.MaxForce = Vector3.new(0, 0, 0);
					hum:ChangeState(Enum.HumanoidStateType.Jumping);
					return;
				end
			end
		end
	end));
end
function wallruncheck()
	if (downed == true) then
		if ((rolldel == false) and (downeddel == false)) then
			downedanim1play:Stop();
			downed = false;
			hum.JumpPower = 50;
			roll();
			return;
		end
	end
	if (sliding == true) then
		return;
	end
	if (cdown == true) then
		if (hitfloor == true) then
			roll();
		end
	end
	if (wallrundel == true) then
		return;
	end
	if (wallrunning == true) then
		return;
	end
	if (wallrunable == false) then
		return;
	end
	if (cdown == true) then
		return;
	end
	if (dodgedel == true) then
		return;
	end
	wallrunable = false;
	local rr = Ray.new(root.Position, root.CFrame.RightVector * 3.5);
	local rhit, ray, rpoint = workspace:FindPartOnRayWithIgnoreList(rr, ignorelist);
	if rhit then
		if rhit then
			wallrunning = true;
			gyro.CFrame = CFrame.new(root.Position, root.Position + rpoint) * CFrame.Angles(0, math.rad(-90), math.rad(20));
			gyro.MaxTorque = Vector3.new(99999, 99999, 99999);
			hum.PlatformStand = true;
			local grav = 20;
			runvel.Velocity = (gyro.CFrame.LookVector * 30) + Vector3.new(0, grav, 0);
			runvel.Velocity = runvel.Velocity + (gyro.CFrame.RightVector * 5);
			runvel.MaxForce = Vector3.new(99999, 99999, 99999);
			rightwallrunanimplay:Play();
			randomclothrollsound();
			tricksinarow = tricksinarow + 1;
			tilterepic(35);
			while wallrunning == true do
				if (camerakill == true) then
					return;
				end
				rs.PreRender:Wait();
				grav = grav - 0.95;
				local r2 = Ray.new(root.Position, root.CFrame.RightVector * 5);
				local hit, ray, point = workspace:FindPartOnRayWithIgnoreList(r2, ignorelist);
				if hit then
					if hitfloor then
						wallrunning = false;
					end
					if (cdown == true) then
						wallrunning = false;
					end
					if (fronthit == true) then
						tilterepic(0);
						wallrunning = false;
						rightwallrunanimplay:Stop();
						gyro.MaxTorque = Vector3.new(0, 0, 0);
						runvel.MaxForce = Vector3.new(0, 0, 0);
						wallrunable = true;
						verticalwallrun(grav + hum.WalkSpeed);
						return;
					end
					if hit then
						gyro.CFrame = CFrame.new(ray + (root.CFrame.RightVector * -2), ray + (root.CFrame.RightVector * -2) + point) * CFrame.Angles(0, math.rad(-90), math.rad(20));
						runvel.Velocity = (gyro.CFrame.LookVector * hum.WalkSpeed) + Vector3.new(0, grav, 0);
						gyro.P = befpower;
						if (wallrunable == true) then
							tilterepic(0);
							wallrunning = false;
							rightwallrunanimplay:Stop();
							gyro.MaxTorque = Vector3.new(0, 0, 0);
							hum.PlatformStand = false;
							jumplandsoundthingy:Play();
							randomclothrollsound();
							local rannum = math.random(1, 3);
							if (rannum == 1) then
								jumplandsoundthingy.SoundId = "rbxassetid://6079433272";
							elseif (rannum == 2) then
								jumplandsoundthingy.SoundId = "rbxassetid://6079432684";
							else
								jumplandsoundthingy.SoundId = "rbxassetid://6079431954";
							end
							bodymovesound:Play();
							runvel.velocity = (cam.CFrame.LookVector * hum.WalkSpeed) + Vector3.new(0, 30, 0);
							task.wait(0.22);
						end
					else
						wallrunning = false;
					end
				else
					wallrunning = false;
				end
			end
			tilterepic(0);
			hum.PlatformStand = false;
			rightwallrunanimplay:Stop();
			gyro.MaxTorque = Vector3.new(0, 0, 0);
			runvel.MaxForce = Vector3.new(0, 0, 0);
			return;
		end
	end
	local rl = Ray.new(root.Position, root.CFrame.RightVector * -3.5);
	local lhit, ray, rpoint = workspace:FindPartOnRayWithIgnoreList(rl, ignorelist);
	if lhit then
		if lhit then
			wallrunning = true;
			gyro.CFrame = CFrame.new(root.Position, root.Position + rpoint) * CFrame.Angles(0, math.rad(90), math.rad(-20));
			gyro.MaxTorque = Vector3.new(99999, 99999, 99999);
			gyro.P = 250;
			local grav = 20;
			runvel.Velocity = (gyro.CFrame.LookVector * 30) + Vector3.new(0, grav, 0);
			runvel.Velocity = runvel.Velocity + (gyro.CFrame.RightVector * -5);
			hum.PlatformStand = true;
			leftwallrunanimplay:Play();
			randomclothrollsound();
			tilterepic(-35);
			tricksinarow = tricksinarow + 1;
			runvel.MaxForce = Vector3.new(99999, 99999, 99999);
			while wallrunning == true do
				if (camerakill == true) then
					return;
				end
				rs.PreRender:Wait();
				if hitfloor then
					wallrunning = false;
				end
				if (fronthit == true) then
					tilterepic(0);
					wallrunning = false;
					leftwallrunanimplay:Stop();
					gyro.MaxTorque = Vector3.new(0, 0, 0);
					runvel.MaxForce = Vector3.new(0, 0, 0);
					wallrunable = true;
					verticalwallrun(grav + hum.WalkSpeed);
					return;
				end
				rs.PreRender:Wait();
				if (camerakill == true) then
					return;
				end
				grav = grav - 0.95;
				local r2 = Ray.new(root.Position, root.CFrame.RightVector * -5);
				local hit, ray, point = workspace:FindPartOnRayWithIgnoreList(r2, ignorelist);
				if hit then
					if (cdown == true) then
						wallrunning = false;
					end
					if hit then
						gyro.CFrame = CFrame.new(ray + (root.CFrame.RightVector * 2), ray + (root.CFrame.RightVector * 2) + point) * CFrame.Angles(0, math.rad(90), math.rad(-20));
						runvel.Velocity = (gyro.CFrame.LookVector * hum.WalkSpeed) + Vector3.new(0, grav, 0);
						gyro.P = befpower;
						if (wallrunable == true) then
							wallrunning = false;
							tilterepic(0);
							leftwallrunanimplay:Stop();
							gyro.MaxTorque = Vector3.new(0, 0, 0);
							hum.PlatformStand = false;
							jumplandsoundthingy:Play();
							randomclothrollsound();
							local rannum = math.random(1, 3);
							if (rannum == 1) then
								jumplandsoundthingy.SoundId = "rbxassetid://6079433272";
							elseif (rannum == 2) then
								jumplandsoundthingy.SoundId = "rbxassetid://6079432684";
							else
								jumplandsoundthingy.SoundId = "rbxassetid://6079431954";
							end
							bodymovesound:Play();
							runvel.velocity = (cam.CFrame.LookVector * hum.WalkSpeed) + Vector3.new(0, 30, 0);
							task.wait(0.22);
						end
					else
						wallrunning = false;
					end
				else
					wallrunning = false;
				end
			end
			hum.PlatformStand = false;
			leftwallrunanimplay:Stop();
			tilterepic(0);
			gyro.MaxTorque = Vector3.new(0, 0, 0);
			runvel.MaxForce = Vector3.new(0, 0, 0);
			return;
		end
	end
	wallrunable = true;
	verticalwallrun(hum.WalkSpeed + 20);
end
UIS.InputBegan:Connect(function(inpt, gamestuff)
	if (inpt.KeyCode == Enum.KeyCode.Space) then
		if gamestuff then
			return;
		end
		if (wallrunning == false) then
			if (sliding == false) then
				if (backhit == true) then
					if (hitfloor == false) then
						jumplandsoundthingy:Play();
						randomclothrollsound(false);
						root.Velocity = (root.CFrame.LookVector * 120) + Vector3.new(0, 40, 0);
					end
				end
			end
		end
		wallrunabletrue();
		wallruncheck();
		if (sliding == true) then
			spacedown = true;
			task.wait(0.1);
			spacedown = false;
		end
		task.wait(0.1);
		if (wallrunning == false) then
			if (rolldel == false) then
				if (backjumpdel == false) then
				end
			end
		end
	end
end);
function slide()
	coroutine.resume(coroutine.create(function()
		if (downed == true) then
			return;
		end
		if (sliding == true) then
			return;
		end
		sliding = true;
		randomclothrollsound();
		tilterepic(-15, true);
		hum.PlatformStand = true;
		gyro.MaxTorque = Vector3.new(99999, 99999, 99999);
		gyro.P = befpower * 3;
		runvel.MaxForce = Vector3.new(99999, 99999, 99999);
		local ogcf = root.CFrame;
		local befrooty = root.Position.Y;
		local ogcf = root.CFrame;
		gyro.CFrame = ogcf * CFrame.Angles(math.rad(80), 0, 0);
		tricksinarow = tricksinarow + 1;
		while sliding == true do
			rs.PreRender:Wait();
			if (camerakill == true) then
				return;
			end
			runvel.Velocity = (ogcf.LookVector * flow * 1.45) + Vector3.new(0, -70, 0);
			slidingplay:Play();
			slidingplay:AdjustSpeed(0);
			if ((root.Position.Y + 0.05) < befrooty) then
				flow = flow + (flowmax / 70);
			end
			befrooty = root.Position.Y;
			if (root.Velocity.Magnitude < 20) then
				sliding = false;
				slidingplay:Stop();
				tilterepic(0, true);
				cdown = false;
				break;
			end
			if (cdown == false) then
				sliding = false;
				slidingplay:Stop();
				tilterepic(0, true);
				break;
			else
			end
			flow = flow - (flowmax / 100);
			if (spacedown == true) then
				sliding = false;
				cdown = false;
				slidingplay:Stop();
				tilterepic(0, true);
				break;
			end
			if (flow < (flowmin + 5)) then
				sliding = false;
				flow = flowmin;
				slidingplay:Stop();
				tilterepic(0, true);
				break;
			end
		end
		gyro.MaxTorque = Vector3.new(0, 0, 0);
		gyro.P = befpower;
		runvel.MaxForce = Vector3.new(0, 0, 0);
		hum.PlatformStand = false;
		if ((spacedown == true) and (flow < flowmax)) then
			hum.PlatformStand = true;
			sliding = false;
			tilterepic(0, true);
			slidingplay:Stop();
			local x, y, z = cam.CFrame:ToEulerAnglesYXZ();
			rollering = true;
			root.CFrame = CFrame.new(root.Position) * CFrame.Angles(0, y, 0);
			bodymovesound:Play();
			roll();
			return;
		elseif ((spacedown == true) and ((flowmax + 3) < flow)) then
			hum.PlatformStand = false;
			sliding = false;
			tilterepic(0, true);
			slidingplay:Stop();
			runvel.MaxForce = Vector3.new(99999, 99999, 99999);
			bodymovesound:Play();
			jumplandsoundthingy:Play();
			randomclothrollsound();
			local rannum = math.random(1, 3);
			if (rannum == 1) then
				jumplandsoundthingy.SoundId = "rbxassetid://6079433272";
			elseif (rannum == 2) then
				jumplandsoundthingy.SoundId = "rbxassetid://6079432684";
			else
				jumplandsoundthingy.SoundId = "rbxassetid://6079431954";
			end
			runvel.Velocity = (cam.CFrame.LookVector * flow * 2) + Vector3.new(0, flow, 0);
			coroutine.resume(coroutine.create(function()
				local tiltnumb = 0;
				local rannum = math.random(1, 4);
				if (rannum == 1) then
					tiltnumb = 40;
				elseif (rannum == 2) then
					tiltnumb = 20;
				elseif (rannum == 3) then
					tiltnumb = -40;
				else
					tiltnumb = -20;
				end
				local cameratilterman2 = tiltnumb * 0.2;
				local cameratiltermax = cameratilterman2;
				local sinnerman = 1;
				local sinnerman2 = 0;
				for i = 10, 1, -1 do
					rs.PreRender:Wait();
					if (camerakill == true) then
						return;
					end
					sinnerman = sinnerman - 0.1;
					sinnerman2 = math.sin(sinnerman * 1.25);
					cameratilterman2 = cameratiltermax * sinnerman2;
					cam.CFrame = cam.CFrame * CFrame.Angles(0, 0, math.rad(cameratilterman2));
				end
			end));
			task.wait(0.25);
			runvel.MaxForce = Vector3.new(0, 0, 0);
			return;
		else
			hum.PlatformStand = false;
			sliding = false;
			return;
		end
	end));
end
function landdeler()
	coroutine.resume(coroutine.create(function()
		landdel = true;
		task.wait(0.2);
		landdel = false;
		pressspacebeforeland = false;
		beforelandy = root.Position.Y;
	end));
end
UIS.InputBegan:Connect(function(input, gamestuff)
	if (springjumpdel == true) then
		return;
	end
	if (input.KeyCode == Enum.KeyCode.Space) then
		if (gamestuff == true) then
			return;
		end
		if (hitfloor == true) then
			if (pressspacebeforeland == false) then
				pressspacebeforeland = true;
			elseif (root.Position.Y > (beforelandy + 2)) then
				runvel.MaxForce = Vector3.new(99999, 99999, 99999);
				runvel.Velocity = (cam.CFrame.LookVector * flow * 2) + Vector3.new(0, flow / 2, 0);
				springjumpdel = true;
				randomclothrollsound();
				jumplandsoundthingy:Play();
				local rannum = math.random(1, 3);
				if (rannum == 1) then
					jumplandsoundthingy.SoundId = "rbxassetid://6079433272";
				elseif (rannum == 2) then
					jumplandsoundthingy.SoundId = "rbxassetid://6079432684";
				else
					jumplandsoundthingy.SoundId = "rbxassetid://6079431954";
				end
				bodymovesound:Play();
				pressspacebeforeland = false;
				springjumpplay:Play();
				tricksinarow = tricksinarow + 1;
				coroutine.resume(coroutine.create(function()
					local tiltnumb = 0;
					local rannum = math.random(1, 4);
					if (rannum == 1) then
						tiltnumb = 40;
					elseif (rannum == 2) then
						tiltnumb = 20;
					elseif (rannum == 3) then
						tiltnumb = -40;
					else
						tiltnumb = -20;
					end
					local cameratilterman2 = tiltnumb * 0.2;
					local cameratiltermax = cameratilterman2;
					local sinnerman = 1;
					local sinnerman2 = 0;
					for i = 10, 1, -1 do
						rs.PreRender:Wait();
						if (camerakill == true) then
							return;
						end
						sinnerman = sinnerman - 0.1;
						sinnerman2 = math.sin(sinnerman * 1.25);
						cameratilterman2 = cameratiltermax * sinnerman2;
						cam.CFrame = cam.CFrame * CFrame.Angles(0, 0, math.rad(cameratilterman2));
					end
				end));
				task.wait(0.2);
				springjumpplay:Stop();
				runvel.MaxForce = Vector3.new(0, 0, 0);
				task.wait(0.2);
				springjumpdel = false;
			end
		end
	end
end);
local Character = char;
local Root = root;
local Head = Character:WaitForChild("Head");
local Hum = hum;
function climb()
	local Vele = Instance.new("BodyVelocity", Head);
	Root.Anchored = false;
	Vele.MaxForce = Vector3.new(1, 1, 1) * math.huge;
	Vele.Velocity = (Root.CFrame.LookVector * 10) + Vector3.new(0, 30, 0);
	HA:Stop();
	CA:Play();
	game.Debris:AddItem(Vele, 0.15);
	holding = false;
	task.wait(0);
	ledgeavailable = true;
end
UIS.InputBegan:Connect(function(Key, Chat)
	if not holding then
		return;
	end
	if ((Key.KeyCode == Enum.KeyCode.Space) and not Chat) then
		climb();
	end
end);
if TouchGui then
	TouchGui:WaitForChild("TouchControlFrame"):WaitForChild("JumpButton").MouseButton1Click:Connect(function()
		if not holding then
			return;
		end
		climb();
	end);
end
while true do
	repeat
		rs.PreRender:Wait();
	until sliding == false 
	rs.PreRender:Wait();
	local r = Ray.new(root.Position, root.CFrame.LookVector * -6);
	local hit, ray = workspace:FindPartOnRayWithIgnoreList(r, ignorelist);
	if hit then
		backhit = true;
	else
		backhit = false;
	end
	if (camerakill == true) then
		return;
	end
	if (hum.FloorMaterial == Enum.Material.Air) then
		if (landed == true) then
			landed = false;
		end
	elseif (landed == false) then
		landed = true;
		landdeler();
	end
	local killx, killy, killz = root.CFrame:ToEulerAnglesYXZ();
	local nobadcf = CFrame.new(root.Position) * CFrame.Angles(0, killy, 0);
	local rclimber = Ray.new(Head.CFrame.p, nobadcf.LookVector * 6);
	local killclimberray = Ray.new(Head.CFrame.p + Vector3.new(0, 0.5, 0), nobadcf.LookVector * 9);
	local killmansraypart, killmansposition;
	workspace:FindPartOnRayWithIgnoreList(killclimberray, ignorelist);
	local part, position = workspace:FindPartOnRayWithIgnoreList(rclimber, ignorelist);
	if not killmansraypart then
		if (part and ledgeavailable and not holding and not killmansraypart) then
			if ((part.Size.Y >= 4) and (part.CanCollide == true) and (killmansraypart == nil) and (part.Transparency ~= 1)) then
				if ((Head.Position.Y >= ((part.Position.Y + (part.Size.Y / 2)) - 1)) and (Head.Position.Y <= (part.Position.Y + (part.Size.Y / 2))) and (Hum.FloorMaterial == Enum.Material.Air) and (sliding == false) and (downed == false) and (wallrunning == true)) then
					if (HA.IsPlaying == false) then
						wallrunning = false;
						root.CFrame = nobadcf;
						randomclothrollsound(false);
						HA:Play();
						wallrunning = false;
						HA:AdjustSpeed(0);
						HA.TimePosition = 1.3;
					end
					Root.Anchored = true;
					holding = true;
					ledgeavailable = false;
				end
			end
		end
	end
	local r = Ray.new(root.Position, Vector3.new(0, 1, 0).Unit * -5.5);
	local hit, ray = workspace:FindPartOnRayWithIgnoreList(r, ignorelist);
	if hit then
		floorpositiony = ray.Y;
		if (hitfloor == false) then
			hitfloor = true;
			if (root.Velocity.Y < -60) then
				if (cdown == true) then
					root.Velocity = Vector3.new(root.Velocity.X, -10, root.Velocity.Z);
					cdown = false;
					roll();
				elseif (root.Velocity.Y < -90) then
					downer();
				end
			end
		end
	elseif (hitfloor == true) then
		hitfloor = false;
	end
	local r = Ray.new(root.Position, root.CFrame.LookVector * 1.8);
	local hit, ray, rp = workspace:FindPartOnRayWithIgnoreList(r, ignorelist);
	if hit then
		fronthit = true;
		rppos = rp;
	else
		fronthit = false;
	end
	if (hitfloor == true) then
		if (cdown == true) then
			if (flow < (flowmin + 5)) then
				if (flow ~= crouchspeed) then
					flow = crouchspeed;
				end
				if (crouchingplay.IsPlaying == false) then
					crouchingplay:Play();
					randomclothrollsound();
				end
			elseif (landed == true) then
				slide();
			end
		end
	end
	if (cdown == false) then
		if (crouchingplay.IsPlaying == true) then
			crouchingplay:Stop();
		end
		if (((walkingmode == false) and (hum.MoveDirection ~= Vector3.new(0, 0, 0))) or (wallrunning == true)) then
			flow = flow + (flowmax / 70);
			if (timestanding ~= 0) then
				timestanding = 0;
			end
			if (flow > flowmax) then
				flow = flowmax;
			end
		else
			flow = flow - (flowmax / 23);
			if (timestanding > 18) then
				timestanding = 0;
				tricksinarow = 0;
			end
			if (flow < flowmin) then
				flow = flowmin;
			end
		end
	end
	if (downed == false) then
		hum.WalkSpeed = flow;
	else
		hum.WalkSpeed = 1;
	end
end