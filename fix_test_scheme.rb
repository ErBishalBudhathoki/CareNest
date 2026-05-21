require 'xcodeproj'
project_path = 'ios/Runner.xcodeproj'
project = Xcodeproj::Project.open(project_path)

# Ensure the RunnerUITests is enabled in the Development scheme
scheme_path = project_path + '/xcshareddata/xcschemes/Development.xcscheme'
if File.exist?(scheme_path)
  scheme = Xcodeproj::XCScheme.new(scheme_path)
  
  test_target = project.targets.find { |t| t.name == 'RunnerUITests' }
  if test_target
    test_action = scheme.test_action
    
    # Force add the testable reference
    ref = Xcodeproj::XCScheme::BuildableReference.new(test_target)
    testable = Xcodeproj::XCScheme::TestAction::TestableReference.new(ref)
    
    # Clear old testables just in case and add the new one
    test_action.testables = [testable]
    scheme.save!
    puts "Forced RunnerUITests into Development.xcscheme."
  end
else
  puts "Development.xcscheme not found in expected path."
end
