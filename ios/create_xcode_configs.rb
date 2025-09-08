#!/usr/bin/env ruby

require 'xcodeproj'

# Path to the Xcode project
project_path = 'Runner.xcodeproj'

# Open the project
project = Xcodeproj::Project.open(project_path)

# Get the main target
main_target = project.targets.find { |target| target.name == 'Runner' }

# Get the configurations
configurations = project.build_configurations

# Check if Debug-Production configuration exists
debug_production = configurations.find { |config| config.name == 'Debug-Production' }
unless debug_production
  # Create Debug-Production configuration by duplicating Debug
  debug_config = configurations.find { |config| config.name == 'Debug' }
  debug_production = project.add_build_configuration('Debug-Production', :debug)
  debug_production.base_configuration_reference = project.new_file('Flutter/Debug-Production.xcconfig')
  debug_production.build_settings.merge!(debug_config.build_settings)
  puts "Created Debug-Production configuration"
end

# Check if Release-Production configuration exists
release_production = configurations.find { |config| config.name == 'Release-Production' }
unless release_production
  # Create Release-Production configuration by duplicating Release
  release_config = configurations.find { |config| config.name == 'Release' }
  release_production = project.add_build_configuration('Release-Production', :release)
  release_production.base_configuration_reference = project.new_file('Flutter/Release-Production.xcconfig')
  release_production.build_settings.merge!(release_config.build_settings)
  puts "Created Release-Production configuration"
end

# Check if Debug-Development configuration exists
debug_development = configurations.find { |config| config.name == 'Debug-Development' }
unless debug_development
  # Create Debug-Development configuration by duplicating Debug
  debug_config = configurations.find { |config| config.name == 'Debug' }
  debug_development = project.add_build_configuration('Debug-Development', :debug)
  debug_development.base_configuration_reference = project.new_file('Flutter/Debug-Development.xcconfig')
  debug_development.build_settings.merge!(debug_config.build_settings)
  puts "Created Debug-Development configuration"
end

# Check if Release-Development configuration exists
release_development = configurations.find { |config| config.name == 'Release-Development' }
unless release_development
  # Create Release-Development configuration by duplicating Release
  release_config = configurations.find { |config| config.name == 'Release' }
  release_development = project.add_build_configuration('Release-Development', :release)
  release_development.base_configuration_reference = project.new_file('Flutter/Release-Development.xcconfig')
  release_development.build_settings.merge!(release_config.build_settings)
  puts "Created Release-Development configuration"
end

# Add configurations to the main target if needed
main_target.build_configurations.each do |config|
  if config.name == 'Debug-Production' || config.name == 'Release-Production' || config.name == 'Debug-Development' || config.name == 'Release-Development'
    puts "Configuration #{config.name} already exists in target"
  else
    if config.name == 'Debug'
      # Add Debug-Production to target
      new_config = main_target.add_build_configuration('Debug-Production', :debug)
      new_config.base_configuration_reference = project.new_file('Flutter/Debug-Production.xcconfig')
      new_config.build_settings.merge!(config.build_settings)
      puts "Added Debug-Production to target"
      
      # Add Debug-Development to target
      new_config = main_target.add_build_configuration('Debug-Development', :debug)
      new_config.base_configuration_reference = project.new_file('Flutter/Debug-Development.xcconfig')
      new_config.build_settings.merge!(config.build_settings)
      puts "Added Debug-Development to target"
    elsif config.name == 'Release'
      # Add Release-Production to target
      new_config = main_target.add_build_configuration('Release-Production', :release)
      new_config.base_configuration_reference = project.new_file('Flutter/Release-Production.xcconfig')
      new_config.build_settings.merge!(config.build_settings)
      puts "Added Release-Production to target"
      
      # Add Release-Development to target
      new_config = main_target.add_build_configuration('Release-Development', :release)
      new_config.base_configuration_reference = project.new_file('Flutter/Release-Development.xcconfig')
      new_config.build_settings.merge!(config.build_settings)
      puts "Added Release-Development to target"
    end
  end
end

# Update Production scheme to use the new configurations
production_scheme_path = "#{project_path}/xcshareddata/xcschemes/Production.xcscheme"
if File.exist?(production_scheme_path)
  scheme_content = File.read(production_scheme_path)
  
  # Update TestAction buildConfiguration
  scheme_content.gsub!(/TestAction buildConfiguration="Release"/, 'TestAction buildConfiguration="Debug-Production"')
  
  # Update LaunchAction buildConfiguration
  scheme_content.gsub!(/LaunchAction buildConfiguration="Release"/, 'LaunchAction buildConfiguration="Debug-Production"')
  
  # Update ProfileAction buildConfiguration
  scheme_content.gsub!(/ProfileAction buildConfiguration="Release"/, 'ProfileAction buildConfiguration="Release-Production"')
  
  # Update AnalyzeAction buildConfiguration
  scheme_content.gsub!(/AnalyzeAction buildConfiguration="Release"/, 'AnalyzeAction buildConfiguration="Debug-Production"')
  
  # Update ArchiveAction buildConfiguration
  scheme_content.gsub!(/ArchiveAction buildConfiguration="Release"/, 'ArchiveAction buildConfiguration="Release-Production"')
  
  File.write(production_scheme_path, scheme_content)
  puts "Updated Production scheme to use new configurations"
end

# Update Development scheme to use the new configurations
development_scheme_path = "#{project_path}/xcshareddata/xcschemes/Development.xcscheme"
if File.exist?(development_scheme_path)
  scheme_content = File.read(development_scheme_path)
  
  # Update TestAction buildConfiguration
  scheme_content.gsub!(/TestAction buildConfiguration="Debug"/, 'TestAction buildConfiguration="Debug-Development"')
  
  # Update LaunchAction buildConfiguration
  scheme_content.gsub!(/LaunchAction buildConfiguration="Debug"/, 'LaunchAction buildConfiguration="Debug-Development"')
  
  # Update ProfileAction buildConfiguration
  scheme_content.gsub!(/ProfileAction buildConfiguration="Release"/, 'ProfileAction buildConfiguration="Release-Development"')
  
  # Update AnalyzeAction buildConfiguration
  scheme_content.gsub!(/AnalyzeAction buildConfiguration="Debug"/, 'AnalyzeAction buildConfiguration="Debug-Development"')
  
  # Update ArchiveAction buildConfiguration
  scheme_content.gsub!(/ArchiveAction buildConfiguration="Release"/, 'ArchiveAction buildConfiguration="Release-Development"')
  
  File.write(development_scheme_path, scheme_content)
  puts "Updated Development scheme to use new configurations"
end

# Save the project
project.save

puts "Xcode configurations created successfully!"