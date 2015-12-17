# encoding: utf-8

# because RSpec doesn't run tests in order I need to make sure that each
# of the CloudFormation stacks has distinct context
role = Aws::IAM::Client.new
role.stub_responses(
  :get_role,
  role: {
    path: 'pathtype',
    role_name: 'stuff',
    role_id: 'cenas',
    arn: 'stuff',
    create_date: Time.new,
    assume_role_policy_document: 'stuff'
  }
)

RSpec.describe IAM::Role.new(
  'test-stack1',
  role
) do
  its(:to_s) { is_expected.to eq 'IAM Role: test-stack1' }
  its(:path) { is_expected.to eq 'pathtype' }
  its(:arn) { is_expected.to eq 'stuff' }
  its(:assume_role_policy_document) { is_expected.to eq 'stuff' }
end
