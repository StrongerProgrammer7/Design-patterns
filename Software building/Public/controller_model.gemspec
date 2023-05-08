Gem::Specification.new do |spec|
  spec.name          = "study_gem_controllers_and_models"
  spec.version       = "0.1.0"
  spec.authors       = ["StrongerProgrammer"]
  spec.email         = ["swat55551@gmail.com"]
  spec.summary       = "Gem is study, include class controllers"
  spec.description   = "Gem is study, controllers"
  spec.homepage      = "https://rubygems.org/gems/controllers_models"
  spec.license       = "MIT"


  spec.files         = Dir["./controller/*.rb","./student_DB/*rb","./student_list/*.rb","./persons/*.rb","./datatable/*.rb","./list_file/*.rb","./doc"]
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "fox,mysql"
  spec.add_development_dependency "log", "~> 2.0"
end
