require 'spec_helper'

describe 's3' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
       let(:facts) do
         facts
       end

        context "s3 class without any parameters" do
          let(:params) {{ }}
          
          context "is_pe not defined" do
            it { should contain_class('s3') }
            it { is_expected.to compile.with_all_deps }
            it { is_expected.to contain_package('aws-sdk').with(
              :ensure   => 'present',
              :provider => 'gem',
            )}
          end

          context "is_pe true" do
            let(:facts) {{ :is_pe => true }}
            it { should contain_class('s3') }
            it { is_expected.to compile.with_all_deps }
            it { is_expected.to contain_package('aws-sdk').with(
              :ensure   => 'present',
              :provider => 'pe_gem',
            )}
          end
        end
      end
    end
  end
end
