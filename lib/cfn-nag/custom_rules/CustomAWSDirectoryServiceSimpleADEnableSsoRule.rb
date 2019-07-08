
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSDirectoryServiceSimpleADEnableSsoRule < BaseRule
  def rule_text
    "[standards] AWS::DirectoryService::SimpleAD property [EnableSso] should exist, consider default values of [ True ] "
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0050'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::DirectoryService::SimpleAD').select do |resource|
      resource.enablesso.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        