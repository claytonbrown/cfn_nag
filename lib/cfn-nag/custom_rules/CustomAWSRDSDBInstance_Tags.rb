
require 'cfn-nag/violation'
require_relative 'base'
#require 'cfn-nag/custom_rules/base'

class AWSRDSDBInstance_Tags < BaseRule
  def rule_text
    'AWS::RDS::DBInstance property [Tags] should exist '
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'Custom-102'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::RDS::DBInstance').select do |resource|
      resource.tags.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        