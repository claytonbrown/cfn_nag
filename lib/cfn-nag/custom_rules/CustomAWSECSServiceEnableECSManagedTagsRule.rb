
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSECSServiceEnableECSManagedTagsRule < BaseRule
  def rule_text
    "[Default ON for enable properties] AWS::ECS::Service property [EnableECSManagedTags] should exist, consider default values of [ true ]  [TODO]"
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0174'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::ECS::Service').select do |resource|
      resource.enableecsmanagedtags.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        