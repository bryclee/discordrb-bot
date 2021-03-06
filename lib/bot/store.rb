module StoreCommands
    @filename = 'list.txt'
    
    module_function
    
    # Write a line to file
    def write(message)
        f = open(@filename, 'a')
        f.puts(message)
        f.close()
    end
    
    # Read all lines in file
    def read(start: 0, num: 10)
        f = open(@filename, 'r')
        # Iterate to start line
        start.times { f.gets }
        
        # Read lines start to last
        data = ''
        num.times {
            chunk = f.gets
            data << chunk unless chunk.nil?
        }
        
        f.close()
        return data
    end
    
    def clear()
        open(@filename, 'w')
        return nil
    end
    
    # Enable store functions for bot
    def enable_store(bot)
        # blee write <string>: Save <string> into store
        store_regex = /blee write (.*)/
        bot.message(with_text: store_regex) do |event|
        	message = store_regex.match(event.message.content)[1]
        	with_error_handling(event) do
		        StoreCommands.write(message)
        		event.respond "Stored: " + message
    	    end
        end

        # blee read: Reply with the first 10 lines from the store
        bot.message(with_text: /blee read/) do |event|
        	with_error_handling(event) do
        		data = StoreCommands.read()
        		if data.nil? || data.empty?
		        	event.respond "No data in store"
		        else
			        event.respond "Store contents:"
			        event.respond data
        		end
	        end
        end

        # blee clear: Clear the store file
        bot.message(with_text: /blee clear/) do |event|
	        with_error_handling(event) do
		        StoreCommands.clear()
        		event.respond "Cleared store"
        	end
        end 
    end
end

# Accepts a block, runs it and if an error occurs then returns the error
def with_error_handling(event)
	begin
		yield
	rescue => e
		event.respond "Had an error: " + e.class.to_s
		raise e
	end
end