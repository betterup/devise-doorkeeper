require 'faker'
require 'factory_girl_rspec'
require 'factory_bot_rails'
FactoryBot.definition_file_paths = [
  File.join(__dir__, '../factories')
]
