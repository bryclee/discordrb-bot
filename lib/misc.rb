class MiscCommands
    def initialize(log_message: false, respond_meow: false)
        @log_message = log_message
        @respond_meow = respond_meow
    end
    
    # Add commands to the bot provided
    def add_to(bot)
        
        if @log_message
            bot.message do |event|
                log_message(event)
            end
        end
            
        if @respond_meow
            bot.message(start_with: /meow/i) do |event|
                respond_meow(event)
            end
        end
    end
end

def log_message(event)
    puts event.message.inspect
end

def respond_meow(event)
    punctuations = '.!?'
    event.respond 'Meow' + punctuations[rand(punctuations.length)]
end