
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSCodeBuildProjectBadgeEnabledRule < BaseRule
  def rule_text
    "[Default ON for enable properties] AWS::CodeBuild::Project property [BadgeEnabled] should exist, consider default values of [ true ]  [TODO]"
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0066'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::CodeBuild::Project').select do |resource|
      resource.badgeenabled.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        