# Add Hots scraper integration to Bot
require './lib/hots/hots'

module HotsCommands
    module_function
    
    def enable_hots(bot)
        bot.message(with_text: /talents .*/) do |event|
            message = event.message.content
            match = /talents (?<hero>.*)/.match(message)
            hero = match['hero']
            
            hero = (normalize_name(hero)).capitalize
            query = HeroQuery.new(hero)
            data_table = query.get_talent_data

            event.respond 'hi' + data_table.length.to_s
        end
    end
end

def normalize_name(name)
    {
        'butcher' => 'the butcher'
    }[name] || name
end
