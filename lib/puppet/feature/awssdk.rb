require 'puppet/util/feature'
Puppet.features.add(:awssdk, :libs => %{aws-sdk}) #do
#    begin
#        require 'aws-sdk'
#    rescue LoadError
#        false
#   end
#end
