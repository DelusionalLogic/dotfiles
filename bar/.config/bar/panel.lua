#!/bin/lua

posix = require "posix"
time = require "posix.sys.time"
require "xColorProvider"

side = {
		left = 1,
		center = 2,
		right = 3,
}

local bar = io.popen("bar", "w")
local quit = false

utils = {}
utils_dir = posix.dir("utils")
for k,v in pairs(utils_dir) do
		if(v ~= "." and v ~= "..") then
				package.preload[v:gsub("%.lua", "")] = loadfile("utils/" .. v)
		end
end

modules = {}
modules_dir = posix.dir("active_modules_lua")
table.sort(modules_dir)
for k,v in pairs(modules_dir) do
		if(v ~= "." and v ~= "..") then
				env = setmetatable({}, {__index = _G})
				local f = loadfile("active_modules_lua/" .. v, "tb", env)()
				table.insert(modules, env)
		end
end

for k,v in pairs(modules) do
		v.start()
end

while not quit do
		local curTime = time.gettimeofday().tv_sec
		for _,v in pairs(modules) do
				v.update(curTime)
		end
		bar:flush()
		posix.sleep(1)
end

for k,v in pairs(modules) do
		v.stop()
end
