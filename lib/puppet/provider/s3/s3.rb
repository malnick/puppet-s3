require 'rubygems' #if Puppet.features.rubygems? 
require 'aws-sdk' #if Puppet.features.awssdk?
require 'digest'
require 'tempfile'
#require 'aws-sdk-resources'

Puppet::Type.type(:s3).provide(:s3) do
  confine :feature => :awssdk

  desc "Securely get shit out of S3. Note this provider requires Version 2 of the aws-sdk. Ensure that v2 is installed."

  def create
    Puppet.info('Connecting to AWS S3')   
    s3 = Aws::S3::Client.new( 
        :access_key_id      => resource[:access_key_id], 
        :secret_access_key  => resource[:secret_access_key],
        :region             => resource[:region] || 'us-east-1',
    )

    source_ary  = resource[:source].chomp.split('/')
    source_ary.shift # Remove prefixed white space
    
    bucket      = source_ary.shift
    key         = File.join(source_ary)

    Puppet.info('Setting new S3 object and downloading...')

    resp = s3.get_object(
        response_target:    resource[:path],
        bucket:             bucket,
        key:                key,
    )
    
  end

  def destroy
    
  end

  def exists?

  if File.exsts?(resource[:path])  

      temp_file = Tempfile.new(resource[:path])

      s3 = Aws::S3::Client.new( 
            :access_key_id      => resource[:access_key_id], 
            :secret_access_key  => resource[:secret_access_key],
            :region             => resource[:region] || 'us-east-1',
        )

        source_ary  = resource[:source].chomp.split('/')
        source_ary.shift # Remove prefixed white space
        
        bucket      = source_ary.shift
        key         = File.join(source_ary)

        Puppet.info('Setting new S3 object and downloading...')

        resp = s3.get_object(
            response_target:    temp_file, 
            bucket:             bucket,
            key:                key,
        )
        
        temp_file_md5   = Digest::MD5.file(temp_file).hexdigest 
        actual_file_md5 = Digest::MD5.file(resource[:path]]).hexdigest

        if temp_file_md5  == actual_file_md5 
            true
        else
            false
        end
  end
  end

end
