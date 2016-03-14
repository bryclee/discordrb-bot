# This simple bot responds to every "Ping!" message with a "Pong!"

require 'discordrb'

EMAIL = ____ # enter email here
PW = _____ # enter password here

FILENAME = 'list.txt'

bot = Discordrb::Bot.new EMAIL, PW

bot.message(with_text: /meow/i) do |event|
	punctuations = '.!?'
	event << 'Meow' + punctuations[rand(punctuations.length)]
end

bot.message(with_text: /blee servers/) do |event|
	servers = bot.servers.map do |key, server|
		server.name
	end
	event.respond 'I see servers: ' + servers.join(", ")
end

bot.message(with_text: /blee channels/) do |event|
	channels = bot.servers.flat_map {|key, server| server.channels}
	event.respond 'I see channels: ' + channels.map {|channel| channel.name}.join(', ')
end

STORE_REGEX = /blee store (.*)/
bot.message(with_text: STORE_REGEX) do |event|
	f = open(FILENAME, 'a')
	puts 'Store:', STORE_REGEX.match(event.message.content)[1]
	f.puts(STORE_REGEX.match(event.message.content)[1])
	f.close()
end

bot.message(with_text: /blee read store/) do |event|
	data = ''
	open(FILENAME, 'r') do |f|
		f.each_line do |line|
			data += line
		end
	end
	event << data
end

bot.message(with_text: /blee clear store/) do |event|

end

bot.run