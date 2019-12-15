
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSAppStreamImageBuilderEnableDefaultInternetAccessRule < BaseRule
  def rule_text
    "[standards] AWS::AppStream::ImageBuilder property [EnableDefaultInternetAccess] should exist, consider default values of [ False ]  []"
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0024'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::AppStream::ImageBuilder').select do |resource|
      resource.enabledefaultinternetaccess.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        