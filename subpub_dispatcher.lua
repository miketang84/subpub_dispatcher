local zmq = require'bamboo.lib.zmqev'
local ev = require'ev'
local loop = ev.Loop.default
local ctx = zmq.init(loop, 1)

dofile('settings.lua')

local sub_in = sub_in_addr
local pub_out = pub_out_addr

local pub_channel = ctx:pub()
pub_channel:bind(pub_out)

-- define response handler
local function sub_handler(sock, data)

	-- 这里，我们就做一个简单的转发而已, data里面是什么都不用知道
	pub_channel:send(data)

end

local sub_channel = ctx:sub(sub_handler)
sub_channel:sub("")
sub_channel:bind(sub_in)

print('Dispatcher server start.')
loop:loop()

print('== Aborted! ==')
