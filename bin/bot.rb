require 'discordrb'
require 'dotenv' # Load credentials to env with https://github.com/bkeepers/dotenv
Dotenv.load

require './lib/bot' # Require the bot lib files

LOGIN = ENV['LOGIN']
PASSWORD = ENV['PASSWORD']

bot = BleeBot.new LOGIN, PASSWORD # Configure Discord bot

# Run the bot
bot.run