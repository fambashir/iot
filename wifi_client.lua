print(wifi.sta.getip())
wifi.setmode(wifi.STATION)
wifi.sta.config {ssid="xamNayatel", pwd="xamnetworks"}
print(wifi.sta.getip())

