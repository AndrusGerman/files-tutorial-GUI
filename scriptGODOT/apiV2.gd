extends Node

# class member variables go here, for example:
var puerto = 8080
# var b = "textvar"

func GET(delay,ruta):
	var err = 0
	var http = HTTPClient.new() # Create the Client
	http.connect_to_host("http://localhost",puerto) # Connect to host/port

	while http.get_status() == HTTPClient.STATUS_CONNECTING or http.get_status() == HTTPClient.STATUS_RESOLVING:
		http.poll()
		OS.delay_msec(delay)
		
	# Some headers
	var headers = ["Content-Type: application/json"]
	
	http.request(HTTPClient.METHOD_GET, ruta, headers) # Request a page from the site (this one was chunked..)
	
	while http.get_status() == HTTPClient.STATUS_REQUESTING:
		# Keep polling until the request is going on
		http.poll()
		OS.delay_msec(delay)
	
	
	if http.has_response() == false:
		return JSON.parse('{"status":"bad","live":false}')
	var text = ""
	if http.has_response():
        # If there is a response..

		var rb = PoolByteArray() # Array that will hold the data

		while http.get_status() == HTTPClient.STATUS_BODY:
            # While there is body left to be read
			http.poll()
			var chunk = http.read_response_body_chunk() # Get a chunk
			if chunk.size() == 0:
                # Got nothing, wait for buffers to fill a bit
				OS.delay_usec(delay)
			else:
				rb = rb + chunk # Append to read buffer
				
		text = rb.get_string_from_utf8()
	var resulatado = JSON.parse(text)
	return resulatado.result

func POST(delay,ruta,data):
	var err = 0
	var http = HTTPClient.new() # Create the Client
	http.connect_to_host("http://localhost",puerto) # Connect to host/port
    # Wait until resolved and connected
	while http.get_status() == HTTPClient.STATUS_CONNECTING or http.get_status() == HTTPClient.STATUS_RESOLVING:
		http.poll()
		OS.delay_msec(delay)
		
	# Some headers
	var headers = ["Content-Type: application/json"]
	# Request a page from the site (this one was chunked..)
	http.request(HTTPClient.METHOD_POST, ruta, headers,data) 
	
	while http.get_status() == HTTPClient.STATUS_REQUESTING:
		# Keep polling until the request is going on
		http.poll()
		OS.delay_msec(delay)
	
	
	var text = ""
	if http.has_response():
        # If there is a response..

		var rb = PoolByteArray() # Array that will hold the data

		while http.get_status() == HTTPClient.STATUS_BODY:
            # While there is body left to be read
			http.poll()
			var chunk = http.read_response_body_chunk() # Get a chunk
			if chunk.size() == 0:
                # Got nothing, wait for buffers to fill a bit
				OS.delay_usec(delay)
			else:
				rb = rb + chunk # Append to read buffer
				
		text = rb.get_string_from_utf8()
	var resulatado = JSON.parse(text)
	return resulatado.result

func DELETE(delay,ruta,data):
	var err = 0
	var http = HTTPClient.new() # Create the Client
	http.connect_to_host("http://localhost",puerto) # Connect to host/port
    # Wait until resolved and connected
	while http.get_status() == HTTPClient.STATUS_CONNECTING or http.get_status() == HTTPClient.STATUS_RESOLVING:
		http.poll()
		OS.delay_msec(delay)
		
	# Some headers
	var headers = ["Content-Type: application/json"]
	# Request a page from the site (this one was chunked..)
	http.request(HTTPClient.METHOD_DELETE, ruta, headers,data) 
	
	while http.get_status() == HTTPClient.STATUS_REQUESTING:
		# Keep polling until the request is going on
		http.poll()
		OS.delay_msec(delay)
	
	
	var text = ""
	if http.has_response():
        # If there is a response..

		var rb = PoolByteArray() # Array that will hold the data

		while http.get_status() == HTTPClient.STATUS_BODY:
            # While there is body left to be read
			http.poll()
			var chunk = http.read_response_body_chunk() # Get a chunk
			if chunk.size() == 0:
                # Got nothing, wait for buffers to fill a bit
				OS.delay_usec(delay)
			else:
				rb = rb + chunk # Append to read buffer
				
		text = rb.get_string_from_utf8()
	var resulatado = JSON.parse(text)
	return resulatado.result