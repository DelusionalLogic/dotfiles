versions = {
	["Lua 5.1"] = function()
		local np = io.popen("LUA_INIT=\"\" luarocks-5.1 path --lr-path", "r"):read("*all")
		local ncp = io.popen("LUA_INIT=\"\" luarocks-5.1 path --lr-cpath", "r"):read("*all")
		package.path = np .. ";" .. package.path
		package.cpath = ncp .. ";" .. package.cpath
	end,
	["Lua 5.2"] = function()
		local np = io.popen("LUA_INIT=\"\" luarocks-5.2 path --lr-path", "r"):read("*all")
		local ncp = io.popen("LUA_INIT=\"\" luarocks-5.2 path --lr-cpath", "r"):read("*all")
		package.path = np .. ";" .. package.path
		package.cpath = ncp .. ";" .. package.cpath
	end,
	["Lua 5.3"] = function()
		local np = io.popen("LUA_INIT=\"\" luarocks-5.3 path --lr-path", "r"):read("*all")
		local ncp = io.popen("LUA_INIT=\"\" luarocks-5.3 path --lr-cpath", "r"):read("*all")
		package.path = np .. ";" .. package.path
		package.cpath = ncp .. ";" .. package.cpath
	end,
}

versions[_VERSION]()
