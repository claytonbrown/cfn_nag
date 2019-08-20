
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSNeptuneDBClusterStorageEncryptedRule < BaseRule
  def rule_text
    "[encrypted] AWS::Neptune::DBCluster property [StorageEncrypted] should exist, consider default values of [ True ]  []"
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0184'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::Neptune::DBCluster').select do |resource|
      resource.storageencrypted.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        