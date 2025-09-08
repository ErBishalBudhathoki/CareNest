#!/usr/bin/env ruby

require 'xcodeproj'

# Path to the Xcode project
project_path = 'Runner.xcodeproj'

# Open the project
project = Xcodeproj::Project.open(project_path)

# Get the main target
main_target = project.targets.find { |target| target.name == 'Runner' }

# Create Development scheme
development_scheme = Xcodeproj::XCScheme.new
development_scheme.add_build_target(main_target)
development_scheme.set_launch_target(main_target)
development_scheme.launch_action.build_configuration = 'Debug'
development_scheme.save_as(project_path, 'Development')

# Create Production scheme
production_scheme = Xcodeproj::XCScheme.new
production_scheme.add_build_target(main_target)
production_scheme.set_launch_target(main_target)
production_scheme.launch_action.build_configuration = 'Release'
production_scheme.save_as(project_path, 'Production')

# Save the project
project.save

puts "iOS schemes created successfully!"