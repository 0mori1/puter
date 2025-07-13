local screen
local coroutines = {}
local eventLog = {}
local running = true
local Xres = 0
local Yres = 0
local function tinvert(t)
	local newt = {}
	for i, v in pairs(t) do
		newt[v] = i
	end
	return newt
end
local function xtostring(input, tsplit)
	local split = tsplit or ", "
	local output
	print(tsplit)
	print(split)
	if typeof(input) == "table" then
		print("input is a table!")
		for i, v in pairs(input) do
			output = output .. v .. split
		end
		output = string.sub(output, 1, #output - #split)
	else
		output = tostring(input)
	end
	return output
end
local function nsrex(pattern, str)
	local paz = "abcdefghijklmnopqrztuvwxyz"
	local az = {}
	for i = 1, #paz, 1 do
		az[string.sub(paz, i, i)] = true
	end
	local matchmode = ""
	local forcedstring = false
	for i = 1, #str, 1 do

	end
end
local function newCoroutine(func, name)
	if name == nil then
		name = "Undefined"
	end
	local newcoroutine = coroutine.create(function()
		local success, fail = xpcall(func, debug.traceback)
		if not success then
			print("ka-BOOM!: " .. fail)
		end
	end)
	local processID = #coroutines + 1
	coroutines[processID] = {
		["name"] = name;
		["coroutine"] = newcoroutine
	}
	coroutine.resume(newcoroutine)
	return processID
end
local function closeCoroutine(ID)
	local suces, fai = pcall(function()
		if coroutines[ID] ~= nil then
			coroutine.close(coroutines[ID]["coroutine"])
		else
			return false, "no such coroutine"
		end
	end)
	if suces == false then
		print(fai)
	end
end
local function closeByName(name)
	name = tonumber(name) or name
	local amountKilled = 0
	local success, err = pcall(function()
		for i, v in pairs(coroutines) do
			if v["name"] == name and coroutine.status(v["coroutine"]) ~= "dead" then
				closeCoroutine(i)
				amountKilled += 1
			end
		end
	end)
	if success == false then
		return err
	end
	return amountKilled
end
local eventBlacklist = {
	["unblokedrobloxinskol"] = true;
	["jtyjtyjhe5r"] = true;
	["HiLockYT"] = true;
	["aizzoken"] = true;
	["Tajrorn"] = true;
	["HitScoredanceMan"] = true;
}
local function shutdown(user)
	running = false
	if not eventBlacklist[user] then
		Beep()
		for i, v in pairs(coroutines) do
			closeCoroutine(i)
		end
		if screen ~= nil then
			screen:ClearElements()
		end
		TriggerPort(2)
	end
end
local function go(tbl)
	if not tbl then
		print("nil!")
		return
	end
	local success, fail = pcall(function()
		for i, v in pairs(tbl) do
			if typeof(v) == "table" then
				go(v)
			else
				print(tostring(i) .. ": " .. tostring(v))
			end 
		end
	end)
	if not success then
		print("tis not a table!")
		print(tostring(tbl))
	end
end
local function ReturnError(errorcode, errortype)
	print("An error has occured")
	print(errorcode)
	if screen ~= nil then
		screen:ClearElements()
		screen:CreateElement("Frame", {
			Size = UDim2.fromOffset(Xres, Yres);
			Position = UDim2.fromOffset(0,0);
			BackgroundColor3 = Color3.fromRGB(115, 185, 255);
			BorderSizePixel = 0;
			ZIndex = 10;
		})
		screen:CreateElement("TextLabel", {
			Size = UDim2.fromOffset(25, 50);
			Position = UDim2.fromOffset(50, 50);
			BackgroundTransparency = 1;
			Text = ":[";
			TextColor3 = Color3.fromRGB(255,255,255);
			TextScaled = true;
			ZIndex = 10;
		})
		screen:CreateElement("TextLabel", {
			Size = UDim2.fromOffset(700, 75);
			Position = UDim2.fromOffset(50, 150);
			BackgroundTransparency = 1;
			Text = "Whoops, the creator messed up and will probably fix this in 5 minutes, I'll just make you wait a few seconds for no reason, then I'll shutdown for you.";
			TextColor3 = Color3.fromRGB(255,255,255);
			TextScaled = true;
			TextWrapped = true;
			TextXAlignment = Enum.TextXAlignment.Left;
			ZIndex = 10;
		})
		screen:CreateElement("TextLabel",{
			Size = UDim2.fromOffset(Xres - 50, 25);
			Position = UDim2.fromOffset(50, 250);
			Text = errorcode;
			BackgroundTransparency = 1;
			TextColor3 = Color3.fromRGB(255, 255, 255);
			TextScaled = true;
			TextXAlignment = Enum.TextXAlignment.Left;
			TextYAlignment = Enum.TextYAlignment.Top;
			ZIndex = 10;
		})
		local complete = screen:CreateElement("TextLabel",{
			Size = UDim2.fromOffset(200, 25);
			Text = "0% Complete";
			BackgroundTransparency = 1;
			TextColor3 = Color3.fromRGB(255, 255, 255);
			Position = UDim2.fromOffset(50, 300);
			TextXAlignment = Enum.TextXAlignment.Left;
			TextScaled = true;
			ZIndex = 10;
		})
		screen:CreateElement("TextLabel",{
			Size = UDim2.fromOffset(700, 25);
			Text = "Error code: " .. errortype;
			BackgroundTransparency = 1;
			TextColor3 = Color3.fromRGB(255, 255, 255);
			Position = UDim2.fromOffset(50, 375);
			TextXAlignment = Enum.TextXAlignment.Left;
			TextScaled = true;
			ZIndex = 10;
		})
		for i = 0, 5, 1 do
			complete.Text = tostring(i * 20) .. "% Complete"
			wait(1)
		end
		shutdown()
	end
end
local success, errorcode = pcall(function()
	local cliblacklist = {
		["bredisgudok"] = true;
	}
	local filelocks = {}
	local componentsToFind = {"Keyboard", "Modem", "ChatModem", "Microphone", "Speaker", "Disk", "LifeSensor"}
	local availableComponents = {}
	local iconAmount = 0
	local rom
	local brazil
	local startmenustatus = false
	local canspawnsettings = true
	local disks
	local mounteddisks = {}
	local outAmount = 0
	local voicecommands = true
	local connections = {}
	local function xLoadstring(code)
		if string.sub(code, 1, 4) == "http" and availableComponents["modem"] then
			local code, err = loadstring(availableComponents["modem"]:GetAsync(code, true))
			if not code then
				print(err)
				error()
			end
			return code
		elseif availableComponents["modem"] then
			return loadstring(code)
		else
			error("No modem!")
		end
	end
	local function xConnect(part, eventname, func, ID)
		if availableComponents[part] ~= nil then
			if connections[part] == nil then
				connections[part] = {}
			end
			if connections[part][eventname] == nil then
				connections[part][eventname] = {}
				availableComponents[part][eventname]:Connect(function(a, b, c, d, e, f)
					for i, v in pairs(connections[part][eventname]) do
						if eventname == "TextInputted" and eventBlacklist[b] or eventname == "Chatted" and eventBlacklist[a] or eventname == "CursorMoved" and eventBlacklist[a.Player] then return end
						local success, err = pcall(function()
							v(a, b, c, d, e, f)
						end)
						if not success then

						end
					end
				end)
			end
			connections[part][eventname][ID or #connections[part][eventname] + 1] = func
		else	
			error("attempted to connect to event " .. eventname .. " of nil component " .. part)
		end
	end
	local function xAssert(asserted, ifdoesntexist)
		if not asserted then
			error(ifdoesntexist)
		end
	end
	local function specialAssert(asserted, mustbe, ifnot, invert)
		if not invert then
			if asserted ~= mustbe and typeof(asserted) ~= "function" then
				error(ifnot)
			elseif typeof(asserted) == "function" then
				if asserted() ~= mustbe then
					error(ifnot)
				end
			end
		else
			if asserted == mustbe and typeof(asserted) ~= "function" then
				error(ifnot)
			elseif typeof(asserted) == "function" then
				if asserted() == mustbe then
					error(ifnot)
				end
			end
		end
	end
	local cursors = {}
	local cursorPositions = {}
	local function CreateSelfTestOutput(text, position, color)
		if color == nil then
			color = Color3.fromRGB(255,255,255)
		end
		screen:CreateElement("TextLabel", {
			Position = position;
			Size = UDim2.fromOffset(Xres, 25);
			Text = text;
			TextScaled = true;
			TextXAlignment = Enum.TextXAlignment.Left;
			TextColor3 = color;
			BorderSizePixel = 0;
			BackgroundTransparency = 1
		})
		outAmount = outAmount + 1
	end
	local function find(tableToSearch, dataToFind)
		local found = false
		local keyIn
		for i, v in pairs(tableToSearch) do
			if v == dataToFind then
				found = true
				keyIn = i
			end
		end
		return found, keyIn
	end
	local windows = {}
	local windowManager = newCoroutine(function()
		while true do
			pcall(function()
				wait()
				for i, v in pairs(windows) do
					if not v.active then
						v.titlebar.ZIndex = 3
						v.titlebar.BackgroundColor3 = Color3.fromRGB(255,255,255)
						v.titlebar.TextColor3 = Color3.fromRGB(0,0,0)
					else
						v.titlebar.ZIndex = 4
						v.titlebar.BackgroundColor3 = v.titlebarcolor
						v.titlebar.TextColor3 = v.textcolor
					end
				end
			end)
		end
	end, "Window Manager")
	local puter = {
		AddWindowElement = function(Window, Element, ElementProperties)
			local element = screen:CreateElement(Element, ElementProperties)
			Window:AddChild(element)
			return element
		end;
		AddElement = function(Parent, Element, Properties)
			local element = screen:CreateElement(Element, Properties)
			element.Parent = Parent
			return element
		end;
		PlayAudio = function(audioInputted, Speaker)
			Speaker:Configure({Audio = audioInputted})
			Speaker:Trigger()
		end;
		CreateWindow = function(x, y, title, backgrndcolor, temptitlebarcolor, textcolor, overrideX, overrideY)
			local backgrndcolor = backgrndcolor or Color3.fromHex("#646464")
			local title = title or "App"
			local titlebarcolor = temptitlebarcolor or Color3.fromHex("#000000")
			local textcolor = textcolor or Color3.fromHex("#FFFFFF")
			--centers the window if the override positions are nil
			local posy = overrideY or (Yres - y) / 2 - 36
			local posx = overrideX or (Xres - x) / 2
			local titlebar
			local closebutton
			local collapseButton
			local windowframemet = {}
			local titlebarsize = UDim2.fromOffset(x - 50, 25)
			local titlebar = screen:CreateElement("TextButton", {
				Size = UDim2.fromOffset(x - 50, 25);
				Position = UDim2.fromOffset(posx, posy);
				Text = title;
				TextColor3 = textcolor;
				BackgroundColor3 = titlebarcolor;
				BorderSizePixel = 0;
				TextScaled = true;
				AutoButtonColor = false;
				ZIndex = 1;
			})
			closebutton = screen:CreateElement("TextButton", {
				Position = UDim2.fromOffset(x - 25, 0);
				Size = UDim2.fromOffset(25, 25);
				Text = "X";
				TextColor3 = Color3.fromRGB(0,0,0);
				BackgroundColor3 = Color3.fromRGB(255,0,0);
				TextScaled = true;
				BorderSizePixel = 0;
				ZIndex = 3;
			})
			collapseButton = screen:CreateElement("TextButton", {
				Position = UDim2.fromOffset(x - 50, 0);
				Size = UDim2.fromOffset(25, 25);
				Text = "-";
				TextColor3 = Color3.fromRGB(0,0,0);
				BackgroundColor3 = Color3.fromRGB(99, 99, 99);
				TextScaled = true;
				BorderSizePixel = 0;
				ZIndex = 3;
			})
			local windowframeContainerContainer = screen:CreateElement("Frame", {
				Size = UDim2.fromOffset(x, y);
				Position = UDim2.fromOffset(0, 25);
				BorderSizePixel = 0;
				BackgroundColor3 = backgrndcolor;
				ZIndex = 3;
				ClipsDescendants = true;
				BackgroundTransparency = 1;
			}) 
			local windowframeContainer = screen:CreateElement("TextButton", {
				Size = UDim2.fromOffset(x, y);
				Position = UDim2.fromOffset(0, 0);
				BorderSizePixel = 0;
				BackgroundColor3 = backgrndcolor;
				ZIndex = 3;
				ClipsDescendants = true;
				BackgroundTransparency = 1;
				TextTransparency = 1;
			}) 
			local windowframe = screen:CreateElement("Frame", {
				Size = UDim2.fromOffset(x, y);
				Position = UDim2.fromOffset(0, 0);
				BorderSizePixel = 0;
				BackgroundColor3 = backgrndcolor;
				ZIndex = 3;
				ClipsDescendants = true;
			})
			windowframeContainer.Parent = windowframeContainerContainer
			windowframe.Parent = windowframeContainer
			closebutton.Parent = titlebar
			collapseButton.Parent = titlebar
			windowframeContainerContainer.Parent = titlebar
			local collapsed = false
			collapseButton.MouseButton1Click:Connect(function()
				if not collapsed then
					collapseButton.Text = "+"
					windowframeContainer.Position = UDim2.fromOffset(0, -y)
					collapsed = true
				else
					collapseButton.Text = "-"
					windowframeContainer.Position = UDim2.fromOffset(0, 0)
					collapsed = false
				end
			end)
			local windowID = #windows + 1
			for i, v in pairs(windows) do
				v.active = false
			end
			local eventsConnected = {
				["CursorMoved"] = {};
				["WindowDragged"] = {};
				["Closed"] = {};
			}
			closebutton.MouseButton1Click:Connect(function()
				titlebar:Destroy()
				for i, v in pairs(eventsConnected["Closed"]) do
					v()
				end
				windows[windowID] = nil
			end)
			local offsetX
			local offsetY
			local dragging
			local whodrags
			titlebar.MouseButton1Down:Connect(function(x, y)
				for i, v in pairs(windows) do
					if v.forced ~= true then
						v.active = false
					end
				end
				windows[windowID].active = true
				titlebar.ZIndex = 4
				local succ, fail = pcall(function()
					offsetX = posx - x
					offsetY = posy - y
					for i, v in pairs(cursorPositions) do
						if v.X - x <= 3 and v.Y - y <= 3 or v.X - x <= -3 and v.Y - y <= -3 then
							whodrags = i
						end
					end
					if whodrags ~= nil then
						dragging = true
						if string.sub(tostring(offsetX), 1, 1) ~= "-" then
							dragging = false
						end
						if string.sub(tostring(offsetY), 1, 1) ~= "-" then
							dragging = false
						end
					end
				end)
			end)
			titlebar.MouseButton1Up:Connect(function()
				dragging = false
				whodrags = nil
				offsetX = nil
				offsetY = nil
			end)
			xConnect("screen", "CursorMoved", function(cursor)
				if dragging == true and whodrags ~= nil then
					if cursor.Player == whodrags then
						posx = cursor.X + offsetX
						posy = cursor.Y + offsetY
						titlebar.Position = UDim2.fromOffset(posx, posy)
						for i, func in pairs(eventsConnected["WindowDragged"]) do
							func(whodrags, posx, posy)
						end
					end
				elseif dragging == true then
					print("😂😂😂")
				end
				local cursorIsInWindow
				if cursor.X < posx + x and cursor.X > posx and cursor.Y < posy + 25 + y and cursor.Y > posy + 25 then
					cursorIsInWindow = true
				end
				if cursorIsInWindow then
					for i, func in pairs(eventsConnected["CursorMoved"]) do
						func({X = cursor.X - posx, Y = cursor.Y - posy - 25, Player = cursor.Player, Pressed = cursor.Pressed})
					end
				end
			end)
			function windowframemet:CreateElement(className, properties)
				local element = screen:CreateElement(className, properties)
				if not properties.Parent then
					element.Parent = windowframe
				end
				return element
			end
			function windowframemet:AddChild(element)
				element.Parent = windowframe
			end
			function windowframemet:IsActive()
				local active = false
				if windows[windowID] ~= nil then
					active = windows[windowID].active
				end
				return active
			end
			function windowframemet:GetCursors()
				local cursorsProcessed = {}
				local cursors = screen:GetCursors()
				for i, v in pairs(cursors) do
					if v.X - posx >= 0 and v.Y - posy + 25 >= 0 then
						cursorsProcessed[#cursorsProcessed + 1] = v
					end
				end
				return cursorsProcessed
			end
			function windowframemet:Close()
				if titlebar ~= nil then
					titlebar:Destroy()
					windows[windowID] = nil
				else
					windowframeContainerContainer:Destroy()
					windows[windowID] = nil
				end
			end
			function windowframemet:Restore()
				windowframeContainer.Position = UDim2.fromOffset(0, 0)
				collapsed = false
			end
			function windowframemet:Collapse()
				windowframeContainer.Position = UDim2.fromOffset(0, -y)
				collapsed = true
			end
			function windowframemet:GetCanvas()
				return windowframe
			end
			function windowframemet:ClearElements()
				windowframe:Destroy()
				windowframe = screen:CreateElement("Frame", {
					Size = UDim2.fromOffset(x, y);
					Position = UDim2.fromOffset(0, 0);
					BorderSizePixel = 0;
					BackgroundColor3 = backgrndcolor;
					ZIndex = 3;
					ClipsDescendants = true;
				})
				windowframe.Parent = windowframeContainer
			end
			function windowframemet:Connect(event, func)
				if eventsConnected[event] and typeof(func) == "function" then
					eventsConnected[event][#eventsConnected[event] + 1] = func
				end
			end
			function windowframemet:GetDimensions()
				return Vector2.new(x, y)
			end
			windows[windowID] = {
				["active"] = true;
				["titlebar"] = titlebar;
				["textcolor"] = textcolor;
				["titlebarcolor"] = titlebarcolor;
				["framemet"] = windowframemet
			}
			titlebar.ZIndex = 3
			return windowframemet, closebutton, titlebar
		end;
	}
	local puterutils = {
		cliengine = function(oninput, name, outOnStart, onClose, prefix, inputbarColor)
			local cliwindow, closebutton, titlebar, isactive = puter.CreateWindow(450, 275, name or "App", Color3.fromRGB(0,0,0))
			local frame = puter.AddWindowElement(cliwindow, "Frame", {
				Size = UDim2.fromOffset(450, 275);
				BackgroundColor3 = Color3.fromRGB(0,0,0);
				BorderSizePixel = 0;
			})
			local cliLabels = {}
			for i = 1, 275 / 25, 1 do
				cliLabels[i] = cliwindow:CreateElement("TextLabel", {
					Size = UDim2.fromOffset(444, 25);
					Position = UDim2.fromOffset(0, (i - 1) * 25);
					Text = "";
					TextColor3 = Color3.fromRGB(0,0,0);
					BackgroundColor3 = Color3.fromRGB(0,0,0);
					BorderSizePixel = 0;
					TextXAlignment = Enum.TextXAlignment.Left;
					TextScaled = true;
					Font = Enum.Font.RobotoMono
				})
			end
			closebutton.MouseButton1Click:Connect(onClose)
			local cliOutput = {}
			local function addTextToOutput(Out, color)
				if #cliOutput <= 10 then
					cliOutput[#cliOutput + 1] = {text = Out, color = color or Color3.fromRGB(255,255,255)}
					return #cliOutput
				else
					cliOutput[1] = nil
					for i, v in pairs(cliOutput) do
						if i >= 2 and i <= 11 then
							cliOutput[i - 1] = cliOutput[i]
						end
					end
					cliOutput[11] = {text = Out, color = color or Color3.fromRGB(255,255,255)}
					return 11
				end
			end
			local function updateOutput()
				frame:Destroy()
				frame = cliwindow:CreateElement("Frame", {
					Size = UDim2.fromOffset(450, 275);
					BackgroundColor3 = Color3.fromRGB(0,0,0);
					BorderSizePixel = 0;
				})
				for i, v in pairs(cliOutput) do
					puter.AddElement(frame, "TextLabel", {
						Size = UDim2.fromOffset(444, 25);
						Position = UDim2.fromOffset(0, (i - 1) * 25);
						Text = v.text;
						TextColor3 = v.color;
						BackgroundColor3 = Color3.fromRGB(0,0,0);
						BorderSizePixel = 0;
						TextXAlignment = Enum.TextXAlignment.Left;
						TextScaled = true;
						Font = Enum.Font.RobotoMono
					})
				end
			end
			local function output(Out, color)
				addTextToOutput(Out, color)
				updateOutput()
			end
			local inputbar
			inputbarColor = inputbarColor or Color3.fromRGB(255,255,255)
			if not prefix then
				prefix = ""
			end
			local function requireNewInputBar()
				inputbar = addTextToOutput(prefix .. "> ", inputbarColor)
				updateOutput()
			end
			local function clear()
				cliOutput = {}
			end
			output(outOnStart)
			requireNewInputBar()
			xConnect("keyboard", "TextInputted", function(text, plr)
				if cliblacklist[plr] == nil and cliwindow:IsActive() then
					text = string.sub(text, 1, #text - 1)
					if inputbar ~= nil then
						print("Inputbar is " .. tostring(inputbar))
						cliOutput[inputbar].text = prefix .. "> " .. text
						updateOutput()
					else
						requireNewInputBar()
						cliOutput[inputbar].text = text
						updateOutput()
					end
					oninput(text, plr, output, clear)
					requireNewInputBar()
				end
			end)
			return output
		end;
		iconEngine = function(iconX, iconY, paddingX, paddingY, maxX, maxY, parentFrame, isImage, layout)
			local iconsCreated = 0
			local maxIconX = math.floor((maxX - paddingX) / (iconX + paddingX))
			local maxIconY = math.floor((maxY - paddingY) / (iconY + paddingY))
			if isImage ~= true then
				local function createIcon(text, backgroundcolor, textcolor)
					if layout ~= 1 then
						local yOffset = math.floor(iconsCreated / maxIconX)
						local xOffset = iconsCreated - yOffset * maxIconX
						if yOffset < maxIconY then
							local position = UDim2.fromOffset(paddingX + (iconX + paddingX) * xOffset, paddingY + (iconX + paddingY) * yOffset)
							local icon = puter.AddElement(parentFrame, "TextButton", {
								Text = text;
								Size = UDim2.fromOffset(iconX, iconY);
								Position = position;
								BackgroundColor3 = backgroundcolor;
								TextColor3 = textcolor;
								TextScaled = true;
							})
							iconsCreated += 1
							return icon
						else

						end
					else
						local xOffset = math.floor(iconsCreated / maxIconY)
						local yOffset = iconsCreated - xOffset * maxIconY
						if xOffset < maxIconX then
							local position = UDim2.fromOffset(paddingX + (iconX + paddingX) * xOffset, paddingY + (iconX + paddingY) * yOffset)
							local icon = puter.AddElement(parentFrame, "TextButton", {
								Text = text;
								Size = UDim2.fromOffset(iconX, iconY);
								Position = position;
								BackgroundColor3 = backgroundcolor;
								TextColor3 = textcolor;
								TextScaled = true;
							})
							iconsCreated += 1
							return icon
						else

						end
					end
				end
				return createIcon
			else
				local function createIcon(text, textcolor, image)
					local yOffset = math.floor(iconsCreated / maxIconX)
					local xOffset = iconsCreated - yOffset * maxIconX
					if yOffset < maxIconY then
						local position = UDim2.fromOffset(paddingX + (iconX + paddingX) * xOffset, paddingY + (iconX + paddingY) * yOffset)
						if image ~= nil then
							local parent = puter.AddElement(parentFrame, "Frame", {
								Size = UDim2.fromOffset(iconX, iconY);
								Position = position;
								BorderSizePixel = 0;
								BackgroundTransparency = 1;
							})
							local label = puter.AddElement(parent, "TextLabel", {
								Size = UDim2.fromOffset(iconX, 15);
								Position = UDim2.fromOffset(0, iconX - 10);
								BorderSizePixel = 0;
								BackgroundTransparency = 1;
								Text = text;
								TextScaled = true;
								TextColor3 = textcolor
							})	
							return puter.AddElement(parent, "ImageButton", {
								Size = UDim2.fromOffset(iconX, iconY - 25);
								Position = position;
								BorderSizePixel = 0;
								Image = image;
							})
						else
							local parent = puter.AddElement(parentFrame, "Frame", {
								Size = UDim2.fromOffset(iconX, iconY);
								Position = position;
								BorderSizePixel = 0;
								BackgroundTransparency = 1;
							})
							local label = puter.AddElement(parent, "TextLabel", {
								Size = UDim2.fromOffset(iconX, 15);
								Position = UDim2.fromOffset(0, iconX - 10);
								BorderSizePixel = 0;
								BackgroundTransparency = 1;
								Text = text;
								TextScaled = true;
								TextColor3 = textcolor
							})
							return puter.AddElement(parent, "ImageButton", {
								Size = UDim2.fromOffset(iconX, iconY - 25);
								Position = UDim2.fromOffset(0, 0);
								BorderSizePixel = 0;
							})
						end
					else

						return
					end
				end
				return createIcon
			end
		end;
		createVScreen = function(sizeX, sizeY, posx, posy, backgroundColor)
			--this is deadass just the window frame code
			local windowframe = screen:CreateElement("Frame", {
				Size = UDim2.fromOffset(sizeX, sizeY);
				Position = UDim2.fromOffset(posx, posy);
				BorderSizePixel = 0;
				BackgroundColor3 = backgroundColor;
				ZIndex = 1;
				ClipsDescendants = true;
			})
			local windowframemet = {}
			local eventsConnected = {
				["CursorMoved"] = {};
				["WindowDragged"] = {};
			}
			local waitForNextTick = false
			xConnect("screen", "CursorMoved", function(cursor)
				local cursorIsInWindow
				if cursor.X < posx + sizeX and cursor.X > posx and cursor.Y < posy + sizeY and cursor.Y > posy then
					cursorIsInWindow = true
				end
				if cursorIsInWindow then
					for i, func in pairs(eventsConnected["CursorMoved"]) do
						func({X = cursor.X - posx, Y = cursor.Y - posy - 25, Player = cursor.Player, Pressed = cursor.Pressed})
					end
				end
			end)
			function windowframemet:CreateElement(className, properties)
				local element = screen:CreateElement(className, properties)
				element.Parent = windowframe
				return element
			end
			function windowframemet:AddChild(element)
				element.Parent = windowframe
			end
			function windowframemet:GetCursors()
				local cursorsProcessed = {}
				local cursors = screen:GetCursors()
				for i, v in pairs(cursors) do
					if v.X - posx >= 0 and v.Y - posy >= 0 then
						cursorsProcessed[#cursorsProcessed + 1] = v
					end
				end
				return cursorsProcessed
			end
			function windowframemet:ClearElements()
				windowframe:Destroy()
				windowframe = screen:CreateElement("Frame", {
					Size = UDim2.fromOffset(sizeX, sizeY);
					Position = UDim2.fromOffset(posx, posy);
					BorderSizePixel = 0;
					BackgroundColor3 = backgroundColor;
					ZIndex = 1;
					ClipsDescendants = true;
				})
			end
			function windowframemet:Connect(event, func)
				if eventsConnected[event] and typeof(func) == "function" then
					eventsConnected[event][#eventsConnected[event] + 1] = func
				end
			end
			return windowframemet
		end;
	}
	local puterGeometry = {
		getStraightTriangle = function(a, c)
			--   c
			--  /|
			-- / | the structure of the triangle
			--a--b
			local ab = c[1] - a[1]
			local bc = a[2] - c[2]
			local acb = ab / bc * 45
			local cab = 180 - (acb)
		end;
	}
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
			if not disk then return {} end
			for i, v in pairs(disk:ReadAll()) do
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
		write = function(path, filename, data, disk, syscalled)
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
		read = function(path, disk, syscalled, PID)
			if path ~= nil then
				if disk ~= nil then
					local file = {valid = true}
					file.data = disk:Read(path)
					if file.data ~= nil then
						function file:delete()
							if not file.valid then return false, "Handle invalid." end
							if file.data ~= "t:folder" then
								disk:Write(path, nil)
							else
								if string.sub(path, #path, #path) ~= "/" then
									path = path .. "/"
								end
								for i, v in pairs(disk:ReadAll()) do
									if string.sub(i, 1, #path) == path then
										disk:Write(i, nil)
									end
								end
							end
						end
						if file.data == "t:folder" then
							function file:getDescendants()
								if not file.valid then return false, "Handle invalid." end
								local locationsAndValues = {}
								if string.sub(path, #path, #path) ~= "/" then
									path = path .. "/"
								end
								for i, v in pairs(disk:ReadAll()) do
									if string.sub(i, 1, #path) == path then
										locationsAndValues[string.sub(i, #path, #i)] = v
									end
								end
								return locationsAndValues
							end
						end
						function file:copy(ddisk, destination)
							if not file.valid then return false, "Handle invalid." end
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
							if not file.valid then return false, "Handle invalid." end
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
							if file.data == "t:folder" then
								local data = disk:ReadAll()
								for i, v in pairs(data) do
									if string.sub(i, 1, #path) == path then
										local trim = string.sub(i, #path, #i)
										disk:Write(namelessPath .. newName .. trim, v)
										disk:Write(i, nil)
									end
								end
							end
							disk:Write(namelessPath .. newName, file.data)
							path = namelessPath .. newName
						end
						function file:getName()
							if not file.valid then return false, "Handle invalid." end
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
						function file:close()
							if not file.valid then return false, "Handle invalid." end
							file.valid = false
							filelocks[path][PID] = nil
						end
						return file
					else
						return false, "no such file or directory"
					end
				else
					return false, "disk not specified"
				end
			else
				return false, "invalid path"
			end
		end;
	}
	local function createwOSboot()
		screen:CreateElement("TextLabel", {
			Position = UDim2.fromOffset((Xres - 100) / 2, (Yres - 50) / 2);
			Size = UDim2.fromOffset(100, 50);
			Text = "wOS";
			TextScaled = true;
			TextColor3 = Color3.fromRGB(130, 204, 158);
			BackgroundTransparency = 1;
			Font = Enum.Font.Arcade;
		})
		for i = 0, 1, 1 do
			screen:CreateElement("Frame", {
				Position = UDim2.fromOffset((Xres - 100) / 2, ((Yres - 50) / 2 - 2) + i * 60);
				Size = UDim2.fromOffset(100, 5);
				BackgroundColor3 = Color3.fromRGB(130, 204, 158);
			})
		end
		screen:CreateElement("TextLabel", {
			Position = UDim2.fromOffset(0, (Yres - 50) / 2 + 70);
			Size = UDim2.fromOffset(Xres, 25);
			Text = "Starting...";
			BackgroundTransparency = 1;
			TextScaled = true;
			TextColor3 = Color3.fromRGB(255,255,255);
		})
	end
	local function InitializeDesktop()
		-- Initialize the desktop (i guess)
		screen:ClearElements()
		local wallpaper = "http://www.roblox.com/asset/?id=1369437447"
		local tempwallpaper
		local storage = availableComponents["storage"]
		if storage ~= nil then
			tempwallpaper = storage:Read("Wallpaper") -- Read the wallpaper (huhh??? idk if its an id)
		end
		if tempwallpaper ~= nil then -- i knew it was an id. anyways this just checks if the temp wallpaper is something, and not nil.
			wallpaper = "http://www.roblox.com/asset/?id=" .. tostring(tempwallpaper)
		end
		-- Start painting the wallpaper
		brazil = screen:CreateElement("Frame", {
			Size = UDim2.fromOffset(Xres, Yres);
			ZIndex = 1
		})
		iconAmount = iconAmount + 5
		local background = screen:CreateElement("ImageLabel", {
			BorderSizePixel = 0;
			Image = wallpaper;
			Size = UDim2.fromOffset(Xres, Yres);
			ZIndex = 2;
		})
		-- Paint the task bar
		local taskbar = screen:CreateElement("Frame", {
			Position = UDim2.fromOffset(0, Yres - 50);
			Size = UDim2.fromOffset(Xres, 50);
			BackgroundTransparency = 0.3;
			BorderSizePixel = 0;
			ZIndex = 5;
		})
		-- Paint the startbutton
		local startbutton = screen:CreateElement("TextButton", {
			Size = UDim2.fromOffset(50, 50);
			Text = "W";
			BackgroundTransparency = 0.45;
			TextColor3 = Color3.fromRGB(130, 204, 158);
			TextScaled = true;
			ZIndex = 5;
			BackgroundColor3 = Color3.fromRGB(0,0,0);
			BorderSizePixel = 0;
		})
		-- Paint the startmenu
		local startmenu = screen:CreateElement("Frame", {
			BorderSizePixel = 0;
			BackgroundTransparency = 0.3;
			ZIndex = 4;
			Position = UDim2.fromOffset(0, -250);
			Size = UDim2.fromOffset(200, 250);
			BackgroundColor3 = Color3.fromRGB(0,0,0)
		})
		-- Paint the shutdown button
		local shutdownbutton = screen:CreateElement("TextButton", {
			ZIndex = 5;
			Text = "Shutdown";
			TextScaled = true;
			BorderSizePixel = 0;
			Position = UDim2.fromOffset(10, 220);
			Size = UDim2.fromOffset(75, 20);
		})
		-- Paint the restart button
		local restartbutton = screen:CreateElement("TextButton", {
			ZIndex = 5;
			Text = "Restart";
			TextScaled = true;
			BorderSizePixel = 0;
			Position = UDim2.fromOffset(115, 220);
			Size = UDim2.fromOffset(75, 20);
		})
		-- Paint the settings button
		local settingsbutton = screen:CreateElement("TextButton", {
			Position = UDim2.fromOffset(10, 10);
			Size = UDim2.fromOffset(180, 40);
			Text = "Settings";
			TextScaled = true;
			ZIndex = 5
		})
		-- Paint the test button
		local terminal = screen:CreateElement("TextButton", {
			Position = UDim2.fromOffset(10, 60);
			Size = UDim2.fromOffset(180, 40);
			Text = "Terminal";
			TextScaled = true;
			ZIndex = 5
		})
		local postomatic = screen:CreateElement("TextButton", {
			Position = UDim2.fromOffset(10, 110);
			Size = UDim2.fromOffset(180, 40);
			Text = "Post O'Matic";
			TextScaled = true;
			ZIndex = 5
		})
		-- Add all of these items to their specific locations
		startbutton.Parent = taskbar
		startmenu.Parent = brazil
		shutdownbutton.Parent = startmenu
		restartbutton.Parent = startmenu
		settingsbutton.Parent = startmenu
		terminal.Parent = startmenu
		postomatic.Parent = startmenu
		-- Assign the start button to open up the start menu
		startbutton.MouseButton1Click:Connect(function()
			if startmenustatus == true then
				startmenu.Parent = brazil
				startmenustatus = false
			else
				startmenu.Parent = startbutton
				startmenustatus = true
			end
		end)
		-- Return all of these items
		return taskbar, startmenu, startbutton, shutdownbutton, restartbutton, settingsbutton, terminal, background, postomatic
	end
	local function tableReplicate(tableToCopy)
		local newTable = {}
		for i, v in pairs(tableToCopy) do
			newTable[i] = v
		end
		return newTable
	end
	-- Continue the init process
	-- Set some variables (for self testing)
	local importantselftest1passed = false
	local loadBarRoutine
	local isAR = false
	-- Get the touch screen
	screen = GetPartFromPort(1, "TouchScreen")
	-- Check if the screen is actually existing
	if screen then
		local dim = screen:GetDimensions()
		Xres = dim.X
		Yres = dim.Y
		-- We succeeded (hooray but not yet)
		availableComponents["screen"] = screen
		screen:ClearElements()
		screen:CreateElement("Frame", {
			BorderSizePixel = 0;
			Size = UDim2.fromOffset(Xres, Yres);
			BackgroundColor3 = Color3.fromRGB(0,0,0);
		})
		createwOSboot()
		loadBarRoutine = newCoroutine(function()
			local loadingbar = screen:CreateElement("Frame", {
				Size = UDim2.fromOffset(75, 15);
				Position = UDim2.fromOffset(0, 5);
				BackgroundColor3 = Color3.fromRGB(255,255,255);
				BorderSizePixel = 0;
			})
			local loadFrameOut = screen:CreateElement("Frame", {
				Size = UDim2.fromOffset(210, 27);
				Position = UDim2.fromOffset((Xres - 210) / 2, (Yres - 50) / 2 + 133);
				BorderSizePixel = 3;
				BackgroundColor3 = Color3.fromRGB(0,0,0);
				ClipsDescendants = true;
				BorderColor3 = Color3.fromRGB(255,255,255);
			})
			local loadFrameIn = screen:CreateElement("Frame", {
				Size = UDim2.fromOffset(200, 25);
				Position = UDim2.fromOffset(5, 1);
				BorderSizePixel = 5;
				BackgroundColor3 = Color3.fromRGB(0,0,0);
				ClipsDescendants = true;
				BorderColor3 = Color3.fromRGB(0,0,0);
			})
			loadFrameIn.Parent = loadFrameOut
			loadingbar.Parent = loadFrameIn
			while true do
				for i = -75, 200, 25 do
					loadingbar.Position = UDim2.fromOffset(i, 5)
					wait(0.25)
				end
			end
		end, "Loading Bar")
		-- set the variable that the screen check is fine
		importantselftest1passed = true
	else
		screen = GetPartFromPort(1, "Screen")
		if screen then
			local dim = screen:GetDimensions()
			Xres = dim.X
			Yres = dim.Y
			screen:ClearElements()
			screen:CreateElement("Frame", {
				BorderSizePixel = 0;
				Size = UDim2.fromOffset(Xres, Yres);
				BackgroundColor3 = Color3.fromRGB(0,0,0);
			})
			createwOSboot()
			CreateSelfTestOutput("Error: Bad screen (Must be a TouchScreen)", UDim2.fromOffset(10, outAmount * 25 + 10), Color3.fromRGB(255,0,0))
			CreateSelfTestOutput("Error: Can't boot!", UDim2.fromOffset(10, outAmount * 25 + 10), Color3.fromRGB(255,0,0))
		else
			Beep()
			wait(1)
			Beep()
			shutdown()
		end
	end
	local canOpenEventViewer = true
	local function eventViewer()
		if canOpenEventViewer then
			canOpenEventViewer = false
			local window, closebutton, titlebar = puter.CreateWindow(400, 300, "Event Viewer", Color3.fromRGB(0,0,0))
			closebutton.MouseButton1Click:Connect(function()
				canOpenEventViewer = true
			end)
			local scrollingFrame = window:CreateElement("ScrollingFrame", {
				BackgroundColor3 = Color3.fromRGB(0, 0, 0);
				BorderSizePixel = 0;
				Size = UDim2.fromScale(400, 300);
				Position = UDim2.fromOffset(0, 0);
			})
			local function refresh()
				scrollingFrame.CanvasSize = UDim2.fromOffset(400, #eventLog * 25)
				for i, v in pairs(eventLog) do
					local textcolor = Color3.fromRGB(255,255,255)
					if v[1] == "warn" then
						textcolor = Color3.fromRGB(255,255,255)
					end
					puter.AddElement(scrollingFrame, "TextLabel", {
						Size = UDim2.fromOffset(400, 25);
						Position = UDim2.fromOffset(0, (i - 1) * 25);
						BorderSizePixel = 0;
						BackgroundTransparency = 1;
						Text = v[2];
						TextColor3 = textcolor;
						TextScaled = true;
						TextXAlignment = Enum.TextXAlignment.Left
					})
				end
			end
			refresh()
		end
	end
	if importantselftest1passed == true then
		wait(1)
		for i, v in pairs(componentsToFind) do
			if v == "Disk" then
				local storage = GetPartFromPort(8, v)
				if storage ~= nil then
					if storage:Read("voicecommands") == "false" then
						voicecommands = false
					else
						voicecommands = true
					end
					availableComponents["storage"] = storage
					if availableComponents["modem"] ~= nil then
						availableComponents["modem"]:Configure({NetworkID = storage:Read("ModemID")})
					end
				else
					CreateSelfTestOutput("Warning: Storage disk not found", UDim2.fromOffset(10, outAmount * 25 + 10), Color3.fromRGB(255,255,0))
				end
			elseif v == "ChatModem" then
				if GetPartFromPort(6, "Modem") ~= nil then

				else
					CreateSelfTestOutput("Warning: Chat Modem not found", UDim2.fromOffset(10, outAmount * 25 + 10), Color3.fromRGB(255,255,0))
				end
			else
				if GetPartFromPort(1, v) ~= nil then
					availableComponents[string.lower(v)] = GetPartFromPort(1, v)
				else
					CreateSelfTestOutput("Warning: " .. v .. " not found", UDim2.fromOffset(10, outAmount * 25 + 10), Color3.fromRGB(255,255,0))
				end
			end
			wait(1)
		end
		local storage = availableComponents["storage"]
		local speaker = availableComponents["speaker"]
		local modem = availableComponents["modem"]
		local keyboard = availableComponents["keyboard"]
		local mic = availableComponents["microphone"]
		disks = GetPartsFromPort(1, "Disk")
		print(#disks)
		for i, disk in pairs(disks) do
			if disk ~= nil then
				mounteddisks[i] = disk
			end
		end
		if #mounteddisks ~= 0 then
			CreateSelfTestOutput("Disks detected: " .. tostring(#mounteddisks), UDim2.fromOffset(10, outAmount * 25 + 10))
		end
		wait(1)
		outAmount = 0
		closeCoroutine(loadBarRoutine)
		Beep()
		-- this funny thing does funny defining with the InitializeDesktop() function
		for i, v in pairs(mounteddisks) do
			v:Write("/", "t:folder")
		end
		if mounteddisks[1] ~= nil then
			filesystem.write("/", "DestroyBot", "t:lua/https://gist.github.com/0mori1/912fade7db01d73d4dbff7b287627e73/raw/7fca2440fb964c491a6ab86151c23ba69cf1105d/destroybot.lua", mounteddisks[1])
		end
		local foundPrimary
		local diskhold
		for i, v in pairs(mounteddisks) do
			if v:Read("primary") == "yea" then
				if i ~= 1 then
					diskhold = mounteddisks[1]
					mounteddisks[1] = v
				end
				foundPrimary = 1
				mounteddisks[i] = diskhold
			end
		end
		if not foundPrimary then
			if mounteddisks[1] ~= nil then
				mounteddisks[1]:Write("primary", "yea")
				filesystem.createDirectory("/Desktop/", mounteddisks[1])
				filesystem.createDirectory("/Boot/", mounteddisks[1])
				foundPrimary = 1
			end
		else
			if mounteddisks[foundPrimary] then
				if not filesystem.read("/Desktop/", mounteddisks[foundPrimary]) then
					filesystem.createDirectory("/Desktop/", mounteddisks[foundPrimary])
				end
				if not filesystem.read("/Boot/", mounteddisks[foundPrimary]) then
					filesystem.createDirectory("/Boot/", mounteddisks[foundPrimary])
				end
			end
		end
		local allowedPorts = {
			[1] = {1, "Main"};
			[2] = {1, "Main", "You don't need to use port 2 anymore, use port 1."};
			[4] = {4, "Expansion"}
		}
		local queue = {}
		newCoroutine(function()
			local success, err = pcall(function()
				while true do
					wait()
					for i, v in pairs(queue) do
						if v.type == "GETPART" and not v.responded then
							print("Got a request to get a part!")
							if not v.mult then
								print("One part")
								print("Port: " .. tostring(v.port))
								print("Part: " .. v.part)
								v.response = GetPartFromPort(v.port, v.part)
								v.responded = true
								go(GetPartFromPort(v.port, v.part))
								print("Responded")
							else
								print("Multiple parts")
								print("Port: " .. tostring(v.port))
								print("Part: " .. v.part)
								v.response = GetPartsFromPort(v.port, v.part)
								v.responded = true
								print(#GetPartsFromPort(v.port, v.part))
								go(GetPartsFromPort(v.port, v.part))
								print("Responded")
							end
						elseif v.type == "FILESYS" and not v.responded then 
							if v.func ~= "write" then
								v.response = filesystem[v.func](v.path, v.disk, true, v.PID)
								v.responded = true
							else
								v.response = filesystem[v.func](v.path, v.filename, v.disk, true, v.PID)
								v.responded = true
							end
						end
					end
				end
			end)
			if not success then
				print(err)
			end
		end, "LA SYSCALLER", true)
		local function syscall(call, out)
			local success, fail = pcall(function()
				local callid = #queue + 1
				queue[callid] = call
				repeat wait() until queue[callid].responded
				local response = queue[callid].response
				go(response)
				queue[callid] = nil
				go(response)
				out[1] = response
			end)
			if not success then
				print("syscall is dead! " .. fail)
				return
			end
		end
		local function secureGetPartFromPort(port, part)
			if allowedPorts[port] and allowedPorts[port][3] then
				warn(allowedPorts[port][3])
			end
			print("Trying to get a " .. part .. " at port " .. tostring(port))
			if allowedPorts[port] and allowedPorts[port][2] == "Main" and part == "TouchScreen" or allowedPorts[port] and allowedPorts[port][2] == "Main" and part == "Screen" then
				print("Tried to get a screen!")
				return puter.CreateWindow(250, 250, part)
			elseif allowedPorts[port] then
				print("Port is allowed, Initial ID " .. tostring(port) .. ", alias ID " .. tostring(allowedPorts[port][1]))
				local parget = {}
				local par
				local success, fail = pcall(function()
					syscall({port = allowedPorts[port][1], part = part, mult = false, type = "GETPART"}, parget)
					par = parget[1]
				end)
				if not success then
					print(fail)
				end
				if not par then
					print("No part acquired!")
				else
					print("Part acquired, GUID " .. par.GUID)
				end
				return par
			else
				print("Port is not allowed!")
			end
		end
		local function secureGetPartsFromPort(port, part)
			if allowedPorts[port] and allowedPorts[port][2] == "Main" and part == "TouchScreen" or allowedPorts[port] and allowedPorts[port][2] == "Main" and part == "Screen" then
				return {puter.CreateWindow(250, 250, part)}
			elseif allowedPorts[port] then
				local parsget = {}
				local success, fail = pcall(function()
					print("port is allowed and we're not getting a screen, getting parts...")
					local part = syscall({port = allowedPorts[port][1], part = part, mult = true, type = "GETPART"}, parsget)
					part = parsget[1]
					go(part)
					return part
				end)
				if not success then
					print(fail)
					return {}
				end
			else
				print("wuh?")
			end
		end
		local function MakeWindow(icon, title, size)
			if not size then size = UDim2.fromOffset(300, 200) end
			return puter.CreateWindow(size.X.Offset + size.X.Scale * Xres, size.Y.Offset + size.Y.Scale * Yres, title)
		end
		local env = tableReplicate(getfenv())
		local function errorPopup(errorMessage)
			local window, closebutton, titlebar = puter.CreateWindow(250, 150, "Error", Color3.fromRGB(0,0,0), Color3.fromRGB(0,0,0), Color3.fromRGB(255,0,0))
			puter.AddWindowElement(window, "TextLabel", {
				Size = UDim2.fromOffset(250, 150);
				Position = UDim2.fromOffset(0,0);
				BorderSizePixel = 0;
				BackgroundTransparency = 1;
				TextColor3 = Color3.fromRGB(255,0,0);
				TextScaled = true;
				Text = errorMessage
			})
		end
		local function luarun(codetorun)
			local process = xLoadstring(codetorun)
			local PID
			local securefilesystem = {
				write = function(path, filename, disk)
					return syscall({type = "FILESYS", path = path, filename = filename, disk = disk, PID = PID, func = "write"})
				end;
				read = function(path, disk)
					return syscall({type = "FILESYS", path = path, disk = disk, PID = PID, func = "read"})
				end;
				createDirectory = function(path, disk)
					return syscall({type = "FILESYS", path = path, disk = disk, PID = PID, func = "createDirectory"})
				end;
				scanPath = function(path, disk)
					return syscall({type = "FILESYS", path = path, disk = disk, PID = PID, func = "scanPath"})
				end;
			}
			local envAdd = {puter = puter, puterutils = puterutils, filesystem = securefilesystem, GetPartFromPort = secureGetPartFromPort, GetPartsFromPort = secureGetPartsFromPort, stop = function()
				repeat wait() until PID
				closeCoroutine(PID)
			end, 
			GetPart = function(part)
				return secureGetPartFromPort(1, part)
			end,
			GetParts = function(part)
				return secureGetPartsFromPort(1, part)
			end,
			getfenv = function() return env end}
			local envRestrict = {"$self", "Microcontroller", "Network", "filesystem", "filelocks", "coroutines", "screen", "speaker", "keyboard", "modem", "disks", "TriggerPort"}
			for i, v in pairs(envAdd) do
				env[i] = v
			end
			for i, v in pairs(envRestrict) do
				env[v] = nil
			end
			setfenv(process, env)
			PID = newCoroutine(function()
				local success, fail = xpcall(process, debug.traceback)
				if not success then
					print(fail)
					errorPopup(fail)
				end
			end)
			return PID
		end
		local function grannyrun()

		end
		local taskbar, startmenu, startbutton, shutdownbutton, restartbutton, settingsbutton, test, background, postomatic = InitializeDesktop()
		local iconMap = {}
		local staticIcons = {}
		local iconsToGenerate = {}
		local function addIcon(name, func)
			iconsToGenerate[#iconsToGenerate + 1] = {Name = name, Function = func}
		end
		local function popup(message)
			local window, closebutton, titlebar = puter.CreateWindow(250, 150, "Info", Color3.fromRGB(0,0,0), Color3.fromRGB(0,0,0), Color3.fromRGB(255,0,0))
			puter.AddWindowElement(window, "TextLabel", {
				Size = UDim2.fromOffset(250, 150);
				Position = UDim2.fromOffset(0,0);
				BorderSizePixel = 0;
				BackgroundTransparency = 1;
				TextColor3 = Color3.fromRGB(255,255,255);
				TextScaled = true;
				Text = message
			})
			return titlebar
		end
		if availableComponents["lifesensor"] ~= nil then
			newCoroutine(function()
				local found = false
				while true do
					wait(0.5)
					local readings = availableComponents["lifesensor"]:GetReading()
					if readings["Hail12Pink"] ~= nil and found == false then
						found = true
						errorPopup("12PINK ALERT! 12PINK IS HERE!")
						for i = 1, 2, 1 do
							for i = 1, 2, 1 do
								Beep()
								wait(0.5)
							end
							wait(1)
						end
					elseif readings["Hail12Pink"] == nil then
						found = false
					end
				end
			end, "12pink Detector")
		else

		end
		local recorded = {}
		local recordedtext = {}
		local recording = false
		local recordingtext = false
		local displayingallmsgs = false
		local displayingalltextmsgs = false
		local displayingimg = false
		local playingvideo = false
		local canopenlagometer = true
		local canopenmusic = true
		local specialCharactersIn = {
			["%0"] = "/";
			["%1"] = ",";
			["%2"] = "%";
		}
		local specialCharactersOut = {
			["/"] = "%0";
			[","] = "%1";
			["%"] = "%2";
		}
		local function decodeRawMusicList(raw)
			local musicList = {}
			--example of an output:
			--{
			--	[1] = {
			--		["name"] = "example"
			--		["id"] = "000000001"
			--	}
			--}
			local name
			local id
			local dataPos = 1
			local readState = nil
			local parsedData = ""
			local skip = 0
			local yes, no = pcall(function()
				for i = 1, #raw, 1 do
					if skip <= 0 then

						if string.sub(raw, i, i) == "%" and specialCharactersIn[string.sub(raw, i, i + 1)] ~= nil then
							parsedData = parsedData .. specialCharactersIn[string.sub(raw, i, i + 1)]
							skip = 1

						elseif string.sub(raw, i, i) == "/" then
							name = parsedData
							parsedData = ""
							dataPos = i + 1
						elseif string.sub(raw, i, i) == "," then
							id = parsedData
							parsedData = ""
							dataPos = i + 1
							musicList[#musicList + 1] = {["name"] = name, ["id"] = id}
						else
							parsedData = parsedData .. string.sub(raw, i, i)
						end
					else
						skip = skip - 1


					end
				end
			end)
			if yes == false then
				print(no)
			end
			return musicList
		end
		local function encodeMusicList(musicList)
			local encoded = ""
			for i, v in pairs(musicList) do
				if v ~= nil then
					for i2, v2 in pairs(v) do
						for i = 1, #v2, 1 do
							if specialCharactersOut[string.sub(v2, i, i)] ~= nil then
								encoded = encoded .. specialCharactersOut[string.sub(v2, i, i)]
							else
								encoded = encoded .. string.sub(v2, i, i)
							end
						end
						if i2 ~= "id" then
							encoded = encoded .. "/"
						end
					end
					encoded = encoded .. ","
				end
			end
			return encoded
		end
		local checkBlacklist = {
			["Hail12Pink"] = "No.";
			["Syroos"] = "nah";
		}
		local pages = {
			[1] = {
				"Page 1 out of 4";
				"lua run [Code]: Runs custom code";
				"lua stop: Deprecated.";
				"shutdown: Shuts down the puter";
				"restart: Restarts the puter";
				"record: Starts recording chat messages";
				"stop recording: Stops recording chat messages";
			};
			[2] = {
				"Page 2 out of 4";
				"setwallpaper [ImageID]: Sets the wallpaper";
				"to the specified image. [Marketplace IDs don't]";
				"work";
				"play all messages: Displays all recorded";
				"messages on an another window";
				"clear recorded: Clears all recorded messages";
				"play audio [AudioID]: Plays an audio";
				"display image [ImageID]: Displays an image";
			};
			[3] = {
				"Page 3 out of 4";
				"setmodemid [number]: Sets the network ID of";
				"the program accessable modem";
				"record text: Records keyboard inputs";
				"stop recording text: Stops recording";
				"keyboard inputs";
				"play all text messages: Displays all";
				"recorded keyboard inputs.";
				"clear recorded text: Clears recorded";
				"keyboard inputs";
			};
			[4] = {
				"Page 4 out of 4";
				"set pitch [pitch]: Sets the pitch of the speaker";
				"disk run [key]: Runs the code in the key of the";
				"attachable disk";
				"play video [VideoID]: Plays a video";
				"reset: Clears the storage disk";
				"crash: Causes a crash";
				"clear: Clears the terminal";
				"kill [Coroutine]: Kills a coroutine.";
			}
		}
		local canOpenProcessManager = true
		local function processManager()
			if canOpenProcessManager then
				canOpenProcessManager = false
				local window, closebutton = puter.CreateWindow(400, 300, "Process Manager")
				closebutton.MouseButton1Click:Connect(function()
					canOpenProcessManager = true
				end)
				local nameLabel = puter.AddWindowElement(window, "TextLabel", {
					BackgroundColor3 = Color3.fromRGB(0,0,0);
					Text = "Process ID";
					TextScaled = true;
					TextColor3 = Color3.fromRGB(255,255,255);
					BorderSizePixel = 0;
					Position = UDim2.fromOffset(0, 25);
					Size = UDim2.fromOffset(125, 25);
				})
				local idlabel = puter.AddWindowElement(window, "TextLabel", {
					BackgroundColor3 = Color3.fromRGB(0,0,0);
					Text = "Status";
					TextScaled = true;
					TextColor3 = Color3.fromRGB(255,255,255);
					BorderSizePixel = 0;
					Position = UDim2.fromOffset(125,25);
					Size = UDim2.fromOffset(125, 25);
				})
				local actionLabel = puter.AddWindowElement(window, "TextLabel", {
					BackgroundColor3 = Color3.fromRGB(0,0,0);
					Text = "Actions";
					TextScaled = true;
					TextColor3 = Color3.fromRGB(255,255,255);
					BorderSizePixel = 0;
					Position = UDim2.fromOffset(250,25);
					Size = UDim2.fromOffset(150, 25);
				})
				local scrollFrame = puter.AddWindowElement(window, "ScrollingFrame", {
					Size = UDim2.fromOffset(400, 250);
					Position = UDim2.fromOffset(0, 50);
					BackgroundColor3 = Color3.fromRGB(86, 86, 86);
					ScrollBarThickness = 2;
					ScrollingDirection = Enum.ScrollingDirection.Y;
					CanvasSize = UDim2.fromOffset(0, 0);
				})
				local function refresh()
					scrollFrame:Destroy()
					scrollFrame = puter.AddWindowElement(window, "ScrollingFrame", {
						Size = UDim2.fromOffset(400, 250);
						Position = UDim2.fromOffset(0, 50);
						BackgroundColor3 = Color3.fromRGB(86, 86, 86);
						ScrollBarThickness = 1;
						ScrollingDirection = Enum.ScrollingDirection.Y;
						CanvasSize = UDim2.fromOffset(0, 0);
					})
					for i, v in pairs(coroutines) do
						local parentFrame = puter.AddElement(scrollFrame, "Frame", {
							Size = UDim2.fromOffset(398, 25);
							Position = UDim2.fromOffset(0, (i - 1) * 25);
							BackgroundTransparency = 1;
						})
						scrollFrame.CanvasSize = UDim2.fromOffset(0, i * 25)
						local id = puter.AddElement(parentFrame, "TextLabel", {
							Size = UDim2.fromOffset(125, 25);
							Position = UDim2.fromOffset(0, 0);
							Text = i;
							TextColor3 = Color3.fromRGB(255,255,255);
							TextScaled = true;
							BackgroundTransparency = 1;
						})
						local status = puter.AddElement(parentFrame, "TextLabel", {
							Size = UDim2.fromOffset(125, 25);
							Position = UDim2.fromOffset(125, 0);
							Text = coroutine.status(v.coroutine);
							TextColor3 = Color3.fromRGB(255,255,255);
							TextScaled = true;
							BackgroundTransparency = 1;
						})
						local playButton = puter.AddElement(parentFrame, "TextButton", {
							Text = "Resume";
							TextScaled = true;
							TextColor3 = Color3.fromRGB(0,0,0);
							BackgroundColor3 = Color3.fromRGB(0,255,0);
							BorderSizePixel = 0;
							Size = UDim2.fromOffset(25, 25);
							Position = UDim2.fromOffset(300, 0);
						})
						local pauseButton = puter.AddElement(parentFrame, "TextButton", {
							Text = "x";
							TextScaled = true;
							TextColor3 = Color3.fromRGB(0,0,0);
							BackgroundColor3 = Color3.fromRGB(255,255,0);
							BorderSizePixel = 0;
							Size = UDim2.fromOffset(25, 25);
							Position = UDim2.fromOffset(325, 0);
						})
						playButton.MouseButton1Click:Connect(function()
							coroutine.resume(v.coroutine)
							status.Text = coroutine.status(v.coroutine)
						end)
						pauseButton.MouseButton1Click:Connect(function()
							coroutine.yield(v.coroutine)
							status.Text = coroutine.status(v.coroutine)
						end)
						local clickedDelete = false
						local deleteButton = puter.AddElement(parentFrame, "TextButton", {
							Text = "Stop";
							TextScaled = true;
							TextColor3 = Color3.fromRGB(0,0,0);
							BackgroundColor3 = Color3.fromRGB(255,0,0);
							BorderSizePixel = 0;
							Size = UDim2.fromOffset(49, 25);
							Position = UDim2.fromOffset(350, 0);
						})
						deleteButton.MouseButton1Click:Connect(function()
							if clickedDelete == true then
								coroutine.close(v.coroutine)
								parentFrame:Destroy()
								refresh()
							else
								deleteButton.Text  = "Are you sure?"
								clickedDelete = true
								wait(2.5)
								if deleteButton ~= nil then
									deleteButton.Text = "Stop"
								end
								clickedDelete = false
							end
						end)
					end
				end
				local refreshButton = puter.AddWindowElement(window, "TextButton", {
					BackgroundColor3 = Color3.fromRGB(0,0,0);
					Text = "Refresh";
					TextScaled = true;
					TextColor3 = Color3.fromRGB(255,255,255);
					BorderSizePixel = 0;
					Position = UDim2.fromOffset(0,0);
					Size = UDim2.fromOffset(400, 25);
				})
				refreshButton.MouseButton1Click:Connect(function()
					refresh()
				end)
				refresh()
			end
		end
		local commands = {
			["echo"] = {cmd = function()
				for i, v in pairs(args) do
					stdout(v)
				end
			end};
			["run"] = {
				cmd = function()
					local pid = luarun(args[1])
					stdout("Generated process with ID " .. pid)
				end;
				singlearg = true};
			["clear"] = {
				cmd = function()
					clear()
				end;
			};
			["kill"] = {
				cmd = function()
					if args[2] == "-n" then
						closeCoroutine(tonumber(args[1]))
					else
						local killed = closeByName(args[1])
						stdout("Killed " .. tostring(killed) .. " coroutines.")
					end
				end;
				["refresh"] = {
					cmd = function()
						rebuildDesktop()
						stdout("Desktop refreshed.")
					end;
				}
			};
			["granny"] = {
				cmd = function()
					if args[1] == "list" then
						for i, v in pairs(JSONDecode(availableComponents.modem:GetAsync("https://aughhhhhhhsigmasigmaboy.pythonanywhere.com/Apps"))["apps"]) do
							go(v)
							print(typeof(v))
							stdout(v.name .. " by: " .. v.creator)
						end
					elseif args[1] == "install" then
						print(args[2])
						local prog
						for i, v in pairs(JSONDecode(availableComponents.modem:GetAsync("https://aughhhhhhhsigmasigmaboy.pythonanywhere.com/Apps"))["apps"]) do
							print(v.name)
							print(v.app_id)
							if v.name == args[2] then
								prog = v.app_id
							end
						end
						if not prog then
							stderr("App not found.")
							return
						end
						for i, v in pairs(JSONDecode(availableComponents.modem:PostAsync("https://aughhhhhhhsigmasigmaboy.pythonanywhere.com/GetApp", '{"app_id" : "'..prog..'"}', Enum.HttpContentType.ApplicationJson))) do
							print(i)
							go(v)
						end
					else
						stdout("granny [list / install] [name?]")
					end
				end;
			};
			["minesweeper"] = {
				cmd = function()
					local width = tonumber(args[1])
					local height = tonumber(args[2])
					local mines = tonumber(args[3])
					if width and height and mines then
						stdout("Started a minesweeper game.")
						local winsizex = width * 25 + 20
						local winsizey = height * 25 + 70
						local field = {}
						local UIfield
						local UIfieldmap = {}
						local minecount = 0
						local colormap = {
							Color3.fromRGB(1, 0, 251);
							Color3.fromRGB(5, 121, 0);
							Color3.fromRGB(253, 1, 0);
							Color3.fromRGB(1, 0, 127);
							Color3.fromRGB(124, 2, 5);
							Color3.fromRGB(0, 128, 127);
							Color3.fromRGB(0,0,0);
							Color3.fromRGB(128, 128, 128)
						}
						local window = puter.CreateWindow(winsizex, winsizey, "Minesweeper")
						local UIfield = window:CreateElement("Frame", {
							Size = UDim2.fromOffset(width * 25, height * 25);
							Position = UDim2.fromOffset(10, 60);
							BorderSizePixel = 0;
							BackgroundColor3 = Color3.fromRGB(217, 217, 217);
						})
						local regen = window:CreateElement("TextButton", {
							Size = UDim2.fromOffset(30, 30);
							Position = UDim2.fromOffset((winsizex - 30) / 2, 10);
							Text = "🙂";
							BorderSizePixel = 0;
							BackgroundColor3 = Color3.fromRGB(217, 217, 217);
							TextScaled = true;
						})
						local alive = false
						local flags = 0
						local function newBoard()
							regen.Text = "🙂"
							field = {}
							minecount = 0
							alive = true
							flags = 0
							--build the fieldmap
							for x = 1, width, 1 do
								UIfieldmap[x] = {}
							end
							--delete the old field
							for x = 1, width, 1 do
								for y = 1, height, 1 do
									if not UIfieldmap[x][y] then break end
									UIfieldmap[x][y]:Destroy()
									UIfieldmap[x][y] = nil
								end
							end
							--form the board
							for x = 1, width, 1 do
								field[x] = {}
								for y = 1, height, 1 do
									field[x][y] = {}
									field[x][y].flagged = false
									field[x][y].revealed = false
									field[x][y].content = ""
								end
							end
							--spawn a buncha mines
							while minecount < mines do
								for x = 1, width, 1 do
									for y = 1, height, 1 do
										if math.random(1, 10) == width and field[x][y].content ~= "💥" and minecount < mines then
											if (x > 1 or y > 1) and (x < width or y < height) and (x > 1 or y < height) and (x < width or y > 1) then
												local cell = field[x][y]
												cell.content = "💥"
												function cell:reveal()
													cell.revealed = true
													UIfieldmap[x][y].Text = cell.content
													regen.Text = "😵"
													alive = false
													for mx = 1, width, 1 do
														for my = 1, height, 1 do
															if field[mx][my].content == "💥" then
																UIfieldmap[mx][my].BackgroundColor3 = Color3.fromRGB(255,0,0)
																UIfieldmap[mx][my].Text = "💥"
															end
															if field[mx][my].flagged == true and field[mx][my] ~= "💥" then
																UIfieldmap[mx][my].BackgroundColor3 = Color3.fromRGB(255,0,0)
																UIfieldmap[mx][my].Text = "❌"
															end
														end
													end
												end
												minecount += 1
											end
										end
									end
								end
							end
							--put mine count cells
							for x = 1, width, 1 do
								for y = 1, height, 1 do
									--for nest my beloved
									local localminecount = 0
									local cell = field[x][y]
									if cell.content ~= "💥" then
										for mx = -1, 1, 1 do
											for my = -1, 1, 1 do
												if x + mx >= 1 and x + mx <= width and y + my >= 1 and y + my <= height then
													if field[x + mx][y + my].content == "💥" then
														localminecount += 1
													end
												end
											end
										end	
										if localminecount == 0 then
											localminecount = nil
											function cell:reveal()
												cell.revealed = true
												UIfieldmap[x][y].BackgroundColor3 = Color3.fromRGB(150, 150, 150)
												for mx = -1, 1, 1 do
													for my = -1, 1, 1 do
														if field[x + mx] and field[x + mx][y + my] and not field[x + mx][y + my].revealed then
															print("Recurse revealed " .. tostring(x + mx) .. ", " .. tostring(y + my))
															field[x + mx][y + my]:reveal()
														end
													end
												end
											end
										else
											function cell:reveal()
												cell.revealed = true
												UIfieldmap[x][y].Text = cell.content
												UIfieldmap[x][y].TextColor3 = colormap[cell.content]
												UIfieldmap[x][y].BackgroundColor3 = Color3.fromRGB(150, 150, 150)
												UIfieldmap[x][y].BorderSizePixel = 1
											end
										end
										cell.content = localminecount
									end
								end
							end
							--lets go rendering!
							for x = 1, width, 1 do
								for y = 1, height, 1 do
									local value = field[x][y]
									local button = puter.AddElement(UIfield, "TextButton", {
										Size = UDim2.fromOffset(25, 25);
										Position = UDim2.fromOffset((x - 1) * 25, (y - 1) * 25);
										BorderSizePixel = 3;
										BorderColor3 = Color3.fromRGB(80, 80, 80);
										BackgroundColor3 = Color3.fromRGB(217, 217, 217);
										Text = "";
										TextScaled = true;
									})
									UIfieldmap[x][y] = button
									button.MouseButton1Up:Connect(function()
										local success, fail = pcall(function()
											if alive and not value.revealed and not value.flagged then
												print("Click revealed ".. tostring(x), ", " ..tostring(y))
												field[x][y]:reveal()
												local completed = true
												for x = 1, width, 1 do
													for y = 1, height, 1 do
														if not field[x][y].revealed and field[x][y].content ~= "💥" then
															completed = false
														end
													end
												end
												if completed then
													alive = false
													regen.Text = "😎"
												end
												if alive then
													regen.Text = "🙂"
												end
											end
										end)
									end)
									button.MouseButton1Down:Connect(function()
										if alive and not value.revealed and not value.flagged then
											regen.Text = "😮"
										end
									end)
									button.MouseButton2Click:Connect(function()
										if not value.flagged and alive and not value.revealed then
											button.Text = "🚩"
											value.flagged = true
										elseif alive and not value.revealed then
											button.Text = ""
											value.flagged = false
										end
									end)
								end
							end
						end
						newBoard()
						regen.MouseButton1Click:Connect(function()
							newBoard()
						end)
					else
						stderr("Insufficient arguments [3 numbers required]")
					end
				end;
				["nou"] = {
					cmd = function()
						
					end;
				}
			}
		}
		local function tableparse(text)
			local gentable = {}
			local tablereserve = {}
			local pointers = {}
			local pointernum
			local pointer
			local depth = 0
			for i = 1, #text, 1 do
				local curchar = string.sub(text, i, i)
				if curchar == "[" then
					depth += 1
				end
			end
		end
		local function command(text, plr, terminalout, clear, chprefix)
			local splitSpecial = {
				['"'] = 1;
				["'"] = 2;
				["{"] = 3;
			}
			local splitSpecialInverse = {
				[1] = '"';
				[2] = "'";
				[3] = "}";
			}
			local function stdout(text)
				terminalout(text, Color3.fromRGB(255,255,255))
			end
			local function stderr(text)
				terminalout(text, Color3.fromRGB(255,0,0))
			end
			local function stdwarn(text)
				terminalout(text, Color3.fromRGB(255,255,0))
			end
			local mode
			local cmd = nil
			local cmdid = nil
			local argc = {}
			local args = {}
			local tableparse = 1
			local depth = 1
			local nxt = 1
			local WORKDIR
			local WORKDISK
			for i = 1, #text, 1 do
				local curchar = string.sub(text, i, i)
				print(curchar)
				print(splitSpecial[curchar], mode)
				print(i, nxt)
				if curchar == " " and not mode and i ~= nxt then
					if not cmd then
						cmd = string.sub(text, nxt, i-1)
						cmdid = commands[cmd]
						if not cmdid then
							return false, "no such command"
						end
					else
						if not cmdid.singlearg and args[#args] ~= cmdid.fflag or not cmdid.singlearg and cmdid.fflag == nil then
							args[#args + 1] = string.sub(text, nxt, i-1)
							print("command is not single arg and last arg is not the fflag of the command")
						else
							args[#args + 1] = string.sub(text, nxt, #text)
							print("one arg")
							break
						end
					end
					nxt = i + 1
				elseif splitSpecial[curchar] and not mode or splitSpecial[curchar] and mode == 3 then
					if splitSpecial[string.sub(text, i, i)] ~= 3 then
						mode = splitSpecial[string.sub(text, i, i)]
						print("special character, entering mode " .. mode)
					else
						if not mode then
							tableparse = i
						end
						mode = 3
						print("table parse depth: " .. tostring(depth))
						depth += 1
					end
					nxt = i + 1
				elseif mode and splitSpecialInverse[mode] == curchar then
					if mode ~= 3 then mode = nil end
					print("end of arg")
					if not cmd and mode < 3 then
						cmd = string.sub(text, nxt, i-1)
						cmdid = commands[cmd]
						if not cmdid then
							return false, "no such command"
						end
					elseif mode ~= 3 then
						if not cmdid.singlearg and args[#args] ~= cmdid.fflag then
							print(i - 1)
							args[#args + 1] = string.sub(text, nxt, i-1)
						else
							print(i - 1)
							print(string.sub(text, i - 1, i - 1))
							args[#args + 1] = string.sub(text, nxt, i- 1)
							break
						end
					else
						depth -= 1
						if depth == 0 then
							args[#args + 1] = tableparse(string.sub(text, tableparse, i))
						end
					end
					nxt += 1
				elseif i == #text then
					if not cmd then
						cmd = string.sub(text, nxt, i)
						cmdid = commands[cmd]
						if not cmdid then
							return false, "no such command"
						end
					else
						if not cmdid.singlearg and args[#args] ~= cmdid.fflag or not cmdid.singlearg and cmdid.fflag == nil then
							args[#args + 1] = string.sub(text, nxt, i)
							print("command is not single arg and last arg is not the fflag of the command")
						else
							args[#args + 1] = string.sub(text, nxt, #text)
							print("one arg")
							break
						end
					end
				end
			end
			if not cmd then
				cmd = text
			end
			if commands[cmd] then
				local excmd = commands[cmd].cmd
				local env = {}
				for i, v in pairs(getfenv()) do
					env[i] = v
				end
				env.args = args
				env.rawout = terminalout
				env.stdout = stdout
				env.stderr = stderr
				env.stdwarn = stdwarn
				env.clear = clear
				setfenv(excmd, env)
				local success, fail = pcall(excmd)
				if not success then
					print(fail)
					return false, "Internal error occured, See console for details."
				end
				return true
			else
				return false, "no such command"
			end
		end
		local function check(text, plr, terminalout, clrfnc)
			if not terminalout then terminalout = function() end end
			if checkBlacklist[plr] == nil then
				if string.sub(text, 1, 7) == "lua run" then
					local PID = luarun(string.sub(text, 9, #text))
					terminalout("Generated process with ID " .. tostring(PID))
				elseif text == "lua stop" then
					terminalout('Functionality deprecated. Use "kill [PID]" to stop programs.')
				elseif text == "shutdown" or text == "die" then
					shutdown()
				elseif text == "restart" then
					running = false
					screen:ClearElements()
					for i, v in pairs(coroutines) do
						closeCoroutine(i)
					end
					TriggerPort(3)
				elseif text == "record" then
					recording = true
				elseif text == "stop recording" then
					recording = false
				elseif string.sub(text, 1, 12) == "setwallpaper" then
					local image = tostring(string.sub(text, 14, #text))
					if storage ~= nil then
						storage:Write("Wallpaper", image)
					end
					background.Image = "http://www.roblox.com/asset/?id=" .. image
				elseif text == "play all messages" then
					if displayingallmsgs == false then
						local frame, closebutton = puter.CreateWindow(500, 225, "All Messages")
						displayingallmsgs = true
						closebutton.MouseButton1Click:Connect(function()
							displayingallmsgs = false
						end)
						local scrollingframe = puter.AddWindowElement(frame, "ScrollingFrame", {
							ScrollBarThickness = 6;
							Size = UDim2.fromOffset(500, 225);
						})
						for i, message in pairs(recorded) do
							local textlabel = puter.AddWindowElement(frame, "TextLabel", {
								Size = UDim2.fromOffset(494, 25);
								Position = UDim2.fromOffset(0, (i - 1) * 25);
								Text = message;
								TextScaled = true;
							})
							scrollingframe.CanvasSize = UDim2.fromOffset(0, i * 25)
							textlabel.Parent = scrollingframe

						end
					end
				elseif text == "clear recorded" then
					recorded = {}
				elseif string.sub(text, 1, 10) == "play audio" then
					if speaker ~= nil then
						speaker:Configure({Pitch = 1})
						puter.PlayAudio(string.sub(text, 12, #text), speaker)
					end
				elseif string.sub(text, 1, 13) == "display image" then
					local image = string.sub(text, 15, #text)
					if displayingimg == false then
						local frame, closebutton = puter.CreateWindow(400, 250, "ImageViewer")
						closebutton.MouseButton1Click:Connect(function()
							displayingimg = false
						end)
						displayingimg = true
						puter.AddWindowElement(frame , "ImageLabel", {
							Image = "http://www.roblox.com/asset/?id=" .. image;
							Size = UDim2.fromOffset(400, 225);
						})
						local setwallpaper = puter.AddWindowElement(frame, "TextButton", {
							Size = UDim2.fromOffset(400, 25);
							Position = UDim2.fromOffset(0, 225);
							Text = "Set As Wallpaper";
							TextColor3 = Color3.fromHex("#FFFFFF");
							BackgroundColor3 = Color3.fromHex("#000000");
							TextScaled = true;
						})
						setwallpaper.MouseButton1Click:Connect(function()
							if storage ~= nil then
								storage:Write("Wallpaper", image)
							end
							background.Image = "http://www.roblox.com/asset/?id=" .. image
						end)
					end
				elseif string.sub(text, 1, 10) == "setmodemid" then
					if storage ~= nil then
						storage:Write("ModemID", string.sub(text, 12, #text))
					end
					if modem ~= nil then
						modem:Configure({NetworkID = string.sub(text, 12, #text)})
					end
				elseif text == "record text" then
					recordingtext = true
				elseif text == "stop recording text" then
					recordingtext = false
				elseif string.sub(text, 1, 22) == "play all text messages" then
					if displayingallmsgs == false then
						local frame, closebutton = puter.CreateWindow(500, 225, "All Text Messages")
						displayingallmsgs = true
						closebutton.MouseButton1Click:Connect(function()
							displayingallmsgs = false
						end)
						local scrollingframe = puter.AddWindowElement(frame, "ScrollingFrame", {
							ScrollBarThickness = 6;
							Size = UDim2.fromOffset(500, 225);
						})
						for i, message in pairs(recordedtext) do
							local textlabel = puter.AddWindowElement(frame, "TextLabel", {
								Size = UDim2.fromOffset(494, 25);
								Position = UDim2.fromOffset(0, (i - 1) * 25);
								Text = message;
								TextScaled = true;
							})
							scrollingframe.CanvasSize = UDim2.fromOffset(0, i * 25)
							textlabel.Parent = scrollingframe

						end
					end
				elseif text == "clear recorded text" then
					recordedtext = {}
				elseif string.sub(text, 1, 9) == "set pitch" then
					if speaker ~= nil then
						local pitch = string.sub(text, 11, #text)
						speaker:Configure({Pitch = pitch})
						speaker:Trigger()
					end
				elseif string.sub(text, 1, 8) == "disk run" then
					if GetPartFromPort(4, "Disk") ~= nil then
						if GetPartFromPort(4, "Disk"):Read(string.sub(text, 10, #text)) ~= nil then
							luastop(polysilicon, 6)
							luarun(GetPartFromPort(4, "Disk"):Read(string.sub(text, 10, #text)), terminalmicrocontroller, polysilicon, 6)
						else
							return true, "could not find data on specified key"
						end
					else
						return true, "please insert a disk"
					end
				elseif string.sub(text, 1, 10) == "play video" then
					local image = string.sub(text, 12, #text)
					local playing = true
					if playingvideo == false then
						local frame, closebutton = puter.CreateWindow(400, 250, "Video Player")
						playingvideo = true
						local video = puter.AddWindowElement(frame, "VideoFrame", {
							Video = "http://www.roblox.com/asset/?id=" .. image;
							Size = UDim2.fromOffset(400, 225);
							Playing = true;
							Looped = true;
							Volume = 100;
						})
						local pauseButton = frame:CreateElement("TextButton", {
							Text = "Pause";
							TextScaled = true;
							TextColor3 = Color3.fromRGB(255,255,255);
							Size = UDim2.fromOffset(400, 25);
							Position = UDim2.fromOffset(0, 225);
							BorderSizePixel = 0;
							BackgroundColor3 = Color3.fromRGB(0,0,0)
						})
						pauseButton.MouseButton1Click:Connect(function()
							if playing then
								pauseButton.Text = "Play"
								video:Pause()
								playing = false
							else
								pauseButton.Text = "Pause"
								video:Play()
								playing = true
							end
						end)
					end
				elseif text == "reset" then
					storage:ClearDisk()
				elseif text == "crash" then
					ReturnError("Manual Crash", "MANUAL_CRASH")
				elseif text == "clear" and clrfnc ~= nil or text == "cls" and clrfnc ~= nil then
					clrfnc()
				elseif string.sub(text, 1, 4) == "kill" then
					local killed = closeByName(string.sub(text, 6, #text))
					terminalout("Killed " .. tostring(killed) .. " coroutines.")
				elseif string.sub(text, 1, 4) == "help" then
					if pages[tonumber(string.sub(text, 6, #text))] ~= nil then
						for i, v in pairs(pages[tonumber(string.sub(text, 6, #text))]) do
							terminalout(v)
						end
					else
						terminalout("help [Page]: Displays 1 of the 4 pages.")
					end
				elseif text == "flush events" then
					connections = {}
					terminalout("Events flushed, please restart every app.")
				elseif text == "show logs" then
					eventViewer()
				elseif text == "process manager" then
					processManager()
				else
					return true, "no such command"
				end
			else
				return true, checkBlacklist[plr]
			end
		end
		local knownFileTypes = {
			["lua"] = function(code)
				luarun(code, GetPartFromPort(6, "Microcontroller"), GetPartFromPort(6, "Polysilicon"), 6)
			end;
			["image"] = function(imageID)
				check("display image " .. imageID, "explorer")
			end;
			["audio"] = function(audioID)
				puter.PlayAudio(audioID, speaker)
			end;
			["video"] = function(videoID)
				check("play video " .. videoID, "explorer")
			end;
		}
		local fileTypeNames = {
			["lua"] = "Lua Script";
			["image"] = "Image";
			["audio"] = "Audio";
			["video"] = "Video";
			["folder"] = "Folder";
		}
		local function typeParser(input)
			if input == "t:folder" then
				return "folder", input, "t:folder"
			elseif string.sub(input, 1, 2) == "t:" then
				for i = 1, #input, 1 do
					if string.sub(input, i, i) == "/" then
						if knownFileTypes[string.sub(input, 3, i - 1)] ~= nil or string.sub(input, 3, i - 1) == "folder" then

							return string.sub(input, 3, i - 1), string.sub(input, i + 1, #input), string.sub(input, 1, i - 1)
						else


							return "Unknown", string.sub(input, i + 1, #input), string.sub(input, 1, i - 1)
						end
					end
				end
			else

				return "Unknown", input, "unknown"
			end
		end
		local cursorshouldexist = {}
		xConnect("screen", "CursorMoved", function(cursor)
			if cursors[cursor.Player] ~= nil then
				cursorPositions[cursor.Player] = {X = cursor.X, Y = cursor.Y}
				cursors[cursor.Player].Position = UDim2.fromOffset(cursor.X - 50, cursor.Y - 50)
			elseif not cursorshouldexist[cursor.Player] then
				cursorPositions[cursor.Player] = tostring(cursor.X - 50) .. ", " .. tostring(cursor.Y - 50)
				local newCursor = screen:CreateElement("ImageLabel", {
					BackgroundTransparency = 1;
					Image = "rbxassetid://12582149183";
					Size = UDim2.fromOffset(100, 100);
					Position = UDim2.fromOffset(0, 0);
					ZIndex = 9;
				})
				cursorshouldexist[cursor.Player] = true
				local playerName = screen:CreateElement("TextLabel", {
					Text = cursor.Player;
					Size = UDim2.fromOffset(200, 25);
					Position = UDim2.fromOffset(-50, 25);
					TextStrokeTransparency = 0;
					TextColor3 = Color3.fromRGB(255,255,255);
					TextScaled = true;
					BackgroundTransparency = 1;
					BorderSizePixel = 0;
					ZIndex = 9;
				})
				playerName.Parent = newCursor
				cursors[cursor.Player] = newCursor
			end
		end)
		local canuseapp = {}
		local canopenexplorer = true
		local function explorer(directory, disk)
			if canopenexplorer == true then
				local explorerwindow, closeexplorer = puter.CreateWindow(500, 300, "Explorer")
				canopenexplorer = false
				local function openMainExplorer()
					puter.AddWindowElement(explorerwindow, "TextLabel", {
						Size = UDim2.fromOffset(300, 25);
						Text = "Filename";
						TextScaled = true;
						TextColor3 = Color3.fromRGB(255,255,255);
						BackgroundColor3 = Color3.fromRGB(0,0,0);
						Position = UDim2.fromOffset(0, 50);
						BorderSizePixel = 0;
					})
					puter.AddWindowElement(explorerwindow, "TextLabel", {
						Size = UDim2.fromOffset(200, 25);
						Text = "Type";
						TextScaled = true;
						TextColor3 = Color3.fromRGB(255,255,255);
						BackgroundColor3 = Color3.fromRGB(0,0,0);
						Position = UDim2.fromOffset(300, 50);
						BorderSizePixel = 0;
					})
					local actionParentFrame = puter.AddWindowElement(explorerwindow, "Frame", {
						Size = UDim2.fromOffset(500, 25);
						Position = UDim2.fromOffset(0,0);
						BackgroundColor3 = Color3.fromRGB(44, 44, 44);
						BorderSizePixel = 0;
					})
					local called = true
					local path = directory
					local viewingDisk = disk
					if not filesystem.read(directory, disk) then
						path = nil
						viewingDisk = nil
					end
					local pathLabel = puter.AddWindowElement(explorerwindow, "TextLabel", {
						Size = UDim2.fromOffset(495, 25);
						Position = UDim2.fromOffset(5, 25);
						BorderSizePixel = 0;
						BackgroundTransparency = 1;
						TextColor3 = Color3.fromRGB(255,255,255);
						TextScaled = true;
						Text = path;
						TextXAlignment = Enum.TextXAlignment.Left;
					})
					local fileFrame
					local canopencfolder = true
					local canopencfile = true
					local actionFile = puter.AddElement(actionParentFrame, "TextButton", {
						Size = UDim2.fromOffset(50, 25);
						Text = "File";
						TextScaled = true;
						TextColor3 = Color3.fromRGB(255,255,255);
						BackgroundColor3 = Color3.fromRGB(44, 44, 44);
						Position = UDim2.fromOffset(0, 0);
						BorderSizePixel = 0;
					})
					local actionRefresh = puter.AddElement(actionParentFrame, "TextButton", {
						Size = UDim2.fromOffset(75, 25);
						Text = "Refresh";
						TextScaled = true;
						TextColor3 = Color3.fromRGB(255,255,255);
						BackgroundColor3 = Color3.fromRGB(44, 44, 44);
						Position = UDim2.fromOffset(75, 0);
						BorderSizePixel = 0;
					})
					local mainScrollFrame = puter.AddWindowElement(explorerwindow, "ScrollingFrame", {
						Size = UDim2.fromOffset(500, 225);
						Position = UDim2.fromOffset(0, 75);
						BorderSizePixel = 0;
						BackgroundColor3 = Color3.fromRGB(60, 60, 60);
						ScrollBarThickness = 2;
						CanvasSize = UDim2.fromOffset(0,0);
					})
					local canopenproperties = true
					local function addFile(fileName, fileType, position, data, trueType, trueData, file)
						local cachedpath = path .. fileName
						local cachedDisk = viewingDisk
						local parentFrame = puter.AddElement(mainScrollFrame, "Frame", {
							Size = UDim2.fromOffset(498, 25);
							Position = position;
							BorderSizePixel = 0;
							BackgroundTransparency = 1;
						})
						local fileNameButton = puter.AddElement(parentFrame, "TextButton", {
							Size = UDim2.fromOffset(300, 25);
							Position = UDim2.fromOffset(0,0);
							BackgroundColor3 = Color3.fromRGB(100,100,100);
							BorderSizePixel = 0;
							TextColor3 = Color3.fromRGB(255,255,255);
							TextScaled = true;
							Text = fileName
						})
						local fileTypeName
						if fileTypeNames[fileType] ~= nil then
							fileTypeName = fileTypeNames[fileType]
						else
							fileTypeName = "Unknown"
						end
						puter.AddElement(parentFrame, "TextLabel", {
							Size = UDim2.fromOffset(148, 25);
							Position = UDim2.fromOffset(300,0);
							BackgroundColor3 = Color3.fromRGB(100,100,100);
							BorderSizePixel = 0;
							TextColor3 = Color3.fromRGB(255,255,255);
							TextScaled = true;
							Text = fileTypeName
						})
						local propertiesbutton = puter.AddElement(parentFrame, "TextButton", {
							Size = UDim2.fromOffset(50, 25);
							Position = UDim2.fromOffset(448,0);
							BackgroundColor3 = Color3.fromRGB(100,100,100);
							BorderSizePixel = 0;
							TextColor3 = Color3.fromRGB(255,255,255);
							TextScaled = true;
							Text = "Properties"
						})
						fileNameButton.MouseButton1Click:Connect(function()
							local thingToDo = knownFileTypes[fileType]

							if thingToDo ~= nil then
								thingToDo(data)
							elseif fileType == "folder" then
								if filesystem.read(cachedpath .. "/", cachedDisk).data == "t:folder" then
									if string.sub(path, #path, #path) ~= "/" then
										path = path .. "/"
									end
									path = cachedpath .. "/"
									called = true
								else
									called = true
								end
							else
								errorPopup("Unknown file type")
							end
						end)
						propertiesbutton.MouseButton1Click:Connect(function()
							if canopenproperties == true then
								local yes, bruh = pcall(function()
									local window, closebutton, titlebar = puter.CreateWindow(300, 300, "Properties")
									closebutton.MouseButton1Click:Connect(function()
										canopenproperties = true
									end)
									canopenproperties = false
									puter.AddWindowElement(window, "TextLabel", {
										Size = UDim2.fromOffset(280, 25);
										Position = UDim2.fromOffset(10, 10);
										BorderSizePixel = 0;
										BackgroundTransparency = 1;
										TextColor3 = Color3.fromRGB(255,255,255);
										TextScaled = true;
										Text = "Filename: " .. fileName;
									})
									puter.AddWindowElement(window, "TextLabel", {
										Size = UDim2.fromOffset(280, 25);
										Position = UDim2.fromOffset(10, 45);
										BorderSizePixel = 0;
										BackgroundTransparency = 1;
										TextColor3 = Color3.fromRGB(255,255,255);
										TextScaled = true;
										Text = "Path: " .. path;
										TextXAlignment = Enum.TextXAlignment.Left;
									})
									puter.AddWindowElement(window, "TextLabel", {
										Size = UDim2.fromOffset(280, 25);
										Position = UDim2.fromOffset(10, 80);
										BorderSizePixel = 0;
										BackgroundTransparency = 1;
										TextColor3 = Color3.fromRGB(255,255,255);
										TextScaled = true;
										Text = "Type: " .. fileTypeName .. " (" .. trueType .. ")";
										TextXAlignment = Enum.TextXAlignment.Left
									})
									local deletebutton = puter.AddWindowElement(window, "TextButton", {
										Size = UDim2.fromOffset(100, 25);
										Position = UDim2.fromOffset(100, 250);
										BorderSizePixel = 0;
										BackgroundColor3 = Color3.fromRGB(255,0,0);
										TextColor3 = Color3.fromRGB(0,0,0);
										TextScaled = true;
										Text = "Delete";
									})
									deletebutton.MouseButton1Click:Connect(function()
										file:delete()
										called = true
										titlebar:Destroy()
										canopenproperties = true
									end)
								end)
								if yes == false then

								end
							end
						end)
					end
					local function getUp()
						local set = false
						if path ~= "/" then
							for i = #path - 1, 1, -1 do
								if string.sub(path, i, i) == "/" and set == false then
									path = string.sub(path, 1, i)
									set = true
									called = true
								end
							end
						else
							path = "Disk View"
							viewingDisk = nil
							called = true
						end
					end
					local function getFolders(path, disk)
						local folders = filesystem.scanPath(path, disk)
						local offset = 0
						for i, v in pairs(folders) do
							local folder = filesystem.read(path .. v .. "/", disk)
							if folder then
								local fileType, data, trueType = typeParser(folder.data)
								offset = offset + 1
								addFile(v, fileType, UDim2.fromOffset(0, offset * 25), data, trueType, folder.data, folder)
							end
						end
						return offset * 25
					end
					local function getFiles(path, disk, offset)
						local files = filesystem.scanPath(path, disk)
						local offsetv2 = 0
						for i, v in pairs(files) do
							local file = filesystem.read(path .. v, disk)
							if file then
								local fileType, data, trueType = typeParser(file.data)
								offsetv2 = offsetv2 + 1
								addFile(v, fileType, UDim2.fromOffset(0, offsetv2 * 25 + offset), data, trueType, file.data, file)
							end
						end
						return offsetv2 * 25
					end
					local function getPath(path, disk)
						if filesystem.read(path, disk).data == "t:folder" then
							local yay, noooo = pcall(function()
								pathLabel.Text = path
								mainScrollFrame:Destroy()
								mainScrollFrame = puter.AddWindowElement(explorerwindow, "ScrollingFrame", {
									Size = UDim2.fromOffset(500, 225);
									Position = UDim2.fromOffset(0, 75);
									BorderSizePixel = 0;
									BackgroundColor3 = Color3.fromRGB(60, 60, 60);
									ScrollBarThickness = 2;
									CanvasSize = UDim2.fromOffset(0,0);
								})
								local parentFrame = puter.AddElement(mainScrollFrame, "Frame", {
									Size = UDim2.fromOffset(498, 25);
									Position = UDim2.fromOffset(0, 0);
									BorderSizePixel = 0;
									BackgroundTransparency = 1;
								})
								local fileNameButton = puter.AddElement(parentFrame, "TextButton", {
									Size = UDim2.fromOffset(300, 25);
									Position = UDim2.fromOffset(0,0);
									BackgroundColor3 = Color3.fromRGB(100,100,100);
									BorderSizePixel = 0;
									TextColor3 = Color3.fromRGB(255,255,255);
									TextScaled = true;
									Text = ".."
								})
								puter.AddElement(parentFrame, "TextLabel", {
									Size = UDim2.fromOffset(198, 25);
									Position = UDim2.fromOffset(300,0);
									BackgroundColor3 = Color3.fromRGB(100,100,100);
									BorderSizePixel = 0;
									TextColor3 = Color3.fromRGB(255,255,255);
									TextScaled = true;
									Text = "Folder"
								})
								fileNameButton.MouseButton1Click:Connect(function()
									getUp()
								end)
								local files = filesystem.scanPath(path, disk)
								local offset = getFolders(path, disk)
								local offsetv2 = getFiles(path, disk, offset)
								mainScrollFrame.CanvasSize = UDim2.fromOffset(0, offset + offsetv2)
							end)
							if yay == false then
								for i, v in pairs(disk:ReadAll()) do
									print(i, v)
								end
								print(noooo)
							end
						end
					end
					local function displayDisks()
						pathLabel.Text = "Disk View"
						mainScrollFrame:Destroy()
						mainScrollFrame = puter.AddWindowElement(explorerwindow, "ScrollingFrame", {
							Size = UDim2.fromOffset(500, 225);
							Position = UDim2.fromOffset(0, 75);
							BorderSizePixel = 0;
							BackgroundColor3 = Color3.fromRGB(60, 60, 60);
							ScrollBarThickness = 2;
							CanvasSize = UDim2.fromOffset(0,0);
						})
						local diskExists = 0
						if GetPartFromPort(4, "Disk") ~= nil then
							diskExists = 1
							mainScrollFrame.CanvasSize = UDim2.fromOffset(0, 0 + diskExists * 25)
							local parentFrame = puter.AddElement(mainScrollFrame, "Frame", {
								Size = UDim2.fromOffset(498, 25);
								Position = UDim2.fromOffset(0, 0);
								BorderSizePixel = 0;
								BackgroundTransparency = 1;
							})
							local fileNameButton = puter.AddElement(parentFrame, "TextButton", {
								Size = UDim2.fromOffset(300, 25);
								Position = UDim2.fromOffset(0,0);
								BackgroundColor3 = Color3.fromRGB(100,100,100);
								BorderSizePixel = 0;
								TextColor3 = Color3.fromRGB(255,255,255);
								TextScaled = true;
								Text = "Removable Storage"
							})
							puter.AddElement(parentFrame, "TextLabel", {
								Size = UDim2.fromOffset(198, 25);
								Position = UDim2.fromOffset(300,0);
								BackgroundColor3 = Color3.fromRGB(100,100,100);
								BorderSizePixel = 0;
								TextColor3 = Color3.fromRGB(255,255,255);
								TextScaled = true;
								Text = "Disk"
							})
							GetPartFromPort(4, "Disk"):Write("/", "t:folder")
							mounteddisks[0] = GetPartFromPort(4, "Disk")
							fileNameButton.MouseButton1Click:Connect(function()
								viewingDisk = GetPartFromPort(4, "Disk")
								path = "/"
								called = true
							end)
						else
							mounteddisks[0] = nil
						end
						for i, v in pairs(mounteddisks) do
							if i > 0 then
								mainScrollFrame.CanvasSize = UDim2.fromOffset(0, i + diskExists * 25)
								local parentFrame = puter.AddElement(mainScrollFrame, "Frame", {
									Size = UDim2.fromOffset(498, 25);
									Position = UDim2.fromOffset(0, (i - 1 + diskExists) * 25);
									BorderSizePixel = 0;
									BackgroundTransparency = 1;
								})
								local fileNameButton = puter.AddElement(parentFrame, "TextButton", {
									Size = UDim2.fromOffset(300, 25);
									Position = UDim2.fromOffset(0,0);
									BackgroundColor3 = Color3.fromRGB(100,100,100);
									BorderSizePixel = 0;
									TextColor3 = Color3.fromRGB(255,255,255);
									TextScaled = true;
									Text = "Disk " ..  tostring(i)
								})
								local text = "Disk"
								if i == foundPrimary then
									text = "Primary Disk"
								end
								puter.AddElement(parentFrame, "TextLabel", {
									Size = UDim2.fromOffset(198, 25);
									Position = UDim2.fromOffset(300,0);
									BackgroundColor3 = Color3.fromRGB(100,100,100);
									BorderSizePixel = 0;
									TextColor3 = Color3.fromRGB(255,255,255);
									TextScaled = true;
									Text = text
								})
								fileNameButton.MouseButton1Click:Connect(function()
									viewingDisk = v
									path = "/"
									called = true
								end)
							end
						end
					end
					local director = newCoroutine(function()
						while true do
							wait(0.1)
							if called == true then

								if viewingDisk ~= nil then

									if path ~= "Disk View" and path ~= nil then

										getPath(path, viewingDisk)
									else

										viewingDisk = nil
										displayDisks()
									end
								else

									displayDisks()
								end
								called = false

							end
						end
					end, "Explorer Director")
					closeexplorer.MouseButton1Click:Connect(function()
						canopenexplorer = true
						closeCoroutine(director)
					end)
					actionRefresh.MouseButton1Click:Connect(function()
						called = true
					end)
					actionFile.MouseButton1Click:Connect(function()
						if fileFrame == nil then
							fileFrame = puter.AddWindowElement(explorerwindow, "Frame", {
								Size = UDim2.fromOffset(100, 50);
								Position = UDim2.fromOffset(0, 25);
								BackgroundColor3 = Color3.fromRGB(48, 48, 48);
								BorderSizePixel = 0;
							})
							local createDirectory = puter.AddElement(fileFrame, "TextButton", {
								Size = UDim2.fromOffset(100, 25);
								Position = UDim2.fromOffset(0, 0);
								BackgroundColor3 = Color3.fromRGB(48, 48, 48);
								BorderSizePixel = 0;
								TextColor3 = Color3.fromRGB(255,255,255);
								TextScaled = true;
								Text = "Create Directory";
							})
							local createFile = puter.AddElement(fileFrame, "TextButton", {
								Size = UDim2.fromOffset(100, 25);
								Position = UDim2.fromOffset(0, 25);
								BackgroundColor3 = Color3.fromRGB(48, 48, 48);
								BorderSizePixel = 0;
								TextColor3 = Color3.fromRGB(255,255,255);
								TextScaled = true;
								Text = "Create File";
							})
							createDirectory.MouseButton1Click:Connect(function()
								if canopencfolder == true then
									local focusedOn = nil
									local name
									local path
									local disk
									local window, closebutton = puter.CreateWindow(400, 225, "Directory Creator")
									closebutton.MouseButton1Click:Connect(function()
										canopencfolder = true
									end)
									canopencfolder = false
									local nameButton = puter.AddWindowElement(window, "TextButton", {
										Text = "Name: ";
										TextScaled = true;
										TextColor3 = Color3.fromRGB(0,0,0);
										BackgroundColor3 = Color3.fromRGB(77, 77, 77);
										Size = UDim2.fromOffset(380, 25);
										Position = UDim2.fromOffset(10, 10);
									})
									local pathButton = puter.AddWindowElement(window, "TextButton", {
										Text = "Path: ";
										TextScaled = true;
										TextColor3 = Color3.fromRGB(0,0,0);
										BackgroundColor3 = Color3.fromRGB(77, 77, 77);
										Size = UDim2.fromOffset(380, 25);
										Position = UDim2.fromOffset(10, 45);
									})
									local diskButton = puter.AddWindowElement(window, "TextButton", {
										Text = "Disk (number): ";
										TextScaled = true;
										TextColor3 = Color3.fromRGB(0,0,0);
										BackgroundColor3 = Color3.fromRGB(77, 77, 77);
										Size = UDim2.fromOffset(380, 25);
										Position = UDim2.fromOffset(10, 80);
									})
									local createButton = puter.AddWindowElement(window, "TextButton", {
										Text = "Create";
										TextScaled = true;
										TextColor3 = Color3.fromRGB(0,0,0);
										BackgroundColor3 = Color3.fromRGB(77, 77, 77);
										Size = UDim2.fromOffset(100, 25);
										Position = UDim2.fromOffset(150, 175);
									})
									nameButton.MouseButton1Click:Connect(function()
										focusedOn = "name"
										nameButton.BackgroundColor3 = Color3.fromRGB(0,255,0)
										pathButton.BackgroundColor3 = Color3.fromRGB(77, 77, 77)
										diskButton.BackgroundColor3 = Color3.fromRGB(77, 77, 77)
									end)
									pathButton.MouseButton1Click:Connect(function()
										focusedOn = "path"
										nameButton.BackgroundColor3 = Color3.fromRGB(77, 77, 77)
										pathButton.BackgroundColor3 = Color3.fromRGB(0,255,0)
										diskButton.BackgroundColor3 = Color3.fromRGB(77, 77, 77)
									end)
									diskButton.MouseButton1Click:Connect(function()
										focusedOn = "disk"
										nameButton.BackgroundColor3 = Color3.fromRGB(77, 77, 77)
										pathButton.BackgroundColor3 = Color3.fromRGB(77, 77, 77)
										diskButton.BackgroundColor3 = Color3.fromRGB(0,255,0)
									end)
									createButton.MouseButton1Click:Connect(function()
										Beep()
										local function throwError(text)
											local err = puter.AddWindowElement(window, "TextLabel", {
												Text = text;
												Size = UDim2.fromOffset(400, 25);
												Position = UDim2.fromOffset(0, 150);
												TextScaled = true;
												TextColor3 = Color3.fromRGB(255,0,0);
												BackgroundTransparency = 1;
											})

											wait(1)
											err:Destroy()

										end
										local goodjob, uhoh = pcall(function()

											xAssert(mounteddisks[disk], "invalid disk, make sure that you didnt accidentally type in anything other than a number")
											xAssert(path, "input a path")
											specialAssert(filesystem.read(path, mounteddisks[disk]).data, "t:folder", "path specified is not a folder")
											xAssert(name, "input a name")
											specialAssert(function()
												local badName = false
												for i = 1, #name, 1 do
													if string.sub(name, i, i) == "/" then
														return true
													end
												end
											end, false, "dont put a / in the name you doofus", true)
											filesystem.createDirectory(path .. name .. "/", mounteddisks[disk])
											called = true

										end)
										if goodjob == false then
											throwError(uhoh)
										end
									end)
									xConnect("keyboard", "TextInputted", function(text, plr)
										text = string.sub(text, 1, #text - 1)
										if focusedOn == "name" then
											name = text
											nameButton.Text = "Name: " .. text
										elseif focusedOn == "path" then
											path = text
											pathButton.Text = "Path: " .. text
										elseif focusedOn == "disk" then
											disk = tonumber(text)
											diskButton.Text = "Disk (number): " .. text
										end
									end, "folderCreator")
								end
							end)
							createFile.MouseButton1Click:Connect(function()
								local yay, nay = pcall(function()
									if canopencfile == true then
										local focusedOn = nil
										local name
										local path
										local disk
										local fileType
										local data
										local window, closebutton = puter.CreateWindow(400, 225, "File Creator")
										closebutton.MouseButton1Click:Connect(function()
											canopencfile = true
										end)
										canopencfile = false
										local nameButton = puter.AddWindowElement(window, "TextButton", {
											Text = "Name: ";
											TextScaled = true;
											TextColor3 = Color3.fromRGB(0,0,0);
											BackgroundColor3 = Color3.fromRGB(77, 77, 77);
											Size = UDim2.fromOffset(380, 20);
											Position = UDim2.fromOffset(10, 5);
										})
										local pathButton = puter.AddWindowElement(window, "TextButton", {
											Text = "Path: ";
											TextScaled = true;
											TextColor3 = Color3.fromRGB(0,0,0);
											BackgroundColor3 = Color3.fromRGB(77, 77, 77);
											Size = UDim2.fromOffset(380, 20);
											Position = UDim2.fromOffset(10, 30);
										})
										local diskButton = puter.AddWindowElement(window, "TextButton", {
											Text = "Disk (number): ";
											TextScaled = true;
											TextColor3 = Color3.fromRGB(0,0,0);
											BackgroundColor3 = Color3.fromRGB(77, 77, 77);
											Size = UDim2.fromOffset(380, 20);
											Position = UDim2.fromOffset(10, 55);
										})
										local typeButton = puter.AddWindowElement(window, "TextButton", {
											Text = "Type: ";
											TextScaled = true;
											TextColor3 = Color3.fromRGB(0,0,0);
											BackgroundColor3 = Color3.fromRGB(77, 77, 77);
											Size = UDim2.fromOffset(380, 20);
											Position = UDim2.fromOffset(10, 80);
										})
										local dataButton = puter.AddWindowElement(window, "TextButton", {
											Text = "Data: ";
											TextScaled = true;
											TextColor3 = Color3.fromRGB(0,0,0);
											BackgroundColor3 = Color3.fromRGB(77, 77, 77);
											Size = UDim2.fromOffset(380, 20);
											Position = UDim2.fromOffset(10, 105);
										})
										puter.AddWindowElement(window, "TextLabel", {
											Text = "Valid types: lua, image, audio, video";
											TextScaled = true;
											TextColor3 = Color3.fromRGB(0,0,0);
											BackgroundTransparency = 1;
											Size = UDim2.fromOffset(380, 20);
											Position = UDim2.fromOffset(10, 130);
										})
										local createButton = puter.AddWindowElement(window, "TextButton", {
											Text = "Create";
											TextScaled = true;
											TextColor3 = Color3.fromRGB(0,0,0);
											BackgroundColor3 = Color3.fromRGB(77, 77, 77);
											Size = UDim2.fromOffset(100, 25);
											Position = UDim2.fromOffset(150, 195);
										})
										nameButton.MouseButton1Click:Connect(function()
											focusedOn = "name"
											nameButton.BackgroundColor3 = Color3.fromRGB(0,255,0)
											pathButton.BackgroundColor3 = Color3.fromRGB(77, 77, 77)
											diskButton.BackgroundColor3 = Color3.fromRGB(77, 77, 77)
											typeButton.BackgroundColor3 = Color3.fromRGB(77, 77, 77)
											dataButton.BackgroundColor3 = Color3.fromRGB(77, 77, 77)
										end)
										pathButton.MouseButton1Click:Connect(function()
											focusedOn = "path"
											nameButton.BackgroundColor3 = Color3.fromRGB(77, 77, 77)
											pathButton.BackgroundColor3 = Color3.fromRGB(0,255,0)
											diskButton.BackgroundColor3 = Color3.fromRGB(77, 77, 77)
											typeButton.BackgroundColor3 = Color3.fromRGB(77, 77, 77)
											dataButton.BackgroundColor3 = Color3.fromRGB(77, 77, 77)
										end)
										diskButton.MouseButton1Click:Connect(function()
											focusedOn = "disk"
											nameButton.BackgroundColor3 = Color3.fromRGB(77, 77, 77)
											pathButton.BackgroundColor3 = Color3.fromRGB(77, 77, 77)
											diskButton.BackgroundColor3 = Color3.fromRGB(0,255,0)
											typeButton.BackgroundColor3 = Color3.fromRGB(77, 77, 77)
											dataButton.BackgroundColor3 = Color3.fromRGB(77, 77, 77)
										end)
										typeButton.MouseButton1Click:Connect(function()
											focusedOn = "type"
											nameButton.BackgroundColor3 = Color3.fromRGB(77, 77, 77)
											pathButton.BackgroundColor3 = Color3.fromRGB(77, 77, 77)
											diskButton.BackgroundColor3 = Color3.fromRGB(77, 77, 77)
											typeButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
											dataButton.BackgroundColor3 = Color3.fromRGB(77, 77, 77)
										end)
										dataButton.MouseButton1Click:Connect(function()
											focusedOn = "data"
											nameButton.BackgroundColor3 = Color3.fromRGB(77, 77, 77)
											pathButton.BackgroundColor3 = Color3.fromRGB(77, 77, 77)
											diskButton.BackgroundColor3 = Color3.fromRGB(77, 77, 77)
											typeButton.BackgroundColor3 = Color3.fromRGB(77, 77, 77)
											dataButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
										end)
										createButton.MouseButton1Click:Connect(function()
											Beep()
											local function throwError(text)
												local err = puter.AddWindowElement(window, "TextLabel", {
													Text = text;
													Size = UDim2.fromOffset(400, 25);
													Position = UDim2.fromOffset(0, 165);
													TextScaled = true;
													TextColor3 = Color3.fromRGB(255,0,0);
													BackgroundTransparency = 1;
												})

												wait(1)
												err:Destroy()

											end
											local function note(text)
												local note = puter.AddWindowElement(window, "TextLabel", {
													Text = text;
													Size = UDim2.fromOffset(400, 25);
													Position = UDim2.fromOffset(0, 150);
													TextScaled = true;
													TextColor3 = Color3.fromRGB(0,255,0);
													BackgroundTransparency = 1;
												})

												wait(1)
												note:Destroy()

											end
											local goodjob, uhoh = pcall(function()
												xAssert(mounteddisks[disk], "invalid disk, make sure that you didnt accidentally type in anything other than a number")
												xAssert(path, "input a path")
												specialAssert(filesystem.read(path, mounteddisks[disk]).data, "t:folder", "path specified is not a folder")
												xAssert(name, "input a name")
												specialAssert(function()
													local badName = false
													for i = 1, #name, 1 do
														if string.sub(name, i, i) == "/" then
															return true
														end
													end
												end, false, "dont put a / in the name you doofus", true)
												xAssert(fileType, "please input a type")
												xAssert(data, "input some data")
												if fileType ~= "folder" then
													filesystem.write(path, name, "t:" .. fileType .. "/" .. data, mounteddisks[disk])
													note("written... i think")
													called = true
												else
													filesystem.createDirectory(path .. name .. "/", mounteddisks[disk])
													note("a folder was created, did you think you could break me?")
													called = true
												end

											end)
											if goodjob == false then
												throwError(uhoh)
											end
										end)
										xConnect("keyboard", "TextInputted", function(text, plr)
											text = string.sub(text, 1, #text - 1)
											if focusedOn == "name" then
												name = text
												nameButton.Text = "Name: " .. text
											elseif focusedOn == "path" then
												path = text
												pathButton.Text = "Path: " .. text
											elseif focusedOn == "disk" then
												disk = tonumber(text)
												diskButton.Text = "Disk (number): " .. text
											elseif focusedOn == "type" then
												fileType = text
												typeButton.Text = "Type: " .. text
											elseif focusedOn == "data" then
												data = text
												dataButton.Text = "Data: " .. text
											end
										end, "fileCreator")
									else

									end
								end)
								if yay == false then

								end
							end)
						else
							fileFrame:Destroy()
							fileFrame = nil
						end
					end)
				end
				openMainExplorer()
			end
		end
		local getdesktopfiles
		if foundPrimary then
			local foldersToDisplay = {}
			local filesToDisplay = {}
			local function getFolders(path, disk)
				local folders = filesystem.scanPath(path, disk)
				for i, v in pairs(folders) do
					local folder, err = filesystem.read(path .. v .. "/", disk)
					if folder then
						foldersToDisplay[path .. v .. "/"] = folder
					else
						print(err)
					end
				end
			end
			local function getFiles(path, disk)
				local files = filesystem.scanPath(path, disk)
				for i, v in pairs(files) do
					local file, err = filesystem.read(path .. v, disk)
					if file then
						filesToDisplay[path .. v] = file
					else
						print(err)
					end
				end
			end
			getdesktopfiles = function()
				getFiles("/Desktop/", mounteddisks[foundPrimary])
				getFolders("/Desktop/", mounteddisks[foundPrimary])
				iconsToGenerate = {}
				for i, v in pairs(filesToDisplay) do
					addIcon(v:getName(), function()
						local fileType, data, trueType = typeParser(v.data)
						local thingToDo = knownFileTypes[fileType]
						if thingToDo ~= nil then
							thingToDo(data)
						else
							errorPopup("Unknown file type")
						end
					end)
				end
				for i, v in pairs(foldersToDisplay) do
					addIcon(v:getName(), function()
						explorer(i, mounteddisks[foundPrimary])
					end)
				end
			end
		end
		local function lagometer()
			if canopenlagometer == true then
				canopenlagometer = false
				local window, closebutton = puter.CreateWindow(400, 225, "Lag O'Meter", Color3.fromRGB(0,0,0))
				local currentFPS = puter.AddWindowElement(window, "TextLabel", {
					Size = UDim2.fromOffset(50, 50);
					Position = UDim2.fromOffset(350, 0);
					TextColor3 = Color3.fromRGB(255,255,255);
					BackgroundTransparency = 1;
					TextScaled = true;
					Text = "N/A";
				})
				local lagHistoryFrame = puter.AddWindowElement(window, "Frame", {
					Size = UDim2.fromOffset(350, 125);
					Position = UDim2.fromOffset(0, 140);
					BackgroundColor3 = Color3.fromRGB(0,0,0);
					BorderSizePixel = 0;
				})
				local lag = {}
				local lagBars = {}
				for i = 1, 16, 1 do
					local lagBar = puter.AddElement(lagHistoryFrame, "Frame", {
						Size = UDim2.fromOffset(0, 0);
						BackgroundColor3 = Color3.fromRGB(0,0,0);
						BorderSizePixel = 0;
						Position = UDim2.fromOffset((i - 1) * 25, 125)
					})
					local lagAmount = puter.AddElement(lagBar, "TextLabel", {
						Size = UDim2.fromOffset(15, 15);
						Position = UDim2.fromOffset(5, -20);
						Text = "";
						TextScaled = true;
						TextColor3 = Color3.fromRGB(0,0,0);
						BackgroundTransparency = 1;
					})
					lagBars[i] = {}
					lagBars[i]["bar"] = lagBar
					lagBars[i]["amount"] = lagAmount
				end
				local function addperformance(performance)
					if #lag <= 15 then
						lag[#lag + 1] = performance
					elseif #lag >= 16 then
						for i, v in pairs(lag) do
							if i >= 2 then
								lag[i - 1] = lag[i]
							end
						end
						lag[16] = performance
					end
				end
				local updated = false
				local lagMeasurer = newCoroutine(function()
					while true do
						local curTime = tick()
						wait(1)
						local difference = tick() - curTime
						local performance = math.floor(100 / difference)
						addperformance(performance)
						local color
						if performance >= 75 then
							color = Color3.fromRGB(0,255,0)
						elseif performance >= 50 then
							color = Color3.fromRGB(255,255,0)
						elseif performance >= 25 then
							color = Color3.fromRGB(255,126,0)
						elseif performance >= 10 then
							color = Color3.fromRGB(255,0,0)
						else
							color = Color3.fromRGB(143, 255, 244)
						end
						currentFPS.Text = performance
						currentFPS.TextColor3 = color
						updated = true
					end
				end, "Lag Measurer")
				local lagHistory = newCoroutine(function()
					while true do 
						wait(0.5)
						for i, v in pairs(lag) do
							local color
							local size
							if v >= 75 then
								color = Color3.fromRGB(0,255,0)
							elseif v >= 50 then
								color = Color3.fromRGB(255,255,0)
							elseif v >= 25 then
								color = Color3.fromRGB(255,126,0)
							elseif v >= 10 then
								color = Color3.fromRGB(255,0,0)
							else
								color = Color3.fromRGB(143, 255, 244)
							end
							if v >= 1 then
								size = UDim2.fromOffset(25,v)
							else
								size = UDim2.fromOffset(25, 100)
							end
							lagBars[i]["bar"].Size = size
							lagBars[i]["bar"].BackgroundColor3 = color
							lagBars[i]["bar"].Position = UDim2.fromOffset((i - 1) * 25, 100 - v + 25)
							lagBars[i]["amount"].Text = v
							lagBars[i]["amount"].TextColor3 = color
						end
					end
				end, "Lag History")
				closebutton.MouseButton1Click:Connect(function()
					closeCoroutine(lagMeasurer)
					closeCoroutine(lagHistory)
					canopenlagometer = true
				end)
			end
		end
		staticIcons[4] = {Name = "Lag O'Meter", Function = lagometer}
		local function musicPlayer()
			if availableComponents["speaker"] and storage then
				if canopenmusic == true then
					local musicList
					local canopenadd = true
					local window, closebutton = puter.CreateWindow(400, 300, "Music Player")
					closebutton.MouseButton1Click:Connect(function()
						canopenmusic = true
					end)
					canopenmusic = false
					if storage:Read("musicList") ~= nil then
						musicList = decodeRawMusicList(storage:Read("musicList"))
					else
						musicList = {}
						storage:Write("musicList", encodeMusicList(musicList))
					end
					local addButton = puter.AddWindowElement(window, "TextButton", {
						BackgroundColor3 = Color3.fromRGB(0,255,0);
						Text = "Add";
						TextScaled = true;
						TextColor3 = Color3.fromRGB(0,0,0);
						BorderSizePixel = 0;
						Position = UDim2.fromOffset(50,0);
						Size = UDim2.fromOffset(250, 25);
					})
					local space = puter.AddWindowElement(window, "TextLabel", {
						BackgroundColor3 = Color3.fromRGB(0,0,0);
						Text = tostring(#musicList) .. " / 70";
						TextScaled = true;
						TextColor3 = Color3.fromRGB(255,255,255);
						BorderSizePixel = 0;
						Position = UDim2.fromOffset(0,0);
						Size = UDim2.fromOffset(50, 25);
					})
					local nameLabel = puter.AddWindowElement(window, "TextLabel", {
						BackgroundColor3 = Color3.fromRGB(0,0,0);
						Text = "Name";
						TextScaled = true;
						TextColor3 = Color3.fromRGB(255,255,255);
						BorderSizePixel = 0;
						Position = UDim2.fromOffset(0,25);
						Size = UDim2.fromOffset(150, 25);
					})
					local idlabel = puter.AddWindowElement(window, "TextLabel", {
						BackgroundColor3 = Color3.fromRGB(0,0,0);
						Text = "Audio ID";
						TextScaled = true;
						TextColor3 = Color3.fromRGB(255,255,255);
						BorderSizePixel = 0;
						Position = UDim2.fromOffset(150,25);
						Size = UDim2.fromOffset(150, 25);
					})
					local actionLabel = puter.AddWindowElement(window, "TextLabel", {
						BackgroundColor3 = Color3.fromRGB(0,0,0);
						Text = "Actions";
						TextScaled = true;
						TextColor3 = Color3.fromRGB(255,255,255);
						BorderSizePixel = 0;
						Position = UDim2.fromOffset(300,25);
						Size = UDim2.fromOffset(100, 25);
					})
					local scrollFrame = puter.AddWindowElement(window, "ScrollingFrame", {
						Size = UDim2.fromOffset(400, 250);
						Position = UDim2.fromOffset(0, 50);
						BackgroundColor3 = Color3.fromRGB(86, 86, 86);
						ScrollBarThickness = 2;
						ScrollingDirection = Enum.ScrollingDirection.Y;
						CanvasSize = UDim2.fromOffset(0, 0);
					})
					local function refresh()
						musicList = decodeRawMusicList(storage:Read("musicList"))
						space.Text = tostring(#musicList) .. " / 70"
						scrollFrame:Destroy()
						scrollFrame = puter.AddWindowElement(window, "ScrollingFrame", {
							Size = UDim2.fromOffset(400, 250);
							Position = UDim2.fromOffset(0, 50);
							BackgroundColor3 = Color3.fromRGB(86, 86, 86);
							ScrollBarThickness = 1;
							ScrollingDirection = Enum.ScrollingDirection.Y;
							CanvasSize = UDim2.fromOffset(0, 0);
						})
						for i, v in pairs(musicList) do
							local parentFrame = puter.AddElement(scrollFrame, "Frame", {
								Size = UDim2.fromOffset(398, 25);
								Position = UDim2.fromOffset(0, (i - 1) * 25);
								BackgroundTransparency = 1;
							})
							scrollFrame.CanvasSize = UDim2.fromOffset(0, i * 25)
							for i2, v2 in pairs(v) do
								if i2 == "name" then
									puter.AddElement(parentFrame, "TextLabel", {
										Size = UDim2.fromOffset(150, 25);
										Position = UDim2.fromOffset(0, 0);
										Text = v2;
										TextColor3 = Color3.fromRGB(255,255,255);
										TextScaled = true;
										BackgroundTransparency = 1;
									})
								elseif i2 == "id" then
									puter.AddElement(parentFrame, "TextLabel", {
										Size = UDim2.fromOffset(150, 25);
										Position = UDim2.fromOffset(150, 0);
										Text = v2;
										TextColor3 = Color3.fromRGB(255,255,255);
										TextScaled = true;
										BackgroundTransparency = 1;
									})
									local playButton = puter.AddElement(parentFrame, "TextButton", {
										Text = ">";
										TextScaled = true;
										TextColor3 = Color3.fromRGB(0,0,0);
										BackgroundColor3 = Color3.fromRGB(0,255,0);
										BorderSizePixel = 0;
										Size = UDim2.fromOffset(25, 25);
										Position = UDim2.fromOffset(300, 0);
									})
									local pauseButton = puter.AddElement(parentFrame, "TextButton", {
										Text = "x";
										TextScaled = true;
										TextColor3 = Color3.fromRGB(0,0,0);
										BackgroundColor3 = Color3.fromRGB(255,255,0);
										BorderSizePixel = 0;
										Size = UDim2.fromOffset(25, 25);
										Position = UDim2.fromOffset(325, 0);
									})
									playButton.MouseButton1Click:Connect(function()
										puter.PlayAudio(v2, speaker)
									end)
									pauseButton.MouseButton1Click:Connect(function()
										if speaker ~= nil then
											speaker:ClearSounds()
										end
									end)
									local clickedDelete = false
									local deleteButton = puter.AddElement(parentFrame, "TextButton", {
										Text = "Delete";
										TextScaled = true;
										TextColor3 = Color3.fromRGB(0,0,0);
										BackgroundColor3 = Color3.fromRGB(255,0,0);
										BorderSizePixel = 0;
										Size = UDim2.fromOffset(49, 25);
										Position = UDim2.fromOffset(350, 0);
									})
									deleteButton.MouseButton1Click:Connect(function()
										if clickedDelete == true then
											musicList[i] = nil
											storage:Write("musicList", encodeMusicList(musicList))
											parentFrame:Destroy()
											refresh()
										else
											deleteButton.Text  = "Are you sure?"
											clickedDelete = true
											wait(2.5)
											if deleteButton ~= nil then
												deleteButton.Text = "Delete"
											end
											clickedDelete = false
										end
									end)
								end
							end
						end
					end
					local refreshButton = puter.AddWindowElement(window, "TextButton", {
						BackgroundColor3 = Color3.fromRGB(0,0,0);
						Text = "Refresh";
						TextScaled = true;
						TextColor3 = Color3.fromRGB(255,255,255);
						BorderSizePixel = 0;
						Position = UDim2.fromOffset(300,0);
						Size = UDim2.fromOffset(100, 25);
					})
					refreshButton.MouseButton1Click:Connect(function()
						refresh()
					end)
					refresh()
					addButton.MouseButton1Click:Connect(function()
						if canopenadd == true then
							local window, closebutton = puter.CreateWindow(400, 300, "Add Music")
							closebutton.MouseButton1Click:Connect(function()
								canopenadd = true
							end)
							canopenadd = false
							local focusedon = nil
							local name
							local id
							local musicName = puter.AddWindowElement(window, "TextButton", {
								Text = "Music Name:";
								TextScaled = true;
								TextColor3 = Color3.fromRGB(0,0,0);
								BackgroundColor3 = Color3.fromRGB(77, 77, 77);
								Size = UDim2.fromOffset(380, 25);
								Position = UDim2.fromOffset(10, 10);
							})
							local musicId = puter.AddWindowElement(window, "TextButton", {
								Text = "Music ID:";
								TextScaled = true;
								TextColor3 = Color3.fromRGB(0,0,0);
								BackgroundColor3 = Color3.fromRGB(77, 77, 77);
								Size = UDim2.fromOffset(380, 25);
								Position = UDim2.fromOffset(10, 45);
							})
							local okbutton = puter.AddWindowElement(window, "TextButton", {
								Text = "Add";
								TextColor3 = Color3.fromRGB(0,0,0);
								TextScaled = true;
								Size = UDim2.fromOffset(100, 25);
								Position = UDim2.fromOffset(150, 250);
								BackgroundColor3 = Color3.fromRGB(77, 77, 77);
							})
							musicName.MouseButton1Click:Connect(function()
								focusedon = "name"
								musicName.BackgroundColor3 = Color3.fromRGB(0,255,0)
								musicId.BackgroundColor3 = Color3.fromRGB(77, 77, 77)
							end)
							musicId.MouseButton1Click:Connect(function()
								focusedon = "id"
								musicId.BackgroundColor3 = Color3.fromRGB(0,255,0)
								musicName.BackgroundColor3 = Color3.fromRGB(77, 77, 77)
							end)
							okbutton.MouseButton1Click:Connect(function()
								if name ~= nil then
									if #name <= 50 then
										if id ~= nil then
											if #musicList <= 69 then
												musicList[#musicList + 1] = {["name"] = name, ["id"] = id}
												storage:Write("musicList", encodeMusicList(musicList))
												refresh()
												local success = puter.AddWindowElement(window, "TextLabel", {
													Text = "saved";
													Size = UDim2.fromOffset(400, 25);
													Position = UDim2.fromOffset(0, 225);
													TextScaled = true;
													TextColor3 = Color3.fromRGB(0,255,0);
													BackgroundTransparency = 1;
												})
												wait(1)
												success:Destroy()
											else
												local err = puter.AddWindowElement(window, "TextLabel", {
													Text = "out of space";
													Size = UDim2.fromOffset(400, 25);
													Position = UDim2.fromOffset(0, 225);
													TextScaled = true;
													TextColor3 = Color3.fromRGB(255,0,0);
													BackgroundTransparency = 1;
												})
												wait(1)
												err:Destroy()
											end
										else
											local err = puter.AddWindowElement(window, "TextLabel", {
												Text = "please input an ID";
												Size = UDim2.fromOffset(400, 25);
												Position = UDim2.fromOffset(0, 225);
												TextScaled = true;
												TextColor3 = Color3.fromRGB(255,0,0);
												BackgroundTransparency = 1;
											})
											wait(1)
											err:Destroy()
										end
									else
										local err = puter.AddWindowElement(window, "TextLabel", {
											Text = "name is too long";
											Size = UDim2.fromOffset(400, 25);
											Position = UDim2.fromOffset(0, 225);
											TextScaled = true;
											TextColor3 = Color3.fromRGB(255,0,0);
											BackgroundTransparency = 1;
										})
										wait(1)
										err:Destroy()
									end
								else
									local err = puter.AddWindowElement(window, "TextLabel", {
										Text = "please input a name";
										Size = UDim2.fromOffset(400, 25);
										Position = UDim2.fromOffset(0, 225);
										TextScaled = true;
										TextColor3 = Color3.fromRGB(255,0,0);
										BackgroundTransparency = 1;
									})
									wait(1)
									err:Destroy()
								end
							end)
							xConnect("keyboard", "TextInputted", function(text, plr)
								text = string.sub(text, 1, #text - 1)
								if focusedon == "name" then
									name = text
									musicName.Text = "Music Name: " .. text
								elseif focusedon == "id" then
									id = text
									musicId.Text = "Music ID: " .. text
								end
							end, "addMusic")
						end
					end)
				end
			else
				errorPopup("Missing components")
			end
		end
		staticIcons[5] = {Name = "Music Player", Function = musicPlayer}
		shutdownbutton.MouseButton1Click:Connect(function()
			shutdown()
		end)
		restartbutton.MouseButton1Click:Connect(function()
			running = false
			screen:ClearElements()
			for i, v in pairs(coroutines) do
				closeCoroutine(i)
			end
			Beep()
			TriggerPort(3)
		end)
		staticIcons[1] = {Name = "Explorer", Function = explorer}
		local canopenterminal = true
		local canopenchat = true
		local canopendiskutil = true
		local chatModem = GetPartFromPort(6, "Modem")
		local function diskUtil()
			if canopendiskutil == true then
				canopendiskutil = false
				local window, closebutton = puter.CreateWindow(400, 225, "Disk Utility")
				closebutton.MouseButton1Click:Connect(function()
					canopendiskutil = true
				end)
				local key = nil
				local data = nil
				local focusedon = nil
				local keybutton = puter.AddWindowElement(window, "TextButton", {
					Text = "KEY: ";
					Size = UDim2.fromOffset(380, 25);
					Position = UDim2.fromOffset(10, 10);
					BackgroundColor3 = Color3.fromRGB(70, 70, 70);
					TextScaled = true;
				})
				local databutton = puter.AddWindowElement(window, "TextButton", {
					Text = "DATA: ";
					Size = UDim2.fromOffset(380, 25);
					Position = UDim2.fromOffset(10, 45);
					BackgroundColor3 = Color3.fromRGB(70, 70, 70);
					TextScaled = true;
				})
				local write = puter.AddWindowElement(window, "TextButton", {
					Text = "WRITE";
					Size = UDim2.fromOffset(100, 25);
					Position = UDim2.fromOffset(150, 175);
					BackgroundColor3 = Color3.fromRGB(70, 70, 70);
					TextScaled = true;
				})
				keybutton.MouseButton1Click:Connect(function()
					focusedon = "key"
					keybutton.BackgroundColor3 = Color3.fromRGB(0,255,0)
					databutton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
				end)
				databutton.MouseButton1Click:Connect(function()
					focusedon = "data"
					keybutton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
					databutton.BackgroundColor3 = Color3.fromRGB(0,255,0)
				end)
				xConnect("keyboard", "TextInputted", function(text, plr)
					if canopendiskutil == false then
						text = string.sub(text, 1, #text - 1)
						if focusedon == "key" then
							key = text
							keybutton.Text = "KEY: " .. key
						elseif focusedon == "data" then
							data = text
							databutton.Text = "DATA: " .. data
						end
					end
				end, "diskUtil")
				write.MouseButton1Click:Connect(function()
					if key ~= nil then
						if data ~= nil then
							if GetPartFromPort(4, "Disk") ~= nil then
								GetPartFromPort(4, "Disk"):Write(key, data)
								local success = puter.AddWindowElement(window, "TextLabel", {
									Text = "written";
									Size = UDim2.fromOffset(400, 25);
									Position = UDim2.fromOffset(0, 150);
									TextScaled = true;
									TextColor3 = Color3.fromRGB(0,255,0);
									BackgroundTransparency = 1;
								})
								wait(1)
								success:Destroy()
							else
								local err = puter.AddWindowElement(window, "TextLabel", {
									Text = "please insert a disk";
									Size = UDim2.fromOffset(400, 25);
									Position = UDim2.fromOffset(0, 150);
									TextScaled = true;
									TextColor3 = Color3.fromRGB(255,0,0);
									BackgroundTransparency = 1;
								})
								wait(1)
								err:Destroy()
							end
						else
							local err = puter.AddWindowElement(window, "TextLabel", {
								Text = "data not found";
								Size = UDim2.fromOffset(400, 25);
								Position = UDim2.fromOffset(0, 150);
								TextScaled = true;
								TextColor3 = Color3.fromRGB(255,0,0);
								BackgroundTransparency = 1;
							})
							wait(1)
							err:Destroy()
						end
					else
						local err = puter.AddWindowElement(window, "TextLabel", {
							Text = "key not found";
							Size = UDim2.fromOffset(400, 25);
							Position = UDim2.fromOffset(0, 150);
							TextScaled = true;
							TextColor3 = Color3.fromRGB(255,0,0);
							BackgroundTransparency = 1;
						})
						wait(1)
						err:Destroy()
					end
				end)
			end
		end
		staticIcons[3] = {Name = "Disk Utility", Function = diskUtil}
		local function openChat()
			if chatModem ~= nil and canopenchat == true then
				canopenchat = false
				local receivedirregularinput
				local busyWith = nil
				local idconnected
				local window, closebutton, titlebar = puter.CreateWindow(400, 225, "Chat")
				local connectPublicNet = puter.AddWindowElement(window, "TextButton", {
					Position = UDim2.fromOffset(50, 50);
					Size = UDim2.fromOffset(300, 50);
					Text = "Connect to public chat network";
					TextScaled = true;
					BackgroundColor3 = Color3.fromRGB(121, 121, 121);
				})
				closebutton.MouseButton1Click:Connect(function()
					canopenchat = true
				end)
				local connectToSpecModem = puter.AddWindowElement(window, "TextButton", {
					Position = UDim2.fromOffset(50, 150);
					Size = UDim2.fromOffset(300, 50);
					Text = "Connect to a specific modem";
					TextScaled = true;
					BackgroundColor3 = Color3.fromRGB(121, 121, 121);
				})
				local function showChat()
					local chatFrame = puter.AddWindowElement(window, "Frame", {
						Size = UDim2.fromOffset(400, 225);
						BackgroundColor3 = Color3.fromRGB(121, 121, 121);
						BorderSizePixel = 0;
					})
					local chatLabels = {}
					local chat = {}
					for i = 1, 9, 1 do
						chatLabels[i] = puter.AddWindowElement(window, "TextButton", {
							Size = UDim2.fromOffset(400, 25);
							BackgroundTransparency = 1;
							BorderSizePixel = 0;
							Text = "";
							TextXAlignment = Enum.TextXAlignment.Left;
							TextScaled = true;
							Position = UDim2.fromOffset(0, (i - 1) * 25);
							TextColor3 = Color3.fromRGB(85, 85, 255);
						})
						chatLabels[i].MouseButton1Click:Connect(function()
							if chat[i].executable == true then
								check(chat[i].actualmessage, "chat")
							end
						end)
					end
					local sendname = true
					local legacymode = false
					local function addMessage(message, color)
						local formatted = {}
						if typeof(message) == "string" then
							if string.sub(message, 1, 2) == "b/" then
								local actualMessage
								for i = 1, #message, 1 do
									if string.sub(message, i, i + 1) == "]:" then
										actualMessage = i + 3
									end
								end
								formatted.actualmessage = actualMessage
								formatted.message = message
								formatted.executable = true
								formatted.color = Color3.fromRGB(85, 85, 255)
							elseif string.sub(message, 1, 2) == "t/" then
								formatted.actualmessage = nil
								formatted.message = string.sub(message, 3, #message)
								formatted.executable = false
							elseif string.sub(message, 1, 2) == "e/" then
								formatted.actualmessage = nil
								formatted.message = string.sub(message, 3, #message)
								formatted.executable = false
								formatted.color = Color3.fromRGB(255, 80, 83)
							else
								formatted.actualmessage = nil
								formatted.message = message
								formatted.executable = false
							end
						end	
						if not message then
							formatted.actualmessage = nil
							formatted.message = "Error!"
							formatted.executable = false
							formatted.color = Color3.fromRGB(255, 80, 83)
						end
						if not formatted.color then
							formatted.color = color
						end
						if #chat <= 8 then
							chat[#chat + 1] = formatted
						elseif #chat >= 9 then
							for i, v in pairs(chat) do
								if i >= 2 then
									chat[i - 1] = chat[i]
								end
							end
							chat[9] = formatted
						end
					end
					local function renderChat()
						Beep()
						for i, v in pairs(chat) do
							local color = Color3.fromRGB(0,0,0)
							if v.color then
								color = v.color
							end
							chatLabels[i].Text = v.message
							chatLabels[i].TextColor3 = color
						end
					end
					local function sendMessage(plr, text, idconnected, actualPlr, legacymode, isButton)
						local messageToSend = nil
						if sendname == false then
							plr = "Anonymous"
						end
						if legacymode == false and isButton == false then
							messageToSend = "t/[" .. plr .. "]: " .. text
						elseif legacymode == false and isButton == true then
							messageToSend = "b/[" .. plr .. "]: " .. string.sub(text, 4, #text)
						elseif legacymode == true then
							messageToSend = "[" .. plr .. "]: " .. text
						end
						Beep()
						chatModem:SendMessage(messageToSend, idconnected)
					end
					xConnect("keyboard", "TextInputted", function(text, plr)
						text = string.sub(text, 1, #text - 1)
						if canopenchat == false and window:IsActive() == true then
							if string.sub(text, 1, 1) ~= "!" and string.sub(text, 1, 2) ~= "?c" then
								sendMessage(plr, text, idconnected, plr, legacymode, false)
							elseif string.sub(text, 1, 2) == "?c" then
								sendMessage(plr, text, idconnected, plr, legacymode, true)
							end
							if string.sub(text, 1, 1) == "!" then
								if string.sub(text, 2, 11) == "togglename" then
									if sendname == true then
										sendname = false
										addMessage("<System> Your name will not be sent.")
										renderChat()
									else
										sendname = true
										addMessage("<System> Your name will be sent.")
										renderChat()
									end
								elseif string.sub(text, 2, 11) == "legacymode" then
									legacymode = true
									addMessage("<System> Enabled legacy mode.")
									renderChat()
								elseif string.sub(text, 2, 11) == "modernmode" then
									legacymode = false
									addMessage("<System> Disabled legacy mode.")
									renderChat()
								end
							end
						end
					end, "chat")
					chatModem.MessageSent:Connect(function(tmessage)
						local message = tmessage
						if typeof(message) ~= "string" and not receivedirregularinput then
							receivedirregularinput = true
							addMessage("<System> Receiving irregular input.", Color3.fromRGB(150,150,0))
							message = xtostring(message, ": ")
							print(message)
						end
						if canopenchat == false then
							print(tostring(message))
							addMessage(message)
							renderChat()
						end
					end)
				end
				connectPublicNet.MouseButton1Click:Connect(function()
					connectPublicNet:Destroy()
					connectToSpecModem:Destroy()
					if idconnected == nil then
						idconnected = 10
						chatModem:Configure({NetworkID = idconnected})
						showChat()
					end
				end)
				connectToSpecModem.MouseButton1Click:Connect(function()
					connectPublicNet:Destroy()
					connectToSpecModem:Destroy()
					puter.AddWindowElement(window, "TextLabel", {
						Size = UDim2.fromOffset(400, 225);
						Text = "Please type in the modem ID you want to connect to in the keyboard";
						TextScaled = true;
						BackgroundColor3 = Color3.fromRGB(121, 121, 121);
					})
					xConnect("keyboard", "TextInputted", function(text, plr)
						if idconnected == nil then
							idconnected = string.sub(text, 1, #text - 1)
							chatModem:Configure({NetworkID = idconnected})
							showChat()
						end
					end, "chat")
				end)
			end
		end
		staticIcons[2] = {Name = "Chat", Function = openChat}
		puterutils.iconEngine(100, 100, 15, 15, Xres, 400, background, false, 1)
		local function rebuildDesktop()
			getdesktopfiles()
			local createIcon = puterutils.iconEngine(100, 100, 15, 15, Xres, 400, background, false, 1)
			for i, v in pairs(iconMap) do
				v:Destroy()
			end
			for i, v in pairs(staticIcons) do
				local icon = createIcon(v.Name, Color3.fromRGB(152, 152, 152), Color3.fromRGB(0,0,0))
				iconMap[v.Name] = icon
				icon.MouseButton1Click:Connect(v.Function)
			end
			for i, v in pairs(iconsToGenerate) do
				local icon = createIcon(v.Name, Color3.fromRGB(152, 152, 152), Color3.fromRGB(0,0,0))
				iconMap[v.Name] = icon
				icon.MouseButton1Click:Connect(v.Function)
			end
		end
		rebuildDesktop()
		local postomaticOpen = false
		local function openPostOMatic()
			local window, closebutton, titlebar = puter.CreateWindow(400, 225, "Post-O-Matic")
			postomaticOpen = true
			closebutton.MouseButton1Click:Connect(function()
				postomaticOpen = false
			end)
			local memory = {
				["domain"] = "";
				["dataKey"] = "";
				["dataValue"] = "";
				["headerKey"] = "";
				["headerValue"] = "";
			}
			local system = {
				["domain"] = nil;
				["dataKey"] = nil;
				["dataValue"] = nil;
				["headerKey"] = nil;
				["headerValue"] = nil;
			}
			local focusLogic = {
				["domain"] = "main";
				["dataKey"] = "dataEdit";
				["dataValue"] = "dataEdit";
				["headerKey"] = "headerEdit";
				["headerValue"] = "headerEdit";
			}
			local prefixes = {
				["domain"] = "Domain: ";
				["dataKey"] = "Data Index: ";
				["dataValue"] = "Data Value: ";
				["headerKey"] = "Header Index: ";
				["headerValue"] = "Header Value: ";
			}
			local currentlyOpen = "main"
			local data = {}
			local headers = {}
			go(memory) go(headers) go(data)
			local focused = ""
			local busy = false
			local initialize
			local function openDataMenu()
				currentlyOpen = "dataMenu"
				window:ClearElements()
				local backButton = window:CreateElement("TextButton", {
					Size = UDim2.fromOffset(100, 25);
					Position = UDim2.fromOffset(0, 0);
					Text = "< Back";
					TextScaled = true;
					BackgroundColor3 = Color3.fromRGB(0,0,0);
					TextColor3 = Color3.fromRGB(255,255,255);
					BorderSizePixel = 0;
				})
				backButton.MouseButton1Click:Connect(function()
					initialize()
				end)
				local addButton = window:CreateElement("TextButton", {
					Size = UDim2.fromOffset(300, 25);
					Position = UDim2.fromOffset(100, 0);
					Text = "Add";
					TextScaled = true;
					BackgroundColor3 = Color3.fromRGB(0,255,0);
					TextColor3 = Color3.fromRGB(0,0,0);
					BorderSizePixel = 0;
				})
				addButton.MouseButton1Click:Connect(function()
					currentlyOpen = "dataEdit"
					window:ClearElements()
					system.dataKey = window:CreateElement("TextButton", {
						Size = UDim2.fromOffset(380, 25);
						Position = UDim2.fromOffset(10, 10);
						Text = "Data Index: " .. memory.dataKey;
						BackgroundColor3 = Color3.fromRGB(100,100,100);
						TextColor3 = Color3.fromRGB(0,0,0);
						TextScaled = true;
					})
					system.dataValue = window:CreateElement("TextButton", {
						Size = UDim2.fromOffset(380, 25);
						Position = UDim2.fromOffset(10, 45);
						Text = "Data Value: " .. memory.dataValue;
						BackgroundColor3 = Color3.fromRGB(100,100,100);
						TextColor3 = Color3.fromRGB(0,0,0);
						TextScaled = true;
					})
					local backButton = window:CreateElement("TextButton", {
						Size = UDim2.fromOffset(50, 25);
						Position = UDim2.fromOffset(145, 190);
						Text = "Back";
						BackgroundColor3 = Color3.fromRGB(100,100,100);
						TextColor3 = Color3.fromRGB(0,0,0);
						TextScaled = true;
					})
					local addButton = window:CreateElement("TextButton", {
						Size = UDim2.fromOffset(50, 25);
						Position = UDim2.fromOffset(205, 190);
						Text = "Add";
						BackgroundColor3 = Color3.fromRGB(100,100,100);
						TextColor3 = Color3.fromRGB(0,0,0);
						TextScaled = true;
					})
					system.dataKey.MouseButton1Click:Connect(function()
						focused = "dataKey"
						system.dataKey.BackgroundColor3 = Color3.fromRGB(0,255,0)
						system.dataValue.BackgroundColor3 = Color3.fromRGB(100,100,100)
					end)
					system.dataValue.MouseButton1Click:Connect(function()
						focused = "dataValue"
						system.dataKey.BackgroundColor3 = Color3.fromRGB(100,100,100)
						system.dataValue.BackgroundColor3 = Color3.fromRGB(0,255,0)
					end)
					addButton.MouseButton1Click:Connect(function()
						data[memory.dataKey] = memory.dataValue
						local success = window:CreateElement("TextLabel", {
							Text = "added";
							Size = UDim2.fromOffset(400, 25);
							Position = UDim2.fromOffset(0, 155);
							TextScaled = true;
							TextColor3 = Color3.fromRGB(0,255,0);
							BackgroundTransparency = 1;
						})
						wait(1)
						success:Destroy()
					end)
					backButton.MouseButton1Click:Connect(function()
						openDataMenu()
					end)
				end)
				local dataFrame = window:CreateElement("ScrollingFrame", {
					Size = UDim2.fromOffset(400, 200);
					Position = UDim2.fromOffset(0, 25);
					BackgroundColor3 = Color3.fromRGB(86, 86, 86);
					BorderSizePixel = 0;
					ScrollBarThickness = 2;
					ScrollingDirection = Enum.ScrollingDirection.Y;
					CanvasSize = UDim2.fromOffset(0, 0);
				})
				local offset = 0
				for i, v in pairs(data) do
					offset += 1
					dataFrame.CanvasSize = UDim2.fromOffset(0, offset * 25)
					local parent = window:CreateElement("Frame", {
						Size = UDim2.fromOffset(400, 25);
						Position = UDim2.fromOffset(0, (offset - 1) * 25);
						BackgroundTransparency = 1;
						BorderSizePixel = 0;
					})
					parent.Parent = dataFrame
					puter.AddElement(parent, "TextLabel", {
						Size = UDim2.fromOffset(180, 25);
						Position = UDim2.fromOffset(0, 0);
						Text = i;
						TextColor3 = Color3.fromRGB(255,255,255);
						BackgroundTransparency = 1;
						TextScaled = true;
						BorderSizePixel = 0;
					})
					puter.AddElement(parent, "TextLabel", {
						Size = UDim2.fromOffset(180, 25);
						Position = UDim2.fromOffset(180, 0);
						Text = v;
						TextColor3 = Color3.fromRGB(255,255,255);
						BackgroundTransparency = 1;
						TextScaled = true;
						BorderSizePixel = 0;
					})
					local remove = puter.AddElement(parent, "TextButton", {
						Size = UDim2.fromOffset(40, 25);
						Position = UDim2.fromOffset(360, 0);
						Text = "Remove";
						TextColor3 = Color3.fromRGB(0,0,0);
						BackgroundColor3 = Color3.fromRGB(255,0,0);
						TextScaled = true;
						BorderSizePixel = 0;
					})
					remove.MouseButton1Click:Connect(function()
						data[i] = nil
						openDataMenu()
					end)
				end
			end
			local function openHeaderMenu()
				currentlyOpen = "headerMenu"
				window:ClearElements()
				local backButton = window:CreateElement("TextButton", {
					Size = UDim2.fromOffset(100, 25);
					Position = UDim2.fromOffset(0, 0);
					Text = "< Back";
					TextScaled = true;
					BackgroundColor3 = Color3.fromRGB(0,0,0);
					TextColor3 = Color3.fromRGB(255,255,255);
					BorderSizePixel = 0;
				})
				backButton.MouseButton1Click:Connect(function()
					initialize()
				end)
				local addButton = window:CreateElement("TextButton", {
					Size = UDim2.fromOffset(300, 25);
					Position = UDim2.fromOffset(100, 0);
					Text = "Add";
					TextScaled = true;
					BackgroundColor3 = Color3.fromRGB(0,255,0);
					TextColor3 = Color3.fromRGB(0,0,0);
					BorderSizePixel = 0;
				})
				addButton.MouseButton1Click:Connect(function()
					currentlyOpen = "headerEdit"
					window:ClearElements()
					system.headerKey = window:CreateElement("TextButton", {
						Size = UDim2.fromOffset(380, 25);
						Position = UDim2.fromOffset(10, 10);
						Text = "Header Index: " .. memory.headerKey;
						BackgroundColor3 = Color3.fromRGB(100,100,100);
						TextColor3 = Color3.fromRGB(0,0,0);
						TextScaled = true;
					})
					system.headerValue = window:CreateElement("TextButton", {
						Size = UDim2.fromOffset(380, 25);
						Position = UDim2.fromOffset(10, 45);
						Text = "Header Value: " .. memory.headerValue;
						BackgroundColor3 = Color3.fromRGB(100,100,100);
						TextColor3 = Color3.fromRGB(0,0,0);
						TextScaled = true;
					})
					local backButton = window:CreateElement("TextButton", {
						Size = UDim2.fromOffset(50, 25);
						Position = UDim2.fromOffset(145, 190);
						Text = "Back";
						BackgroundColor3 = Color3.fromRGB(100,100,100);
						TextColor3 = Color3.fromRGB(0,0,0);
						TextScaled = true;
					})
					local addButton = window:CreateElement("TextButton", {
						Size = UDim2.fromOffset(50, 25);
						Position = UDim2.fromOffset(205, 190);
						Text = "Add";
						BackgroundColor3 = Color3.fromRGB(100,100,100);
						TextColor3 = Color3.fromRGB(0,0,0);
						TextScaled = true;
					})
					system.headerKey.MouseButton1Click:Connect(function()
						focused = "headerKey"
						system.headerKey.BackgroundColor3 = Color3.fromRGB(0,255,0)
						system.headerValue.BackgroundColor3 = Color3.fromRGB(100,100,100)
					end)
					system.headerValue.MouseButton1Click:Connect(function()
						focused = "headerValue"
						system.headerKey.BackgroundColor3 = Color3.fromRGB(100,100,100)
						system.headerValue.BackgroundColor3 = Color3.fromRGB(0,255,0)
					end)
					backButton.MouseButton1Click:Connect(function()
						openHeaderMenu()
					end)
					addButton.MouseButton1Click:Connect(function()
						headers[memory.headerKey] = memory.headerValue
						local success = window:CreateElement("TextLabel", {
							Text = "added";
							Size = UDim2.fromOffset(400, 25);
							Position = UDim2.fromOffset(0, 155);
							TextScaled = true;
							TextColor3 = Color3.fromRGB(0,255,0);
							BackgroundTransparency = 1;
						})
						wait(1)
						success:Destroy()
						go(memory) go(headers) go(data)
					end)
				end)
				local headerFrame = window:CreateElement("ScrollingFrame", {
					Size = UDim2.fromOffset(400, 200);
					Position = UDim2.fromOffset(0, 25);
					BackgroundColor3 = Color3.fromRGB(86, 86, 86);
					BorderSizePixel = 0;
					ScrollBarThickness = 2;
					ScrollingDirection = Enum.ScrollingDirection.Y;
					CanvasSize = UDim2.fromOffset(0, 0);
				})
				local offset = 0
				for i, v in pairs(headers) do
					offset += 1
					headerFrame.CanvasSize = UDim2.fromOffset(0, offset * 25)
					local parent = window:CreateElement("Frame", {
						Size = UDim2.fromOffset(400, 25);
						Position = UDim2.fromOffset(0, (offset - 1) * 25);
						BackgroundTransparency = 1;
						BorderSizePixel = 0;
					})
					parent.Parent = headerFrame
					puter.AddElement(parent, "TextLabel", {
						Size = UDim2.fromOffset(180, 25);
						Position = UDim2.fromOffset(0, 0);
						Text = i;
						TextColor3 = Color3.fromRGB(255,255,255);
						BackgroundTransparency = 1;
						TextScaled = true;
						BorderSizePixel = 0;
					})
					puter.AddElement(parent, "TextLabel", {
						Size = UDim2.fromOffset(180, 25);
						Position = UDim2.fromOffset(180, 0);
						Text = v;
						TextColor3 = Color3.fromRGB(255,255,255);
						BackgroundTransparency = 1;
						TextScaled = true;
						BorderSizePixel = 0;
					})
					local remove = puter.AddElement(parent, "TextButton", {
						Size = UDim2.fromOffset(40, 25);
						Position = UDim2.fromOffset(360, 0);
						Text = "Remove";
						TextColor3 = Color3.fromRGB(0,0,0);
						BackgroundColor3 = Color3.fromRGB(255,0,0);
						TextScaled = true;
						BorderSizePixel = 0;
					})
					remove.MouseButton1Click:Connect(function()
						headers[i] = nil
						openHeaderMenu()
					end)
				end
			end
			local function get()
				if busy == false then
					busy = true
					local err
					local function errored(boom)
						closeByName("ResponseTimeout")
						err = boom
						print(boom)
					end
					local response
					local timedout = false
					local success
					newCoroutine(function()
						local success, fail = pcall(function()
							response = modem:GetAsync(memory.domain, true, headers)
						end)
						if not success then
							errored(fail)
						end
					end, "GetRequest")
					window:ClearElements()
					window:CreateElement("TextLabel", {
						BackgroundTransparency = 1;
						TextScaled = true;
						Text = "Waiting for response...";
						Size = UDim2.fromOffset(400, 25);
						TextColor3 = Color3.fromRGB(0,0,0)
					})
					newCoroutine(function()
						wait(10)
						timedout = true
					end, "ResponseTimeoutGet")
					repeat wait() until response or timedout or err
					closeByName("ResponseTimeoutGet")
					if response then
						if GetPartFromPort(4, "Disk") then
							GetPartFromPort(4, "Disk"):Write("response", response)
							window:CreateElement("TextLabel", {
								BackgroundTransparency = 1;
								TextScaled = true;
								Text = "Response written to the 'response' key.";
								Size = UDim2.fromOffset(400, 25);
								Position = UDim2.fromOffset(0, 25);
								TextColor3 = Color3.fromRGB(0,0,0);
							})
							local okButton = window:CreateElement("TextButton", {
								Size = UDim2.fromOffset(50, 25);
								Position = UDim2.fromOffset(175, 175);
								Text = "OK";
								BackgroundColor3 = Color3.fromRGB(100,100,100);
								TextColor3 = Color3.fromRGB(0,0,0);
								TextScaled = true;
							})
							okButton.MouseButton1Click:Connect(function()
								initialize()
							end)
						else
							window:CreateElement("TextLabel", {
								BackgroundTransparency = 1;
								TextScaled = true;
								Text = "Insert a... Storage Device on the ethernet cable thats on the left part of your device.";
								Size = UDim2.fromOffset(400, 50);
								Position = UDim2.fromOffset(0, 25);
								TextColor3 = Color3.fromRGB(0,0,0);
							})
							local disk
							newCoroutine(function()
								while wait(0.5) do
									if GetPartFromPort(4, "Disk") then
										disk = GetPartFromPort(4, "Disk")
									end
								end
							end, "DiskWait")
							repeat wait() until disk
							disk:Write("response", response)
							window:CreateElement("TextLabel", {
								BackgroundTransparency = 1;
								TextScaled = true;
								Text = "Response written to the 'response' key.";
								Size = UDim2.fromOffset(400, 25);
								Position = UDim2.fromOffset(0, 75);
								TextColor3 = Color3.fromRGB(0,0,0);
							})
							local okButton = window:CreateElement("TextButton", {
								Size = UDim2.fromOffset(50, 25);
								Position = UDim2.fromOffset(175, 175);
								Text = "OK";
								BackgroundColor3 = Color3.fromRGB(100,100,100);
								TextColor3 = Color3.fromRGB(0,0,0);
								TextScaled = true;
							})
							okButton.MouseButton1Click:Connect(function()
								initialize()
							end)
						end
					else
						window:CreateElement("TextLabel", {
							BackgroundTransparency = 1;
							TextScaled = true;
							Text = "Website took too long to respond.";
							Size = UDim2.fromOffset(400, 25);
							Position = UDim2.fromOffset(0, 25);
							TextColor3 = Color3.fromRGB(0,0,0);
						})
						local okButton = window:CreateElement("TextButton", {
							Size = UDim2.fromOffset(50, 25);
							Position = UDim2.fromOffset(175, 175);
							Text = "OK";
							BackgroundColor3 = Color3.fromRGB(100,100,100);
							TextColor3 = Color3.fromRGB(0,0,0);
							TextScaled = true;
						})
						okButton.MouseButton1Click:Connect(function()
							initialize()
							go(memory) go(headers) go(data)
						end)
					end
				end
			end
			local function post()
				if busy == false then
					busy = true
					local err
					local function errored(boom)
						closeByName("ResponseTimeout")
						err = boom
						print(boom)
					end
					local response
					local timedout = false
					local success
					newCoroutine(function()
						local success, fail = pcall(function()
							response, success = modem:PostAsync(memory.domain, JSONEncode(data),Enum.HttpContentType.ApplicationJson, false, headers)
						end)
						if not success then
							errored(fail)
						end
					end, "PostRequest")
					window:ClearElements()
					window:CreateElement("TextLabel", {
						BackgroundTransparency = 1;
						TextScaled = true;
						Text = "Waiting for response...";
						Size = UDim2.fromOffset(400, 25);
						TextColor3 = Color3.fromRGB(0,0,0)
					})
					newCoroutine(function()
						wait(10)
						timedout = true
					end, "ResponseTimeout")
					repeat wait() until response or timedout or err
					closeByName("ResponseTimeout")
					if response then
						if GetPartFromPort(4, "Disk") then
							GetPartFromPort(4, "Disk"):Write("response", response)
							window:CreateElement("TextLabel", {
								BackgroundTransparency = 1;
								TextScaled = true;
								Text = "Response written to the 'response' key.";
								Size = UDim2.fromOffset(400, 25);
								Position = UDim2.fromOffset(0, 25);
								TextColor3 = Color3.fromRGB(0,0,0);
							})
							local okButton = window:CreateElement("TextButton", {
								Size = UDim2.fromOffset(50, 25);
								Position = UDim2.fromOffset(175, 175);
								Text = "OK";
								BackgroundColor3 = Color3.fromRGB(100,100,100);
								TextColor3 = Color3.fromRGB(0,0,0);
								TextScaled = true;
							})
							okButton.MouseButton1Click:Connect(function()
								initialize()
							end)
						else
							window:CreateElement("TextLabel", {
								BackgroundTransparency = 1;
								TextScaled = true;
								Text = "Insert a... Storage Device on the ethernet cable thats on the left part of your device.";
								Size = UDim2.fromOffset(400, 50);
								Position = UDim2.fromOffset(0, 25);
								TextColor3 = Color3.fromRGB(0,0,0);
							})
							local disk
							newCoroutine(function()
								while wait(0.5) do
									if GetPartFromPort(4, "Disk") then
										disk = GetPartFromPort(4, "Disk")
									end
								end
							end, "DiskWait")
							repeat wait() until disk
							disk:Write("response", response)
							window:CreateElement("TextLabel", {
								BackgroundTransparency = 1;
								TextScaled = true;
								Text = "Response written to the 'response' key.";
								Size = UDim2.fromOffset(400, 25);
								Position = UDim2.fromOffset(0, 75);
								TextColor3 = Color3.fromRGB(0,0,0);
							})
							local okButton = window:CreateElement("TextButton", {
								Size = UDim2.fromOffset(50, 25);
								Position = UDim2.fromOffset(175, 175);
								Text = "OK";
								BackgroundColor3 = Color3.fromRGB(100,100,100);
								TextColor3 = Color3.fromRGB(0,0,0);
								TextScaled = true;
							})
							okButton.MouseButton1Click:Connect(function()
								initialize()
							end)
						end
					else
						window:CreateElement("TextLabel", {
							BackgroundTransparency = 1;
							TextScaled = true;
							Text = "Website took too long to respond.";
							Size = UDim2.fromOffset(400, 25);
							Position = UDim2.fromOffset(0, 25);
							TextColor3 = Color3.fromRGB(0,0,0);
						})
						local okButton = window:CreateElement("TextButton", {
							Size = UDim2.fromOffset(50, 25);
							Position = UDim2.fromOffset(175, 175);
							Text = "OK";
							BackgroundColor3 = Color3.fromRGB(100,100,100);
							TextColor3 = Color3.fromRGB(0,0,0);
							TextScaled = true;
						})
						okButton.MouseButton1Click:Connect(function()
							initialize()
							go(memory) go(headers) go(data)
						end)
					end
					busy = false
				end
			end
			function initialize()
				go(memory) go(headers) go(data)
				focused = "domain"
				currentlyOpen = "main"
				window:ClearElements()
				system.domain = window:CreateElement("TextLabel", {
					Size = UDim2.fromOffset(380, 25);
					Position = UDim2.fromOffset(10, 10);
					Text = "Domain: " .. memory.domain;
					BackgroundColor3 = Color3.fromRGB(100,100,100);
					TextColor3 = Color3.fromRGB(0,0,0);
					TextScaled = true;
				})
				local dataButton = window:CreateElement("TextButton", {
					Size = UDim2.fromOffset(380, 25);
					Position = UDim2.fromOffset(10, 45);
					Text = "Data...";
					BackgroundColor3 = Color3.fromRGB(100,100,100);
					TextColor3 = Color3.fromRGB(0,0,0);
					TextScaled = true;
				})
				local headerButton = window:CreateElement("TextButton", {
					Size = UDim2.fromOffset(380, 25);
					Position = UDim2.fromOffset(10, 80);
					Text = "Headers...";
					BackgroundColor3 = Color3.fromRGB(100,100,100);
					TextColor3 = Color3.fromRGB(0,0,0);
					TextScaled = true;
				})
				local sendButton = window:CreateElement("TextButton", {
					Text = "Send";
					TextColor3 = Color3.fromRGB(0,0,0);
					TextScaled = true;
					Size = UDim2.fromOffset(100, 25);
					Position = UDim2.fromOffset(150, 190);
					BackgroundColor3 = Color3.fromRGB(100,100,100);
				})
				dataButton.MouseButton1Click:Connect(function()
					openDataMenu()
				end)
				headerButton.MouseButton1Click:Connect(function()
					openHeaderMenu()
				end)
				sendButton.MouseButton1Click:Connect(function()
					send()
				end)
			end
			initialize()
			xConnect("keyboard", "TextInputted", 
				function(text, plr)
					if window:IsActive() and window ~= nil then
						text = string.sub(text, 1, #text - 1)
						Beep()
						if currentlyOpen == focusLogic[focused] then
							if memory[focused] ~= nil then 
								if system[focused] ~= nil then
									system[focused].Text = prefixes[focused] .. text
									memory[focused] = text
								end
							end
						end
					end
				end, "postomatic")
		end
		postomatic.MouseButton1Click:Connect(function()
			if postomaticOpen ~= true then
				openPostOMatic()
			end
		end)
		if mic ~= nil then
			local listeningto
			local listening = false
			mic.Chatted:Connect(function(plr, text)
				if voicecommands == true then
					if text == "hey puter" and listening == false then
						listeningto = plr
						listening = true
					elseif string.sub(text, 1, 7) == "Jarvis," then
						local failed, reason = check(string.sub(text, 9, #text), plr)
						if failed == true then
							errorPopup(reason)
						end
					elseif string.sub(text, 1, 6) == "puter," then
						local failed, reason = check(string.sub(text, 8, #text), plr)
						if failed == true then
							errorPopup(reason)
						end
					elseif listening == true and plr == listeningto then
						local failed, reason = check(text, plr)
						if failed == true then
							errorPopup(reason)
						end
						listening = false
						listeningto = nil
					end
					if recording == true then
						recorded[#recorded + 1] = "[" .. plr .. "]: " .. text
					end
				end
			end)
		end
		test.MouseButton1Click:Connect(function()
			if canopenterminal == true then	
				local polysilicon = GetPartFromPort(6, "Polysilicon")
				local terminalmicrocontroller = GetPartFromPort(6, "Microcontroller")
				canopenterminal = false
				local shell = "check"
				local ver = "wOS Codename BasicSystem, made by 0mori2"
				puterutils.cliengine(function(text, plr, terminalout, clear, chprefix)
					local shenv = {}
					local function outputstd(text)
						terminalout(text, Color3.fromRGB(255,255,255))
					end
					local function outputerr(text)
						terminalout(text, Color3.fromRGB(255,0,0))
					end
					if shell == "check" then
						if text ~= "command" then
							local failed, reason = check(text, plr, terminalout, clear)
							if failed == true then
								outputerr(reason)
							end
							if recordingtext == true then
								recordedtext[#recordedtext + 1] = "[" .. plr .. "]: " .. text
							end
						else
							shell = "command"
							outputstd("Switching to command.")
						end
					else
						local success, fail = pcall(function()
							local success, reason = command(text, plr, terminalout, clear)
							if not success then
								outputstd(reason)
							end
						end)
						if not success then print(fail) end
					end
				end, "Terminal", ver, function()
					canopenterminal = true
				end, "wOS ", Color3.fromRGB(85, 170, 255))
			end
		end)
		local canopennetworking = true
		local canopenpreferences = true
		local canopenpersonalization = true
		settingsbutton.MouseButton1Click:Connect(function()
			if canspawnsettings == true then
				local settingswindow, closebtn = puter.CreateWindow(450, 300, "Settings", Color3.fromRGB(50,50,50))
				canspawnsettings = false
				local networking = puter.AddWindowElement(settingswindow, "TextButton", {
					Text = "Networking";
					Position = UDim2.fromOffset(25, 25);
					Size = UDim2.fromOffset(175, 50);
					TextScaled = true;
				})
				local preferences = puter.AddWindowElement(settingswindow, "TextButton", {
					Text = "Preferences";
					Position = UDim2.fromOffset(250, 25);
					Size = UDim2.fromOffset(175, 50);
					TextScaled = true;
				})
				local personalization = puter.AddWindowElement(settingswindow, "TextButton", {
					Text = "Personalization";
					Position = UDim2.fromOffset(25, 100);
					Size = UDim2.fromOffset(175, 50);
					TextScaled = true;
				})
				networking.MouseButton1Click:Connect(function()
					--haha funny cat image placeholder
					local wawa
					local unwawa
					if canopennetworking == true then
						wawa = puter.AddWindowElement(settingswindow, "ImageLabel", {
							Image = "http://www.roblox.com/asset/?id=10630555127";
							Position = UDim2.fromOffset(75, 75);
							Size = UDim2.fromOffset(200, 200)
						})
						unwawa = puter.AddWindowElement(settingswindow, "TextButton", {
							Text = "Close";
							Position = UDim2.fromOffset(125, 125);
							Size = UDim2.fromOffset(200, 50);
							BackgroundColor3 = Color3.fromRGB(255,0,0);
							TextScaled = true;
						})
						canopennetworking = false
					end
					unwawa.MouseButton1Click:Connect(function()
						wawa:Destroy()
						unwawa:Destroy()
						canopennetworking = true
					end)
				end)
				preferences.MouseButton1Click:Connect(function()
					if canopenpreferences == true then
						local tempvoicecommands = voicecommands
						local preferenceswindow, closebutton, titlebar = puter.CreateWindow(300, 300, "Preferences", Color3.fromRGB(100, 100, 100))
						closebutton.MouseButton1Click:Connect(function()
							canopenpreferences = true
						end)
						canopenpreferences = false
						local apply = puter.AddWindowElement(preferenceswindow, "TextButton", {
							Text = "Apply";
							TextScaled = true;
							TextColor3 = Color3.fromRGB(0,0,0);
							Size = UDim2.fromOffset(50, 25);
							Position = UDim2.fromOffset(240, 265);
							BackgroundColor3 = Color3.fromRGB(85, 85, 85);
							BorderSizePixel = 0;
						})
						apply.MouseButton1Click:Connect(function()
							if tempvoicecommands ~= nil then
								voicecommands = tempvoicecommands
								if storage ~= nil then
									if tempvoicecommands == true then
										storage:Write("voicecommands", "true")
									else
										storage:Write("voicecommands", "false")
									end
								end
							end
						end)
						local cancel = puter.AddWindowElement(preferenceswindow, "TextButton", {
							Text = "Cancel";
							TextScaled = true;
							TextColor3 = Color3.fromRGB(0,0,0);
							Size = UDim2.fromOffset(50, 25);
							Position = UDim2.fromOffset(180, 265);
							BackgroundColor3 = Color3.fromRGB(85, 85, 85);
							BorderSizePixel = 0;
						})
						cancel.MouseButton1Click:Connect(function()
							titlebar:Destroy()
							canopenpreferences = true
						end)
						local ok = puter.AddWindowElement(preferenceswindow, "TextButton", {
							Text = "OK";
							TextScaled = true;
							TextColor3 = Color3.fromRGB(0,0,0);
							Size = UDim2.fromOffset(50, 25);
							Position = UDim2.fromOffset(120, 265);
							BackgroundColor3 = Color3.fromRGB(85, 85, 85);
							BorderSizePixel = 0;
						})
						ok.MouseButton1Click:Connect(function()
							if tempvoicecommands ~= nil then
								voicecommands = tempvoicecommands
								if storage ~= nil then
									if tempvoicecommands == true then
										storage:Write("voicecommands", "true")
									else
										storage:Write("voicecommands", "false")
									end
								end
							end
							titlebar:Destroy()
							canopenpreferences = true
						end)
						local voicelabel = puter.AddWindowElement(preferenceswindow, "TextLabel", {
							Text = "Voice Commands:";
							Size = UDim2.fromOffset(200, 25);
							Position = UDim2.fromOffset(10, 10);
							TextScaled = true;
							TextColor3 = Color3.fromRGB(255,255,255);
							BackgroundTransparency = 1;
						})
						local voicebutton
						if tempvoicecommands == true then
							voicebutton = puter.AddWindowElement(preferenceswindow, "TextButton", {
								Text = "ON";
								BackgroundColor3 = Color3.fromRGB(0,255,0);
								TextColor3 = Color3.fromRGB(0,0,0);
								Size = UDim2.fromOffset(50, 25);
								TextScaled = true;
								Position = UDim2.fromOffset(240, 10);
							})
						else
							voicebutton = puter.AddWindowElement(preferenceswindow, "TextButton", {
								Text = "OFF";
								BackgroundColor3 = Color3.fromRGB(255,0,0);
								TextColor3 = Color3.fromRGB(0,0,0);
								Size = UDim2.fromOffset(50, 25);
								TextScaled = true;
								Position = UDim2.fromOffset(240, 10);
							})
						end
						voicebutton.MouseButton1Click:Connect(function()
							if tempvoicecommands == true then
								tempvoicecommands = false
								voicebutton.Text = "OFF"; voicebutton.BackgroundColor3 = Color3.fromRGB(255,0,0)
							else
								tempvoicecommands = true
								voicebutton.Text = "ON"; voicebutton.BackgroundColor3 = Color3.fromRGB(0,255,0)
							end
						end)
					end
				end)
				personalization.MouseButton1Click:Connect(function()
					if canopenpersonalization == true then
						local window, closebutton, titlebar = puter.CreateWindow(350, 300, "Personalization")
						closebutton.MouseButton1Click:Connect(function()
							canopenpersonalization = true
						end)
						canopenpersonalization = false
						window:CreateElement("TextLabel", {
							Size = UDim2.fromOffset(350, 25);
							Position = UDim2.fromOffset(0, 0);
							BackgroundTransparency = 1;
							BorderSizePixel = 0;
							Text = "Under construction, stay away!";
							TextScaled = true;
							TextColor3 = Color3.fromRGB(255,255,255);
						})
					end
				end)
				closebtn.MouseButton1Click:Connect(function()
					canopennetworking = true
					canspawnsettings = true
				end)
			end
		end)
		--main loop
		while running do
			local tempCursorPositions = tableReplicate(cursorPositions)
			wait(2.5)
			for plrName, cursor in pairs(cursors) do
				if tempCursorPositions[plrName] == cursorPositions[plrName] then
					cursor:Destroy()
					cursors[plrName] = nil
					cursorPositions[plrName] = nil
					cursorshouldexist[plrName] = nil
				end
			end
		end
	end
end)
if success == true then

else
	if errorcode ~= "Insufficient Power" then
		ReturnError(errorcode, "CREATOR_SKILL_ISSUE")
	else
		ReturnError(errorcode, "INSUFFICIENT_POWER")
	end
end
