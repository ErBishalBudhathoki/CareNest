require 'xcodeproj'
project_path = 'ios/Runner.xcodeproj'
project = Xcodeproj::Project.open(project_path)

# Ensure the RunnerUITests is enabled in the Development scheme's test action
scheme_path = Xcodeproj::XCScheme.shared_data_dir(project_path) + '/Development.xcscheme'
if File.exist?(scheme_path)
  scheme = Xcodeproj::XCScheme.new(scheme_path)
  
  test_target = project.targets.find { |t| t.name == 'RunnerUITests' }
  if test_target
    test_action = scheme.test_action
    
    # Check if RunnerUITests is already a TestableReference
    has_test = test_action.testables.any? { |t| t.buildable_references.any? { |b| b.target_name == 'RunnerUITests' } }
    
    unless has_test
      puts "Adding RunnerUITests to Development scheme..."
      ref = Xcodeproj::XCScheme::BuildableReference.new(test_target)
      testable = Xcodeproj::XCScheme::TestAction::TestableReference.new(ref)
      test_action.add_testable(testable)
      scheme.save!
      puts "Scheme updated."
    else
      puts "Scheme already contains testable."
    end
  end
else
  puts "Development.xcscheme not found."
end
