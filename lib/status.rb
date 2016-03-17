module StatusCommands
    extend self
    
    # Return list of server names
    def get_servers(bot)
        bot.servers.map {|key, server| server.name}.join(', ')
    end

    # Return list of channel names across all servers bot is in
    def get_channels(bot)
    	bot.servers.flat_map {|key, server| server.channels.map {|channel| channel.name}}.join(", ")
    end
end
