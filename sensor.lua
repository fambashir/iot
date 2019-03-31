-- distance calculation, called by the echo_callback function on falling edge.
function calculate(start_time, end_time)
    print("Calculate called")
	-- echo time (or high level time) in seconds
	local echo_time = (end_time - start_time) / 1000000

	-- got a valid reading
	if echo_time > 0 then
		-- distance = echo time (or high level time) in seconds * velocity of sound (340M/S) / 2
		local distance = echo_time * 340 / 2
		print("Distance: ", distance, distance * 3.28084 * 12)
		return distance * 3.28084 * 12
	end
	return -1000
end

-- echo callback function called on both rising and falling edges
function process_distance(level, time, eventcount, pin, map)
	print("CALLBACK CALLED ON LEVEL",map[pin], level, time, tmr.now(), eventcount)
	if level == 1 then
		-- rising edge (low to high)
		start = time
	else
		if start == nil then
			print("Start time wasn't recevied.....")
		else
			-- falling edge (high to low)
			m:publish(map[pin], calculate(start, time), 0, 0)
		end
	end
end

function process_distance_5(level, time, eventcount)
	process_distance(level, time, eventcount, 5, MAP)
end

function process_distance_6(level, time, eventcount)
	process_distance(level, time, eventcount, 6, MAP)
end

-- send trigger signal
function read_distances(pin)
	print("Setting trigger mode..")
	tmr.start(0)
	gpio.mode(pin, gpio.OUTPUT)
	gpio.write(pin, gpio.LOW)
	tmr.delay(4)
	gpio.write(pin, gpio.HIGH)
	tmr.delay(10)
	gpio.write(pin, gpio.LOW)
	gpio.mode(pin, gpio.INT)
	-- set callback function to be called both on rising and falling edges
	if pin == 5 then
		gpio.trig(pin, "both", process_distance_5)
    else
    	gpio.trig(pin, "both", process_distance_6)
    end
end