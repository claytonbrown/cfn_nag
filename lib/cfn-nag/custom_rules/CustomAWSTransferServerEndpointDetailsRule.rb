
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSTransferServerEndpointDetailsRule < BaseRule
  def rule_text
    "[Private Networking] AWS::Transfer::Server property [EndpointDetails] should exist, consider default values of [ {'Ref': 'TODO'} ]  [WA-sec_network_protection_layered]"
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0404'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::Transfer::Server').select do |resource|
      resource.endpointdetails.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        