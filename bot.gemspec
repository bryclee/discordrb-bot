# coding: utf-8
# skeleton from: http://learnrubythehardway.org/book/ex46.html
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "bot"
#   spec.version       = '1.0'
#   spec.authors       = ["Your Name Here"]
#   spec.email         = ["youremail@yourdomain.com"]
#   spec.summary       = %q{Short summary of your project}
#   spec.description   = %q{Longer description of your project.}
#   spec.homepage      = "http://domainforproject.com/"
#   spec.license       = "MIT"

  spec.files         = ['lib/bot.rb']
  spec.executables   = ['bin/bot']
  spec.test_files    = ['tests/test_bot.rb']
  spec.require_paths = ["lib"]
end