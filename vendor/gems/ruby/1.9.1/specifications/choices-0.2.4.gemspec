# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "choices"
  s.version = "0.2.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Mislav Marohni\u{c4}\u{87}"]
  s.date = "2011-02-18"
  s.email = "mislav.marohnic@gmail.com"
  s.homepage = "http://github.com/mislav/choices"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.11"
  s.summary = "Easy settings for your app"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<hashie>, [">= 0.4.0"])
    else
      s.add_dependency(%q<hashie>, [">= 0.4.0"])
    end
  else
    s.add_dependency(%q<hashie>, [">= 0.4.0"])
  end
end
