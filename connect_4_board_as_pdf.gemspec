# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'connect_4_board_as_pdf/version'

Gem::Specification.new do |spec|
  spec.name          = "connect_4_board_as_pdf"
  spec.version       = Connect4BoardAsPdf::VERSION
  spec.authors       = ["Florian Loch"]
  spec.email         = ["florian.loch@gmail.com"]
  spec.summary       = ""
  spec.description   = ""
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = ['c4board2pdf']  
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_dependency "prawn"
  spec.add_dependency "commander"
  spec.add_dependency "colorize"
end
