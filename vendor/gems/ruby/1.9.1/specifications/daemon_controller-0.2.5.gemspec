# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "daemon_controller"
  s.version = "0.2.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Hongli Lai"]
  s.date = "2010-01-13"
  s.description = "A library for robust daemon management."
  s.email = "hongli@phusion.nl"
  s.homepage = "http://github.com/FooBarWidget/daemon_controller/tree/master"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.11"
  s.summary = "A library for implementing daemon management capabilities"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
