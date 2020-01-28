
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSNeptuneDBClusterBackupRetentionPeriodRule < BaseRule
  def rule_text
    "[resilience] AWS::Neptune::DBCluster property [BackupRetentionPeriod] should exist, consider default values of [ 35 ]  []"
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0271'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::Neptune::DBCluster').select do |resource|
      resource.backupretentionperiod.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        