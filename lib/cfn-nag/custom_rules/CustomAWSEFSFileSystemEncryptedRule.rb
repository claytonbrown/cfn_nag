
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSEFSFileSystemEncryptedRule < BaseRule
  def rule_text
    "[encrypted] AWS::EFS::FileSystem property [Encrypted] should exist, consider default values of [ True ] "
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0060'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::EFS::FileSystem').select do |resource|
      resource.encrypted.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        