require 'puppet/util/feature'
Puppet.features.add(:awssdk) do
    if ! (defined?(::Aws)
          false
    else
        true
    end
end
