require 'rake/testtask'

# Run tests
Rake::TestTask.new do |t|
    t.libs << "tests"
    t.test_files = FileList['tests/test*.rb']
    t.verbose = true
end

task :run do
    ruby 'bin/bot.rb'
end