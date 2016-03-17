# This simple bot responds to every "Ping!" message with a "Pong!"

require 'discordrb'
require 'dotenv' # Load credentials to env with https://github.com/bkeepers/dotenv
Dotenv.load

require './lib/misc'
require './lib/status'

LOGIN = ENV['LOGIN']
PASSWORD = ENV['PASSWORD']

FILENAME = 'list.txt'

bot = Discordrb::Bot.new LOGIN, PASSWORD # Configure Discord bot
# Configure commands to add to bot
misc_commands = MiscCommands.new(log_message: true, respond_meow: true)
status_commands = StatusCommands.new(respond_servers: true, respond_channels: true)

# Add commands to bot
misc_commands.add_to(bot)
status_commands.add_to(bot)


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