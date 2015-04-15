# todo: self.instances and self.prefetch not yet implemented. 
# Currently this provider compares the MD5 hash of the S3 and the local file system file, if that comparison returns 
# false then the S3 object is pulled and written to the :path on the filesystem.
#
# Example:
#   s3 { '/path/to/my/filesystem':
#       ensure              => present,
#       source              => '/bucket/path/to/object',
#       access_key_id       => 'mysecret',
#       secret_access_key   => 'anothersecret',
#       region              => 'us-west-1', # Defaults to us-east-1
#   }
#
#   Author: jeff malnick, malnick@gmail.com

require 'rubygems' if Puppet.features.rubygems? 
require 'aws-sdk' if Puppet.features.awssdk?
require 'digest'
require 'tempfile'

Puppet::Type.type(:s3).provide(:s3) do
  confine :feature => :awssdk
  confine :feature => :rubygems

  desc "Securely get shit out of S3. Note this provider requires Version 2 of the aws-sdk. Ensure that v2 is installed."

  def create
    Puppet.info('Connecting to AWS S3')   
    s3 = Aws::S3::Client.new( 
        :access_key_id      => resource[:access_key_id], 
        :secret_access_key  => resource[:secret_access_key],
        :region             => resource[:region] || 'us-east-1',
    )

    # Get the name of the bucket and path to the object:
    source_ary  = resource[:source].chomp.split('/')
    source_ary.shift # Remove prefixed white space
    
    bucket      = source_ary.shift
    key         = File.join(source_ary)
    
    Puppet.info("Pulling bucket: #{bucket}, key: #{key}")
    # Handle new S3 object
    resp = s3.get_object(
        response_target:    resource[:path],
        bucket:             bucket,
        key:                key,
    )
    
  end

  def destroy

      # rm rf some file on the filesystem that points to resource[:path]
    
  end

  def exists?

      if File.exists?(resource[:path])  

          # Setup a temp file to compare against
          temp_file = Tempfile.new(resource[:path])

          # Create a new S3 client object
          s3 = Aws::S3::Client.new( 
                :access_key_id      => resource[:access_key_id], 
                :secret_access_key  => resource[:secret_access_key],
                :region             => resource[:region] || 'us-east-1',
            )
            
            # Do all the same stuff I did for create
            source_ary  = resource[:source].chomp.split('/')
            source_ary.shift # Remove prefixed white space
            
            bucket      = source_ary.shift
            key         = File.join(source_ary)

            Puppet.info('Setting new S3 object and downloading...')

            # Grab the object and point it at temp_file
            resp = s3.get_object(
                response_target:    temp_file, 
                bucket:             bucket,
                key:                key,
            )
            
            # Compare the MD5 hashes, return true or false 
            temp_file_md5   = Digest::MD5.file(temp_file).hexdigest 
            actual_file_md5 = Digest::MD5.file(resource[:path]).hexdigest

            if temp_file_md5  == actual_file_md5 
                true
            else
                false
            end
      end
  end

end
