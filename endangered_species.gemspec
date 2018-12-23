lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'endangered_species/version'

Gem::Specification.new do |spec|
  spec.name          = 'endangered_species_2'
  spec.version       = EndangeredSpecies::VERSION
  spec.authors       = ['endotnick']
  spec.email         = ['endotnick@gmail.com']

  spec.summary       = 'CLI Data gem scraping www.worldwildlife.org'
  spec.homepage      = 'https://github.com/endotnick/endangered_species'
  spec.license       = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.executables   << 'endangered-species'
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'nokogiri', '>= 1.8'
  spec.add_runtime_dependency 'word_wrap', '>= 1'
  spec.add_runtime_dependency 'rainbow', '>= 3'

  spec.add_development_dependency 'bundler', '~> 1.17'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '>= 0.6'
end
