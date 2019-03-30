print(wifi.sta.getip())

m_dis={}
function dispatch(m,t,pl)
	if pl~=nil and m_dis[t] then
		m_dis[t](m,pl)
	end
end

function pubfile(m,filename)
	file.close()
	file.open(filename)
	repeat
    local pl=file.read(1024)
    if pl then m:publish("/topic2",pl,0,0) end
  	until not pl
  	file.close()
end
-- payload(json): {"cmd":xxx,"content":xxx}
function topic1func(m,pl)
	print("get1: "..pl)
	local pack = sjson.decode(pl)
	if pack.content then
		if pack.cmd == "open" then file.open(pack.content,"w+")
		elseif pack.cmd == "write" then file.write(pack.content)
		elseif pack.cmd == "close" then file.close()
		elseif pack.cmd == "remove" then file.remove(pack.content)
		elseif pack.cmd == "run" then dofile(pack.content)
		elseif pack.cmd == "read" then pubfile(m, pack.content)
		end
	end
end

m_dis["/topic1"]=topic1func
-- Lua: mqtt.Client(clientid, keepalive, user, pass)
m=mqtt.Client()
m:on("connect",function(m) 
	print("connection "..node.heap()) 
	m:subscribe("/topic1",0,function(m) print("sub done") end)
	end )
m:on("offline", function(conn)
    print("disconnect to broker...")
    print(node.heap())
end)
m:on("message",dispatch )
-- Lua: mqtt:connect( host, port, secure, auto_reconnect, function(client) )
m:connect("192.168.100.36",1883,0,1)

