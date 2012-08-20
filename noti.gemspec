$LOAD_PATH.unshift(File.expand_path('../lib', __FILE__))
require 'noti/version'

Gem::Specification.new do |s|
  s.name = 'noti'
  s.version = Noti::VERSION
  s.platform = Gem::Platform::RUBY
  s.summary = "Easy to use client library for Noti"
  s.files = Dir["lib/noti.rb", 'lib/noti/**/*.rb']
  s.bindir = "bin"
  s.require_path = 'lib'
  s.has_rdoc = false
  s.author = "Adam Cooke"
  s.email = "adam@atechmedia.com"
  s.homepage = "http://notiapp.com"
  s.add_dependency('json')
end
