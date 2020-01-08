
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSRDSDBInstanceDeleteAutomatedBackupsRule < BaseRule
  def rule_text
    "[standards] AWS::RDS::DBInstance property [DeleteAutomatedBackups] should exist, consider default values of [ False ]  []"
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0333'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::RDS::DBInstance').select do |resource|
      resource.deleteautomatedbackups.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        