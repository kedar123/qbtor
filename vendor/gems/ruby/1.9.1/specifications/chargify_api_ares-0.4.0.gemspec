# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "chargify_api_ares"
  s.version = "0.4.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Michael Klett", "Nathan Verni", "Rodrigo Franco"]
  s.date = "2011-03-02"
  s.description = ""
  s.email = "support@chargify.com"
  s.extra_rdoc_files = ["LICENSE.txt", "README.md"]
  s.files = ["LICENSE.txt", "README.md"]
  s.homepage = "http://github.com/grasshopperlabs/chargify_api_ares"
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.11"
  s.summary = "A Chargify API wrapper for Ruby using ActiveResource"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
