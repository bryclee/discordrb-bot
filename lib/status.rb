class StatusCommands
    def initialize(respond_channels: false, respond_servers: false)
        @respond_channels = respond_channels
        @respond_servers = respond_servers
    end
    
    def add_to(bot)
        if @respond_servers
            bot.mention(content: /<@.*> servers/) do |event|
                event.respond get_servers(bot)
            end
        end
        
        if @respond_channels
            bot.mention(content: /<@.*> channels/) do |event|
                event.respond get_channels(bot)
            end
        end
    end
end

def get_servers(bot)
    bot.servers.map {|key, server| server.name}.join(', ')
end

def get_channels(bot)
	bot.servers.flat_map {|key, server| server.channels.map {|channel| channel.name}}.join(", ")
end