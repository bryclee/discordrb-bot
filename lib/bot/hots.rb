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

            results = query.get_talent_data_by_level

            event.respond('fi')
            # results.each do |row|
            #     event.respond "fo"
            # end
        end
    end
end

def normalize_name(name)
    {
        'butcher' => 'The Butcher'
    }[name] || name
end
