require 'spec_helper'

describe 'php', :type => :class do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end

      describe 'when called with no parameters' do
        case facts[:osfamily]
        when 'Debian'
          it {
            should_not contain_class('php::global')
            should contain_class('php::fpm')
            should contain_package('php5-cli').with({
              'ensure' => 'present',
            })
            should contain_package('php5-fpm').with({
              'ensure' => 'present',
            })
            should contain_package('php5-dev').with({
              'ensure' => 'present',
            })
            should contain_package('php-pear').with({
              'ensure' => 'present',
            })
            should contain_class('php::composer')
          }
        when 'Suse'
          it {
            should contain_class('php::global')
            should contain_package('php5').with({
              'ensure' => 'present',
            })
            should contain_package('php5-devel').with({
              'ensure' => 'present',
            })
            should contain_package('php5-pear').with({
              'ensure' => 'present',
            })
            should_not contain_package('php5-cli')
            should_not contain_package('php5-dev')
            should_not contain_package('php-pear')
          }
        end
      end

      describe 'when fpm is disabled' do
        let(:params) { { :fpm => false, } }
        it {
          should_not contain_class('php::fpm')
        }
      end
      describe 'when composer is disabled' do
        let(:params) { { :composer => false, } }
        it {
          should_not contain_class('php::composer')
        }
      end
    end
  end
end
