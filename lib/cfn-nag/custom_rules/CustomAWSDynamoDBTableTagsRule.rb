
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSDynamoDBTableTagsRule < BaseRule
  def rule_text
    "[taggable] AWS::DynamoDB::Table property [Tags] should exist "
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0023'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::DynamoDB::Table').select do |resource|
      resource.tags.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        