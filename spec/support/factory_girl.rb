require 'faker'
require 'factory_girl_rspec'
require 'factory_girl_rails'
FactoryGirl.definition_file_paths = [
  File.join(__dir__, '../factories')
]
