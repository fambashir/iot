WIFI = {ssid="ZAK-NS", pwd="haaniya123"}
MAP = {[5] = "/sensors/w1", [6] = "/sensors/w2", cmd="/cmd/wm1"}
MQQT = {host = "192.168.18.6", port =1883, secure = 0, auto_reconnect = 1}

dofile("wifi_client.lua")
tmr.alarm(1,2000, 1, function()
   if wifi.sta.getip()==nil then
      print(" Wait for IP --> "..wifi.sta.status())
   else
      print("New IP address is "..wifi.sta.getip())
      tmr.stop(1)
      print('Trying To Connect to MQQT')
      dofile("mqqt.lua")
   end
end)
