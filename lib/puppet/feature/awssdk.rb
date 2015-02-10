require 'puppet/util/feature'
Puppet.features.add(:awssdk) do
    begin
        require 'aws-sdk'
    rescue LoadError
        false
    end
end
