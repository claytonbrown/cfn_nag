
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSAppStreamFleetEnableDefaultInternetAccessRule < BaseRule
  def rule_text
    "[Default ON for enable properties] AWS::AppStream::Fleet property [EnableDefaultInternetAccess] should exist, consider default values of [ true ]  [TODO]"
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0034'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::AppStream::Fleet').select do |resource|
      resource.enabledefaultinternetaccess.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        