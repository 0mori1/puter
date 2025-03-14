local screen = GetPartFromPort(1, "Screen")
local keyboard = GetPartFromPort(1, "Keyboard")
local modem = GetPartFromPort(1, "Modem")

local server = "PUBLIC"
local frameChange

local messages = {}

screen:ClearElements()
modem:Configure({NetworkID = server})
--make the menu
scroll = screen:CreateElement("ScrollingFrame",{
	Size = UDim2.fromScale(0.9,1);
	BackgroundColor3 = Color3.fromRGB(255,255,255)
})
screen:CreateElement("Frame",{
	BackgroundColor3 = Color3.fromRGB(30,10,190);
	Size = UDim2.fromScale(0.1,1);
	Position = UDim2.fromScale(0.9,0)
})
screen:CreateElement("TextLabel",{
	Size = UDim2.fromScale(0.1,1);
	Text = "PlayerChat";
	Rotation = 90;
	BackgroundTransparency = 1;
	TextColor3 = Color3.fromRGB(255,255,255);
	Position = UDim2.fromScale(0.9,0);
	TextSize = 17
})
textServer = screen:CreateElement("TextLabel",{
	Size = UDim2.fromScale(0.9,0.1);
	TextTransparency = 0.7;
	BackgroundTransparency = 1;
	TextXAlignment = Enum.TextXAlignment.Right;
	Text = "Server: "..server;
})
button = screen:CreateElement("TextButton", {
	BackgroundColor3 = Color3.fromRGB(180,10,30);
	Size = UDim2.fromScale(0.1,0.1);
	Position = UDim2.fromScale(0.9,0);
	Text = ""
})

keyboard.TextInputted:Connect(function(text,player)
	text = text:sub(1,-2)
	if frameChange ~= nil then
		frameChange:Destroy()
		frameChange = nil
		server = text
		modem:Configure({NetworkID = server})
		textServer.Text = "Server: "..server
		for i, d in pairs(messages) do d:Destroy() end messages = {}
	else
		modem:SendMessage({text,player},server)
	end
end)

button.MouseButton1Click:Connect(function()
	if frameChange == nil then
		frameChange = screen:CreateElement("TextLabel",{
			Size = UDim2.fromScale(0.5,0.5);
			Position = UDim2.fromScale(0.25,0.25);
			Text = "Currently changing server. Type the server you want to change (CAPSLOCK SENSITIVE). Press button again to cancel.";
			BackgroundTransparency = 0.5;
			TextScaled = true;
			BackgroundColor3 = Color3.fromRGB(180,180,180)
		})
	else
		frameChange:Destroy()
		frameChange = nil
	end
end)

modem.MessageSent:Connect(function(data)
	local result, err = pcall(function()
		if data[1] and data[2] then
			for i, m in pairs(messages) do
				m.Position += UDim2.fromScale(0,m.Size.Y.Scale)
			end
			local frame = screen:CreateElement("Frame",{
				Size = UDim2.fromScale(1,0.2);
				Parent = scroll
			})
			screen:CreateElement("TextLabel",{
				Size = UDim2.fromScale(0.5,0.15);
				Parent = frame;
				BackgroundTransparency = 1;
				Text = data[2];
				TextXAlignment = Enum.TextXAlignment.Left;
				TextScaled = true
			})
			screen:CreateElement("TextLabel",{
				Size = UDim2.fromScale(0.5,0.15);
				Position = UDim2.fromScale(0.5,0);
				Parent = frame;
				BackgroundTransparency = 1;
				Text = DateTime.now():FormatLocalTime("LT","zh-cn");
				TextScaled = true
			})
			screen:CreateElement("TextLabel",{
				Size = UDim2.fromScale(1,0.85);
				Position = UDim2.fromScale(0,0.15);
				Parent = frame;
				Text = data[1]:sub(1,100);
				TextSize = 8;
				RichText = true;
				TextWrap = true;
				TextYAlignment = Enum.TextYAlignment.Top;
				TextXAlignment = Enum.TextXAlignment.Left;
				BackgroundTransparency = 1
			})
			table.insert(messages,frame)
		end
	end)
	if not result then print(err) end
end)
