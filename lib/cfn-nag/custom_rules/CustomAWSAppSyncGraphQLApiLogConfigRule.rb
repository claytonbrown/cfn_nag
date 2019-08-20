
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSAppSyncGraphQLApiLogConfigRule < BaseRule
  def rule_text
    "[logging] AWS::AppSync::GraphQLApi property [LogConfig] should exist []"
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0022'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::AppSync::GraphQLApi').select do |resource|
      resource.logconfig.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        