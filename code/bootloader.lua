local restart = GetPort(1)
local shutdown = GetPort(2)
local start = GetPort(5)
local microcontroller
for i, v in pairs(GetPartsFromPort(5, "Microcontroller")) do
	if v.GUID ~= Microcontroller.GUID then
		microcontroller = v
	end
end
local disks = GetPartsFromPort(6, "Disk")
local screen = GetPartFromPort(6, "TouchScreen")
local status = "off"
local function powerOn()
	status = "on"
	TriggerPort(3)
end
local function powerOff()
	status = "off"
	TriggerPort(4)
end
local mounteddisks = {}
local filesystem = {
	createDirectory = function(path, disk)
		if string.sub(path, 1, 1) ~= "/" then
			path = "/" .. path
		end
		if string.sub(path, #path, #path) ~= "/" then
			path = path .. "/"
		end
		disk:Write(path, "t:folder")
	end;
	scanPath = function(path, disk)
		local buffer1 = {}
		local buffer2 = {}
		local buffer3 = {}
		if string.sub(path, #path, #path) ~= "/" then
			path = path .. "/"
		end
		for i, v in pairs(disk:ReadEntireDisk()) do
			if string.sub(i, 1, #path) == path and v ~= nil then
				buffer1[#buffer1 + 1] = string.sub(i, #path + 1, #i)
			end
		end
		for i, v in pairs(buffer1) do
			local added = false
			for i = 1, #v, 1 do
				if string.sub(v, i, i) == "/" and added == false then
					added = true
					if buffer2[string.sub(v, 1, i - 1)] == nil then
						buffer2[string.sub(v, 1, i - 1)] = true
					end
				elseif i == #v and added == false then
					added = true
					if buffer2[string.sub(v, 1, i)] == nil then
						buffer2[string.sub(v, 1, i)] = true
					end
				end
			end
		end
		for i, v in pairs(buffer2) do
			buffer3[#buffer3 + 1] = i
		end
		return buffer3
	end;
	write = function(path, filename, data, disk)
		if string.sub(path, 1, 1) ~= "/" then
			path = "/" .. path
		end
		if string.sub(path, #path, #path) ~= "/" then
			path = path .. "/"
		end
		local badName = false
		for i = 1, #filename, 1 do
			if string.sub(filename, i, i) == "/" then
				badName = true
			end
		end
		if badName == false then
			if disk:Read(path) == "t:folder" then
				disk:Write(path .. filename, data)
				return true, path .. filename
			else
				return false, "not a folder"
			end
		else
			return false, "bad character in name"
		end
	end;
	read = function(path, disk)
		if path ~= nil then
			if disk ~= nil then
				local file = {}
				file.data = disk:Read(path)
				if file.data ~= nil then
					function file:delete()
						if file.data ~= "t:folder" then
							disk:Write(path, nil)
						else
							if string.sub(path, #path, #path) ~= "/" then
								path = path .. "/"
							end
							for i, v in pairs(disk:ReadEntireDisk()) do
								if string.sub(i, 1, #path) == path then
									disk:Write(i, nil)
								end
							end
						end
					end
					if file.data == "t:folder" then
						function file:getDescendants()
							local locationsAndValues = {}
							if string.sub(path, #path, #path) ~= "/" then
								path = path .. "/"
							end
							for i, v in pairs(disk:ReadEntireDisk()) do
								if string.sub(i, 1, #path) == path then
									locationsAndValues[string.sub(i, #path, #i)] = v
								end
							end
							return locationsAndValues
						end
					end
					if file.data == "t:folder" then
						function file:getDescendants()
							local locationsAndValues = {}
							if string.sub(path, #path, #path) ~= "/" then
								path = path .. "/"
							end
							for i, v in pairs(disk:ReadEntireDisk()) do
								if string.sub(i, 1, #path) == path then
									locationsAndValues[string.sub(i, #path, #i)] = v
								end
							end
							return locationsAndValues
						end
					end
					function file:copy(ddisk, destination)
						local name
						if string.sub(destination, #destination, #destination) ~= "/" then
							destination = destination .. "/"
						end
						for i = #path, 1, -1 do
							if string.sub(path, i, i) == "/" and i ~= #path then
								name = string.sub(path, i + 1, #path)
								if string.sub(name, #name, #name) == "/" then
									name = string.sub(name, 1, #name - 1)
								end
							end
						end
						if ddisk:Read(destination) == "t:folder" then
							if file.data ~= "t:folder" then
								ddisk:Write(destination .. name, file.data)
							else
								ddisk:Write(destination .. name .. "/", "t:folder")
								for i, v in pairs(file:getDescendants()) do
									ddisk:Write(destination .. name .. i, v)
								end
							end
						end
					end
					function file:rename(newName)
						local namelessPath
						if string.sub(newName, #newName, #newName) == "/" and file.data ~= "t:folder" then
							newName = string.sub(newName, 1, #newName - 1)
						elseif file.data == "t:folder" and string.sub(newName, #newName, #newName) ~= "/" then
							newName = newName .. "/"
						end
						for i = #path, 1, -1 do
							if string.sub(path, i, i) == "/" and i ~= #path then
								namelessPath = string.sub(path, 1, i)
							end
						end
						disk:Write(namelessPath .. newName, file.data)
						path = namelessPath .. newName
					end
					function file:getName()
						local name
						for i = #path, 1, -1 do
							if string.sub(path, i, i) == "/" and i ~= #path and not name then
								name = string.sub(path, i + 1, #path)
								if string.sub(name, #name, #name) == "/" then
									name = string.sub(name, 1, #name - 1)
								end
							end
						end
						return name
					end
					return file
				end
			else
				return {data = "whoops the disk is not a thing"}
			end
		else
			return {data = "whoops the path is missing"}
		end
	end;
}
local function bootloader()
	local foundPrimary
	mounteddisks = {}
	for i, disk in pairs(disks) do
		if disk ~= nil then
			mounteddisks[i] = disk
		end
	end
	for i, v in pairs(mounteddisks) do
		if v:Read("primary") == "yea" then
			foundPrimary = i
		end
	end
	local detectedAnEntry = false
	if screen ~= nil and foundPrimary then
		local bootEntries = {}
		local function getFiles(path, disk)
			local files = filesystem.scanPath(path, disk)
			for i, v in pairs(files) do
				local file = filesystem.read(path .. v, disk)
				if file ~= nil then
					if string.sub(file.data, 1, 6) == "t:lua/" then
						bootEntries[v] = string.sub(file.data, 7, #file.data)
					end
				end
			end
		end
		getFiles("/Boot/", mounteddisks[foundPrimary])
		local entries = 0
		local scrollingFrame
		for i, v in pairs(bootEntries) do
			if not detectedAnEntry and i ~= "wOS" then
				detectedAnEntry = true
				screen:ClearElements()
				local background = screen:CreateElement("ImageLabel", {
					Size = UDim2.fromOffset(800, 450);
					ImageColor3 = Color3.fromRGB(75,75,75);
					BorderSizePixel = 0;
					Position = UDim2.fromOffset(0,0);
					Image = "http://www.roblox.com/asset/?id=1369437447";
				})
				local header = screen:CreateElement("TextLabel", {
					BackgroundColor3 = Color3.fromRGB(150, 150, 150);
					BorderSizePixel = 0;
					Size = UDim2.fromOffset(800, 25);
					Position = UDim2.fromOffset(0, 0);
					Text = "wOS Boot Manager";
					TextScaled = true;
					TextColor3 = Color3.fromRGB(0,0,0);
					Font = Enum.Font.RobotoMono;
				})
				header.Parent = background
				local prompt = screen:CreateElement("TextLabel", {
					BackgroundTransparency = 1;
					BorderSizePixel = 0;
					Size = UDim2.fromOffset(780, 25);
					Position = UDim2.fromOffset(10, 35);
					Text = "Select a file you want to load.";
					TextScaled = true;
					TextColor3 = Color3.fromRGB(255,255,255);
					Font = Enum.Font.RobotoMono;
					TextXAlignment = Enum.TextXAlignment.Left;
				})
				prompt.Parent = background
				scrollingFrame = screen:CreateElement("ScrollingFrame", {
					Size = UDim2.fromOffset(800, 350);
					Position = UDim2.fromOffset(0, 90);
					BackgroundColor3 = Color3.fromRGB(0,0,0);
					BackgroundTransparency = 0.8;
					ScrollBarThickness = 3;
					BorderSizePixel = 0;
				})
				scrollingFrame.Parent = background
				local wOSEntry = screen:CreateElement("TextButton", {
					BackgroundColor3 = Color3.fromRGB(150, 150, 150);
					BorderSizePixel = 0;
					Size = UDim2.fromOffset(780, 25);
					Position = UDim2.fromOffset(10, 0);
					Text = "wOS";
					TextScaled = true;
					TextColor3 = Color3.fromRGB(0,0,0);
					Font = Enum.Font.RobotoMono;
					TextXAlignment = Enum.TextXAlignment.Left;
				})
				entries = entries + 1
				wOSEntry.MouseButton1Click:Connect(function()
					screen:ClearElements()
					microcontroller:Configure({Code = "https://github.com/0mori1/puter/raw/main/code/putercode.lua"})
					powerOff()
					wait(3)
					powerOn()
				end)
				wOSEntry.Parent = scrollingFrame
				scrollingFrame.CanvasSize = UDim2.fromOffset(800, entries * 25)
				local newEntry = screen:CreateElement("TextButton", {
					BackgroundColor3 = Color3.fromRGB(150, 150, 150);
					BorderSizePixel = 0;
					Size = UDim2.fromOffset(780, 25);
					Position = UDim2.fromOffset(10, entries * 25);
					Text = i;
					TextScaled = true;
					TextColor3 = Color3.fromRGB(0,0,0);
					Font = Enum.Font.RobotoMono;
					TextXAlignment = Enum.TextXAlignment.Left;
				})
				entries = entries + 1
				newEntry.MouseButton1Click:Connect(function()
					screen:ClearElements()
					microcontroller:Configure({Code = v})
					powerOff()
					wait(3)
					powerOn()
				end)
				newEntry.Parent = scrollingFrame
				scrollingFrame.CanvasSize = UDim2.fromOffset(800, entries * 25)
			elseif i ~= "wOS" then
				local newEntry = screen:CreateElement("TextButton", {
					BackgroundColor3 = Color3.fromRGB(150, 150, 150);
					BorderSizePixel = 0;
					Size = UDim2.fromOffset(780, 25);
					Position = UDim2.fromOffset(10, entries * 25);
					Text = i;
					TextScaled = true;
					TextColor3 = Color3.fromRGB(0,0,0);
					Font = Enum.Font.RobotoMono;
					TextXAlignment = Enum.TextXAlignment.Left;
				})
				entries = entries + 1
				newEntry.MouseButton1Click:Connect(function()
					screen:ClearElements()
					microcontroller:Configure({Code = v})
					powerOff()
					wait(3)
					powerOn()
				end)
				newEntry.Parent = scrollingFrame
				scrollingFrame.CanvasSize = UDim2.fromOffset(800, entries * 25)
			end
		end
	end
	if not detectedAnEntry then
		screen:ClearElements()
		microcontroller:Configure({Code = "https://github.com/0mori1/puter/raw/main/code/putercode.lua"})
		powerOn()
	end
end
bootloader()
-- Port 3: Activate polysilicon
-- Port 4: Deactivate polysilicon
restart:Connect("Triggered", function()
	powerOff()
	screen:ClearElements()
	wait(3)
	bootloader()
end)
shutdown:Connect("Triggered", function()
	powerOff()
end)
start:Connect("Triggered", function()
	if status ~= "on" then
		bootloader()
	end
end)
