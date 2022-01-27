# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("lib", __dir__)
require "brl/auth/version"

Gem::Specification.new do |s|
  s.name        = "brl_auth"
  s.version     = BRL::Auth::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Danilo Carolino"]
  s.email       = ["danilo.carolino@qflash.com.br"]
  s.homepage    = "https://github.com/Quasar-Flash/brl_auth_ruby"
  s.summary     = "BRL Auth Library"
  s.description = "Módulo de autenticação para API da BRL para projetos em Ruby"
  s.required_ruby_version = ">= 2.5"
  s.files = Dir["{lib}/**/*"] + ["LICENSE.txt", "Rakefile", "README.md", "CHANGELOG.md"]
  s.test_files = Dir["spec/**/*"]
  s.license = "MIT"

  s.metadata["changelog_uri"] = "https://github.com/Quasar-Flash/brl_auth_ruby/blob/master/CHANGELOG.md"
  s.metadata["source_code_uri"] = "https://github.com/Quasar-Flash/brl_auth_ruby"
  s.metadata["bug_tracker_uri"] = "https://github.com/Quasar-Flash/brl_auth_ruby/issues"

  s.add_dependency             "base64", "~> 0.1.0"
  s.add_dependency             "flash_integration", "~> 0.1.0"
  s.add_dependency             "i18n", ">= 1.8", "< 1.10"
  s.add_dependency             "json", ">= 2.5.1", "< 2.7.0"

  s.add_development_dependency "bundler", "~> 2.2.25", ">= 2.0"
  s.add_development_dependency "factory_bot", "~> 6.2.0"
  s.add_development_dependency "gemsurance", "~> 0.10"
  s.add_development_dependency "pry", "~> 0.14.1"
  s.add_development_dependency "rake", "~> 13.0.6", ">= 10.0.0"
  s.add_development_dependency "rspec", "~> 3.10.0"
  s.add_development_dependency "rubocop", "~> 1.20"
  s.add_development_dependency "rubocop-packaging", "~> 0.5.1"
  s.add_development_dependency "rubocop-performance", "~> 1.12.0"
  s.add_development_dependency "simplecov", "~> 0.21.2"
end
