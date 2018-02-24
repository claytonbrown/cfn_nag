
require 'cfn-nag/violation'
#require 'cfn-nag/custom_rules/base'
require_relative 'base'

class AWSEFSFileSystem_Encrypted < BaseRule
  def rule_text
    'AWS::EFS::FileSystem property [Encrypted] should exist and be True'
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'Custom-56'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::EFS::FileSystem').select do |resource|
      resource.encrypted.nil? || resource.encrypted.to_s.downcase != 'true'
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        