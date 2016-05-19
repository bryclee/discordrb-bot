require './lib/bot/misc'
require './lib/bot/status'
require './lib/bot/store'
require './lib/bot/hots'

class BleeBot < Discordrb::Bot
    def initialize(login, password)
        super
        
        # Add commands to bot
        self.message {|event| puts MiscCommands.log_message(event)}
        self.message(start_with: /meow/i) {|event| event.respond MiscCommands.meow()}

        self.mention(content: /<@.*> servers/) {|event| event.respond StatusCommands.get_servers(bot)}
        self.mention(content: /<@.*> channels/) {|event| event.respond StatusCommands.get_channels(bot)}
        
        # Turn on store commands
        StoreCommands.enable_store(self)
        
        # Turn on Hots commands!
        HotsCommands.enable_hots(self)
    end
end
