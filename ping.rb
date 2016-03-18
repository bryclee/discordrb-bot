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

# Testing writing to file, reading from file
STORE_REGEX = /blee store (.*)/
bot.message(with_text: STORE_REGEX) do |event|
	message = STORE_REGEX.match(event.message.content)[1]
	with_error_handling(event) do
		StoreCommands.write(message)
		event.respond "Stored: " + message
	end
end

bot.message(with_text: /blee read store/) do |event|
	with_error_handling(event) do
		data = StoreCommands.read()
		event.respond "Store contents:"
		event.respond data
	end
end

bot.message(with_text: /blee clear store/) do |event|
	with_error_handling(event) do
		StoreCommands.clear()
		event.respond "Cleard store"
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
	

# Run the bot
bot.run