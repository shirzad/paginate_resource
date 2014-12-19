# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'paginate_resource/version'

Gem::Specification.new do |spec|
  spec.name          = "paginate_resource"
  spec.version       = PaginateResource::VERSION
  spec.authors       = ["shirzad"]
  spec.email         = ["shirzad.kamawall@gmail.com"]
  spec.summary       = %q{paginate dataset by starting at a given resource}
  spec.description   = %q{Given a specific resource start paginating to next or previous resource while preserving order and arel conditions. }
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
end
