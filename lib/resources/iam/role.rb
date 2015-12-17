# encoding: utf-8

module Serverspec
  module Type
    module AWS
      # The IAM module contains the IAM API resources
      module IAM
        # The Role class exposes the IAM::Role resources
        class Role < Base
          # AWS SDK for Ruby v2 Aws::IAM::Role wrapper for initializing an
          # Instance resource
          # @param instance_id_name [String] The ID or Name tag of the Instance
          # @param instance [Class] Aws::EC2::Client instance
          # @raise [RuntimeError] if instance_id_name.nil?
          # @raise [RuntimeError] if instance_id_name.length == 0
          # @raise [RuntimeError] if instance_id_name.length > 1
          def initialize(role_name, instance = nil)
            check_init_arg 'role_name', 'IAM::Role', role_name
            @aws = instance.nil? ? Aws::IAM::Client.new : instance
            @role_name = role_name
            get_role role_name
          end

          # Returns the string representation of IAM::Role
          # @return [String]
          def to_s
            "IAM Role: #{@role_name}"
          end

          # Returns IAM::Role path
          # @return [String]
          def path
            @role.path
          end

          # Returns IAM::Role role id
          # @return [String]
          def id
            @role.role_id
          end

          # Returns IAM::Role arn
          # @return [String]
          def arn
            @role.arn
          end

          # Returns IAM::Role creation date
          # @return [String]
          def create_date
            @role.create_date
          end

          # Returns IAM::Role policy document
          # @return [String]
          def assume_role_policy_document
            require 'uri'
            require 'json'
            JSON.parse(URI.decode(@role.assume_role_policy_document))
          end

          def policies
            policies = []
            list = @aws.list_role_policies(role_name: @role_name)
            list.each do |rolepolicy|
              policies << rolepolicy
            end
            policies
          end

          private

          # @private
          def get_role(name)
            r = @aws.get_role(role_name: name)
            check_length 'role', r
            @role = r[0]
          end
        end
      end
    end
  end
end
