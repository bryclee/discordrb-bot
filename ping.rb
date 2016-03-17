# This simple bot responds to every "Ping!" message with a "Pong!"

require 'discordrb'
require 'dotenv' # Load credentials to env with https://github.com/bkeepers/dotenv
Dotenv.load

require './lib/misc' # Import MiscCommands module
require './lib/status' # Import StatusCommands module

LOGIN = ENV['LOGIN']
PASSWORD = ENV['PASSWORD']

FILENAME = 'list.txt'

bot = Discordrb::Bot.new LOGIN, PASSWORD # Configure Discord bot

# Add commands to bot
bot.message {|event| puts MiscCommands.log_message(event)}
bot.message(start_with: /meow/i) {|event| event.respond MiscCommands.meow()}

bot.mention(content: /<@.*> servers/) {|event| event.respond StatusCommands.get_servers(bot)}
bot.mention(content: /<@.*> channels/) {|event| event.respond StatusCommands.get_channels(bot)}

# Testing writing to file, reading from file
STORE_REGEX = /blee store (.*)/
bot.message(with_text: STORE_REGEX) do |event|
	f = open(FILENAME, 'a')
	f.puts(STORE_REGEX.match(event.message.content)[1])
	f.close()
	event.respond 'Store:' + STORE_REGEX.match(event.message.content)[1]
end

bot.message(with_text: /blee read store/) do |event|
	data = ''
	open(FILENAME, 'r') do |f|
		f.each_line do |line|
			data += line
		end
	end
	event.respond 'Store contains:'
	event.respond data
end

bot.message(with_text: /blee clear store/) do |event|
	begin # Try following actions, if something goes wrong go to rescue
		File.delete(FILENAME)
		event.respond 'Cleared store'
	rescue => e
		event.respond "Oops, couldn't clear store" # Using << doesn't cause bot to respond
		raise e
	end
end

# Run the bot
bot.run