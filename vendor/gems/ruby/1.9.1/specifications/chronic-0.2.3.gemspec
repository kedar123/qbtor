# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "chronic"
  s.version = "0.2.3"

  s.required_rubygems_version = nil if s.respond_to? :required_rubygems_version=
  s.authors = ["Tom Preston-Werner"]
  s.cert_chain = nil
  s.date = "2007-07-02"
  s.description = "Chronic is a natural language date/time parser written in pure Ruby. See below for the wide variety of formats Chronic will parse."
  s.email = "tom@rubyisawesome.com"
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt"]
  s.files = ["History.txt", "Manifest.txt", "README.txt"]
  s.homepage = "\thttp://chronic.rubyforge.org/"
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new("> 0.0.0")
  s.rubyforge_project = "chronic"
  s.rubygems_version = "1.8.11"
  s.summary = "A natural language date parser"

  if s.respond_to? :specification_version then
    s.specification_version = 1

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<hoe>, [">= 1.2.1"])
    else
      s.add_dependency(%q<hoe>, [">= 1.2.1"])
    end
  else
    s.add_dependency(%q<hoe>, [">= 1.2.1"])
  end
end
