#!/bin/lua

posix = require "posix"
time = require "posix.sys.time"

side = {
		left = 1,
		center = 2,
		right = 3,
}

local quit = false
local dirty = true

renderSpots = {}
for k,v in pairs(side) do renderSpots[v] = {} end
function registerRenderSpot(name, side)
		table.insert(renderSpots[side], {name = name, content = ""}) 
		return {side = side, id = #renderSpots[side]}
end

function renderTo(id, data)
		local spot = renderSpots[id.side][id.id]
		if spot.content ~= data then
				dirty = true
				spot.content = data
		end
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
		if dirty then
				local cache = ""
				for id,spots in pairs(renderSpots) do 
						if id == side.right then cache = cache .. "%{r}"
						elseif id == side.center then cache = cache .. "%{c}"
						elseif id == side.left then cache = cache .. "%{l}" end 
						for _,spot in pairs(spots) do
								cache = cache .. spot.content
						end
				end
				cache = cache .. "\n"
				bar:write(cache)
				bar:flush()
		end
		posix.sleep(1)
end

for k,v in pairs(modules) do
		v.stop()
end
