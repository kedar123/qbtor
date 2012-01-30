# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "wicked_pdf"
  s.version = "0.7.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Miles Z. Sterret"]
  s.date = "2011-07-07"
  s.description = "Wicked PDF uses the shell utility wkhtmltopdf to serve a PDF file to a user from HTML.\nIn other words, rather than dealing with a PDF generation DSL of some sort,\nyou simply write an HTML view as you would normally, and let Wicked take care of the hard stuff.\n"
  s.email = "miles.sterrett@gmail.com"
  s.homepage = "http://github.com/mileszs/wicked_pdf"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.11"
  s.summary = "PDF generator (from HTML) plugin for Ruby on Rails"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
