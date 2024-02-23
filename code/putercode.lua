local mainMicrocontroller = GetPartFromPort(1, "Microcontroller")
local powerController = GetPartFromPort(2, "Microcontroller")
local screen = GetPartFromPort(1, "TouchScreen")
local responded = false
GetPort(3):Connect("Triggered", function()
	responded = true
end)
wait(5)
if responded == false then
	screen:ClearElements()
	screen:CreateElement("TextLabel", {
		Position = UDim2.fromOffset(350, 225);
		Size = UDim2.fromOffset(100, 50);
		Text = "wOS";
		TextScaled = true;
		TextColor3 = Color3.fromRGB(130, 204, 158);
		BackgroundTransparency = 1;
		Font = Enum.Font.Arcade;
	})
	for i = 0, 1, 1 do
		screen:CreateElement("Frame", {
			Position = UDim2.fromOffset(350, 220 + i * 60);
			Size = UDim2.fromOffset(100, 5);
			BackgroundColor3 = Color3.fromRGB(130, 204, 158);
		})
	end
	local repair = screen:CreateElement("TextLabel", {
		Position = UDim2.fromOffset(0, 295);
		Size = UDim2.fromOffset(800, 25);
		Text = "Performing automatic repair...";
		BackgroundTransparency = 1;
		TextScaled = true;
		TextColor3 = Color3.fromRGB(255,255,255);
	})
	powerController:Configure({Code = [[local restart = GetPort(1)
local shutdown = GetPort(2)
-- Port 3: Activate polysilicon
-- Port 4: Deactivate polysilicon

restart:Connect("Triggered", function()
	TriggerPort(4)
	wait(3)
	TriggerPort(3)
end)
shutdown:Connect("Triggered", function()
	TriggerPort(4)
end)]]})
	mainMicrocontroller:Configure({Code = "https://github.com/0mori1/puter/raw/main/code/putercode.lua"})
	screen:ClearElements()
	TriggerPort(1)
end
