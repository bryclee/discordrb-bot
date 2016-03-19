# This simple bot responds to every "Ping!" message with a "Pong!"

require 'discordrb'
require 'dotenv' # Load credentials to env with https://github.com/bkeepers/dotenv
Dotenv.load

require './lib/misc' # Import MiscCommands module
require './lib/status' # Import StatusCommands module
require './lib/store' # Import StoreCommands module

LOGIN = ENV['LOGIN']
PASSWORD = ENV['PASSWORD']

bot = Discordrb::Bot.new LOGIN, PASSWORD # Configure Discord bot

# Add commands to bot
bot.message {|event| puts MiscCommands.log_message(event)}
bot.message(start_with: /meow/i) {|event| event.respond MiscCommands.meow()}

bot.mention(content: /<@.*> servers/) {|event| event.respond StatusCommands.get_servers(bot)}
bot.mention(content: /<@.*> channels/) {|event| event.respond StatusCommands.get_channels(bot)}

# Turn on store commands
StoreCommands.enableStore(bot)


# Run the bot
bot.run