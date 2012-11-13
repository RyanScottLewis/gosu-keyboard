# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "gosu-keyboard"
  s.version = "0.1.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ryan Scott Lewis"]
  s.date = "2012-11-13"
  s.description = "A DSL for easily defining keyboard events for a Gosu::Window"
  s.email = "ryan@rynet.us"
  s.files = [".gitignore", "Gemfile", "README.md", "Rakefile", "VERSION", "examples/simple.rb", "gosu-keyboard.gemspec", "lib/gosu/keyboard.rb", "lib/gosu/keyboard/dsl.rb", "lib/gosu/keyboard/dsl/helpers.rb"]
  s.homepage = "http://github.com/c00lryguy/gosu-keyboard"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.24"
  s.summary = "A nice DSL for handling a Gosu::Window's keyboard events"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<version>, ["~> 1.0.0"])
      s.add_runtime_dependency(%q<active_support>, ["~> 3"])
      s.add_runtime_dependency(%q<gosu>, ["~> 0.7.45"])
      s.add_development_dependency(%q<rake>, ["~> 0.9"])
    else
      s.add_dependency(%q<version>, ["~> 1.0.0"])
      s.add_dependency(%q<active_support>, ["~> 3"])
      s.add_dependency(%q<gosu>, ["~> 0.7.45"])
      s.add_dependency(%q<rake>, ["~> 0.9"])
    end
  else
    s.add_dependency(%q<version>, ["~> 1.0.0"])
    s.add_dependency(%q<active_support>, ["~> 3"])
    s.add_dependency(%q<gosu>, ["~> 0.7.45"])
    s.add_dependency(%q<rake>, ["~> 0.9"])
  end
end
