Puppet::Type.newtype(:s3) do
  desc "Get files from S3"

  ensurable do
      defaultvalues
  end

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

