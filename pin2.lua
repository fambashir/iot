pin = 3
gpio.mode(pin,gpio.OUTPUT)
gpio.write(pin,gpio.LOW)
print("2: ", gpio.read(pin))
