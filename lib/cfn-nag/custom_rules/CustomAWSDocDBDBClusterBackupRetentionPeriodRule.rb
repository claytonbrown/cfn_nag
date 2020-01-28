
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSDocDBDBClusterBackupRetentionPeriodRule < BaseRule
  def rule_text
    "[resilience] AWS::DocDB::DBCluster property [BackupRetentionPeriod] should exist, consider default values of [ 35 ]  []"
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0102'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::DocDB::DBCluster').select do |resource|
      resource.backupretentionperiod.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        