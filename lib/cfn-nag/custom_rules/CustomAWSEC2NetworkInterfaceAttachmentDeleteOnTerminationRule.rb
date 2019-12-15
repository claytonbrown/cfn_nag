
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSEC2NetworkInterfaceAttachmentDeleteOnTerminationRule < BaseRule
  def rule_text
    "[standards] AWS::EC2::NetworkInterfaceAttachment property [DeleteOnTermination] should exist, consider default values of [ False ]  []"
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0098'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::EC2::NetworkInterfaceAttachment').select do |resource|
      resource.deleteontermination.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        