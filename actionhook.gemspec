require_relative 'lib/actionhook/version'

Gem::Specification.new do |spec|
  spec.name          = "actionhook"
  spec.version       = Actionhook::VERSION
  spec.authors       = ["smsohan"]
  spec.email         = ["sohan39@gmail.com"]

  spec.summary       = %q{Drop-in library for sending webhooks}
  spec.description   = %q{Use this library to send webhooks from your application}
  spec.homepage      = "https://github.com/smsohan/actionhook"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/smsohan/actionhook"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  sepc.add_development_dependency 'rspec'
end
