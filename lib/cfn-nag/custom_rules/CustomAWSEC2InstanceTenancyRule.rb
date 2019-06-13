
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSEC2InstanceTenancyRule < BaseRule
  def rule_text
    "[tenancy] AWS::EC2::Instance property [Tenancy] should exist, consider default values of [ {'Ref': 'Tenancy'} ] "
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0060'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::EC2::Instance').select do |resource|
      resource.tenancy.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        