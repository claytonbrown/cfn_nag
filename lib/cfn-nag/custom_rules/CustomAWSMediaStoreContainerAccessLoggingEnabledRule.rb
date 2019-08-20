
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSMediaStoreContainerAccessLoggingEnabledRule < BaseRule
  def rule_text
    "[standards] AWS::MediaStore::Container property [AccessLoggingEnabled] should exist, consider default values of [ True ]  []"
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0178'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::MediaStore::Container').select do |resource|
      resource.accessloggingenabled.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        