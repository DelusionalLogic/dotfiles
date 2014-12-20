#!/bin/lua

class = require "30log"
posix = require "posix"
time = require "posix.sys.time"

side = {
		left = 1,
		center = 2,
		right = 3,
}

local quit = false

Renderer = class {cache = nil, calls = {}}

function Renderer:render(data, color)
		table.insert(self.calls, {data = data, color = color})
		self.cache = nil
end

function Renderer:clear()
		self.calls = {}
		self.cache = nil
end

function Renderer:output()
		local wasCached = true
		if self.cache == nil then
				wasCached = false
				local renderOut = ""
				for _,render in pairs(self.calls) do
						renderOut = renderOut .. "%{F" .. getColor(render.color) .. "}" .. render.data
				end
				self.cache = renderOut
		end
		return self.cache, wasCached
end

renderers = {}
for k,v in pairs(side) do renderers[v] = {} end
function getRenderer(name, side)
		local renderer = Renderer:new()
		table.insert(renderers[side], renderer) 
		return renderer
end

utils_dir = posix.dir("utils")
for k,v in pairs(utils_dir) do
		if(v ~= "." and v ~= "..") then
				package.preload[v:gsub("%.lua", "")] = loadfile("utils/" .. v)
		end
end

require "xColorProvider"

modules = {}
modules_dir = posix.dir("active_modules_lua")
table.sort(modules_dir)
for k,v in pairs(modules_dir) do
		if(v ~= "." and v ~= "..") then
				env = setmetatable({}, {__index = _G})
				print("Loading module " .. v)
				local f = loadfile("active_modules_lua/" .. v, "tb", env)()
				table.insert(modules, env)
		end
end

for k,v in pairs(modules) do
		v.start()
end

local bar = io.popen("bar -f -misc-stlarch-*-*-*-*-10-*-*-*-*-*-*-*,-*-terminus-*-*-*-*-12-*-*-*-*-*-*-*", "w")
while not quit do
		local curTime = time.gettimeofday().tv_sec
		for _,v in pairs(modules) do
				v.update(curTime)
		end
		local renderOut = ""
		for id,renderers in pairs(renderers) do 
				if id == side.right then renderOut = renderOut .. "%{r}"
				elseif id == side.center then renderOut = renderOut .. "%{c}"
				elseif id == side.left then renderOut = renderOut .. "%{l}" end 
				local isFirst = true
				for _,renderer in pairs(renderers) do
						if isFirst then
								isFirst = false
						else
								renderOut = renderOut .. " | "
						end
						renderOut = renderOut .. renderer:output()
				end
		end
		renderOut = renderOut .. "\n"
		bar:write(renderOut)
		bar:flush()
		posix.sleep(1)
end

for k,v in pairs(modules) do
		v.stop()
end
