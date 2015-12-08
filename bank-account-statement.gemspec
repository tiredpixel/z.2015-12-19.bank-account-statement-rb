# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bank-account-statement/version'

Gem::Specification.new do |spec|
  spec.name          = "bank-account-statement"
  spec.version       = BankAccountStatement::VERSION
  spec.authors       = ["tiredpixel"]
  spec.email         = ["tiredpixel@posteo.de"]
  
  spec.cert_chain  = [
    'certs/gem-public_cert-tiredpixel@posteo.de-2015-12-08.pem',
  ]
  spec.signing_key = File.expand_path("~/.ssh/gem-private_key.pem") if $0 =~ /gem\z/
  
  spec.summary       = %q{Bank account statement format transformation (HTML to OFX).}
  spec.description   = %q{}
  spec.homepage      = "https://github.com/tiredpixel/bank-account-statement-rb"
  spec.license       = "MIT"
  
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  
  spec.add_dependency "nokogiri", "~> 1.6"
  
  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.8"
  spec.add_development_dependency "minitest-reporters", "~> 1.1"
end
