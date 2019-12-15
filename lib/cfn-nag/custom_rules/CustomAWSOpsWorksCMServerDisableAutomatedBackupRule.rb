
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSOpsWorksCMServerDisableAutomatedBackupRule < BaseRule
  def rule_text
    "[standards] AWS::OpsWorksCM::Server property [DisableAutomatedBackup] should exist, consider default values of [ False ]  []"
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0234'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::OpsWorksCM::Server').select do |resource|
      resource.disableautomatedbackup.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        