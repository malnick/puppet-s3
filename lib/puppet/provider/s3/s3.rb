require 'rubygems' if Puppet.features.rubygems? 
require 'aws-sdk' if Puppet.features.awssdk?

Puppet::Type.type(:s3).provide(:s3) do
  confine :feature => :awssdk

  desc "Run pupppet on a node"

  def create
    
    s3 = Aws::S3::Client.new(
        :access_key_id      => @resource[:access_key_id], 
        :secret_access_key  => @resource[:secret_access_key],
        :region             => @resource[:region] || 'global',
    )

    source_ary  = @resource[:source].chomp.split.split('/')
    source_ary.shift # Remove prefixed white space
    
    bucket      = source_ary.shift
    key         = "/" + File.join(source_ary)

    resp = s3.get_object(
         response_target:   @resource[:path],
         bucket:            bucket,
         key:               key,
    )

    #File.open(@resource[:path], 'w') do |file|
    #    obj.read do |chunk|
    #        file.write(chunk)
    #    end
    #end
    
  end

  def destroy
    
  end

  def exists?
  
      File.exists? @resource[:path]

  end

end
