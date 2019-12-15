
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSAppSyncApiCacheAtRestEncryptionEnabledRule < BaseRule
  def rule_text
    "[encryption_at_rest] AWS::AppSync::ApiCache property [AtRestEncryptionEnabled] should exist, consider default values of [ True ]  []"
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0028'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::AppSync::ApiCache').select do |resource|
      resource.atrestencryptionenabled.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        