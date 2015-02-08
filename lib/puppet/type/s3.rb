Puppet::Type.newtype(:s3) do
  @@doc =  %q{Get files from S3
   
      Example:
        
        s3 {'/path/on/my/filesystem':
            ensure              => present,
            source              => '/bucket/subdir/s3_object',
            region              => 'us-east-1', # better for speed if you set it in s3
            access_key_id       => 'ITSASECRET',
            secret_access_key   => 'ITSASECRETTOO',
        }
  }
  
  ensurable

  newparam(:path, :namevar => true) do
    desc "Path to the file on the local filesystem"
    validate do |v|
        path = Pathname.new(v)
        unless path.absolute?
            raise ArgumentError, "Path not absolute: #{path}"
        end
    end
  end

  newparam(:source) do
      desc "The aws s3 bucket path"
  end

  newparam(:access_key_id) do
      desc "AWS secret access key id"
  end

  newparam(:secret_access_key) do
      desc "AWS secret access key"
  end

  newparam(:region) do
      desc "AWS region of S3"
  end

end

