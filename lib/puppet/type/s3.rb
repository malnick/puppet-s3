Puppet::Type.newtype(:s3) do
  desc "Get files from S3"

  ensurable 

  newparam(:path, :namevar => true) do
    desc "Path to the file on the local filesystem"
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

end

