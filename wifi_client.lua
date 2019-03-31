print(wifi.sta.getip())
wifi.setmode(wifi.STATION)
wifi.sta.config {ssid=WIFI.ssid, pwd=WIFI.pwd}
print(wifi.sta.getip())

