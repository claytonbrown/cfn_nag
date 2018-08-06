
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSLambdaFunctionTagsRule < BaseRule
  def rule_text
    "[taggable] AWS::Lambda::Function property [Tags] should exist "
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0082'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::Lambda::Function').select do |resource|
      resource.tags.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        