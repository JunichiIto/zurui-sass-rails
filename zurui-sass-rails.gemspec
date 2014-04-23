# -*- encoding: utf-8 -*-
require File.expand_path('../lib/zurui-sass-rails/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["mah_lab"]
  gem.email         = ["rootmoon@gmail.com"]
  gem.description   = %q{Sass mixins by zurui-design(https://speakerdeck.com/ken_c_lo/zurui-design)}
  gem.summary       = %q{Sass mixins by zurui-design(https://speakerdeck.com/ken_c_lo/zurui-design)}
  gem.homepage      = "https://github.com/mahm/zurui-sass-rails"

  gem.files         = Dir["{lib,vendor}/**/*"] + ["MIT-LICENSE", "README.md"]
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "zurui-sass-rails"
  gem.require_paths = ["lib"]
  gem.version       = ZuruiSassRails::VERSION

  gem.add_dependency "railties", ">= 4.0"

  # get an array of submodule dirs by executing 'pwd' inside each submodule
  puts "[INFO] start submodule"
  `git submodule --quiet foreach pwd`.split($\).each do |submodule_path|
    puts "[INFO] submodule_path: #{submodule_path}"
    # for each submodule, change working directory to that submodule
    Dir.chdir(submodule_path) do

      # issue git ls-files in submodule's directory
      submodule_files = `git ls-files`.split($\)
      puts "[INFO] submodule_files: #{submodule_files}"

      # prepend the submodule path to create absolute file paths
      submodule_files_fullpaths = submodule_files.map do |filename|
        "#{submodule_path}/#{filename}"
      end
      puts "[INFO] submodule_files_fullpaths: #{submodule_files_fullpaths}"

      # remove leading path parts to get paths relative to the gem's root dir
      # (this assumes, that the gemspec resides in the gem's root dir)
      submodule_files_paths = submodule_files_fullpaths.map do |filename|
        filename.gsub "#{File.dirname(__FILE__)}/", ""
      end
      puts "[INFO] submodule_files_paths: #{submodule_files_paths}"

      # add relative paths to gem.files
      gem.files += submodule_files_paths
      puts "[INFO] gem.files: #{gem.files}"
    end
  end
  puts "[INFO] end submodule"
end
