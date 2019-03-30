dofile("wifi_client.lua")
tmr.alarm(1,2000, 1, function()
   if wifi.sta.getip()==nil then
      print(" Wait for IP --> "..wifi.sta.status())
   else
      print("New IP address is "..wifi.sta.getip())
      tmr.stop(1)
      print('load DS18B20')
      dofile("mqqt.lua")
   end
end)
