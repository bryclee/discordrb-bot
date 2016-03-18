module StoreCommands
    @filename = 'list.txt'
    def initialize(name)
        @filename = name
    end
    
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
        File.delete(@filename)
    end
end
