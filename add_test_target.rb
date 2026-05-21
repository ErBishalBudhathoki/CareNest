require 'xcodeproj'
project_path = 'ios/Runner.xcodeproj'
project = Xcodeproj::Project.open(project_path)

# Find the Runner target
runner_target = project.targets.find { |t| t.name == 'Runner' }

if runner_target
  # Look for RunnerUITests
  test_target = project.targets.find { |t| t.name == 'RunnerUITests' }
  
  unless test_target
    puts "Creating RunnerUITests target..."
    test_target = project.new_target(:ui_test_bundle, 'RunnerUITests', :ios, '15.5')
    
    # Add a dependency on the main app
    test_target.add_dependency(runner_target)
    
    # Save the project
    project.save
    puts "RunnerUITests created and saved."
  else
    puts "RunnerUITests already exists."
  end
else
  puts "Runner target not found."
end
