# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','tmxsuite','version.rb'])
spec = Gem::Specification.new do |s| 
  s.name = 'tmxsuite'
  s.version = Tmxsuite::VERSION
  s.author = 'Your Name Here'
  s.email = 'your@email.address.com'
  s.homepage = 'http://your.website.com'
  s.platform = Gem::Platform::RUBY
  s.summary = 'A description of your project'
# Add your other files here if you make them
  s.files = %w(
bin/tmxsuite
lib/tmxsuite/version.rb
lib/tmxsuite.rb
  )
  s.require_paths << 'lib'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.rdoc','tmxsuite.rdoc']
  s.rdoc_options << '--title' << 'tmxsuite' << '--main' << 'README.rdoc' << '-ri'
  s.bindir = 'bin'
  s.executables << 'tmxsuite'
  s.add_development_dependency('rake')
  s.add_development_dependency('rdoc')
  s.add_development_dependency('aruba')
  s.add_runtime_dependency('gli','2.5.4')
end