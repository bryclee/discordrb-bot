require 'rake/testtask'

# Run tests
Rake::TestTask.new do |t|
    t.libs << "tests"
    puts FileList['tests/test*.rb']
    t.test_files = FileList['tests/test*.rb']
    t.verbose = true
end