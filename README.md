# discordrb-bot

Discord bot in ruby created using [discordrb](https://github.com/meew0/discordrb).

## Starting

 * Requires ruby >= 2.1.0 for `discordrb`
 * Install from Gemfile with `bundle install` to install dependencies
   * See http://bundler.io/#getting-started for more info on gems. You may need to install `bundler` first.
 * Add credentials for bot to `.env`
  * Example in `.env.sample`
 * Run bot using `rake run`
 
## Rake commands
 * `rake run`: Start the bot. Executes `bin/bot.rb`
 * `rake test`: Run unit tests. Runs all test files in `tests` folder that begin with `test`.

## Bundler dependencies
 * discordrb: Discord bot in ruby
 * dotenv: Load .env key-values into environment for credentials, etc.
 
## Repo info
 * Executables are in the `bin` folder. The bot executable is bin/bot.rb
 * Lib files contain all other additional functionality.
 * Tests are in the `tests` folder.