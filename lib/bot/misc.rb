module MiscCommands
    module_function # Make these functions available to the module
    
    # Output the contents of the message to console
    def log_message(event)
        puts event.message.inspect
    end
    
    # Create meow string with random punctuation
    def meow()
        punctuations = '.!?'
        'Meow' << punctuations[rand(punctuations.length)]
    end
end
