Gem::Specification.new do |spec|
  spec.name          = "study_gem_controllers_and_models"
  spec.version       = "0.1.0"
  spec.authors       = ["StrongerProgrammer"]
  spec.email         = ["swat55551@gmail.com"]
  spec.summary       = "Gem is study, include class controllers and models"
  spec.description   = "Gem: Model Guard, Owner, Auto and records arrival/leaving"
  spec.homepage      = "https://rubygems.org/gems/controllers_models"
  spec.license       = "MIT"


  spec.files         = Dir["./controller/*.rb","./DIAGRAM/Main.png","./model_auto/*","./model_entity/*","./model_person/*","./doc"]
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "fox,mysql"
  spec.add_development_dependency "log", "~> 2.0"
end
