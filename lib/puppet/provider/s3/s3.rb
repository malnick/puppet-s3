require 'aws-sdk-v1'
require 'aws-sdk'

Puppet::Type.type(:s3).provide(:s3) do
desc "Run pupppet on a node"

  def create
    
    s3 = Aws::S3::Client.new(
        :access_key_id      => @resource[:access_key_id], 
        :secret_access_key  => @resource[:secret_access_key]
    )

    source_ary  = @resource[:source].split('/')
    bucket      = source_ary[0].pop
  end

  def destroy

  end

  def exists?
  end

end
