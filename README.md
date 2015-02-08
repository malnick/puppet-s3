# puppet-s3

## Requires

```gem install aws-sdk``` => version 2

If you've already installed version and rely on it you'll have to look into the rdoc for the SDK since V2 is 
reverse breaking to V1. 

Mainly:

Upgrading - Client Classes - Versioned client classes removed, e.g. Aws::S3::Client::V20060301.new is now Aws::S3::Client.new The :api_version constructor option is no longer accepted.

Upgrading - Aws Module - Helper methods on Aws for client classes deprecated; For example, calling Aws.s3 will generate a deprecation warning. Use Aws::S3::Client.new instead. Helpers will be removed as of v2.0.0 final.

More information can be found [here](https://github.com/aws/aws-sdk-core-ruby/blob/master/CHANGELOG.md)


## Types

Currently this module has a single type and provider 's3'. The 's3' resource is instanciated as such:

```ruby
s3 { '/path/to/file/on/my/local/filesystem':
    # Required paramters:
    ensure              => present,
    source              => '/bucket/path/to/object',
    access_key_id       => 'mysecret',
    secret_access_key   => 'anothersecret',
    # Optional parameters:
    region              => 'us-west-1', # Defaults to us-east-1
}
```

This provider is 'psudo-idempotent' in that the ```exists?``` method, on each run, has to pull down the S3 object in order to compare it to the one of the local filesystem. 

In order to do this comparison it creates a temp file in the same path as the file on the local filesystem and pulls down the S3 resource. It then compares the MD5 checksum 
of each resource, the local file and the S3 object. If this returns true, the filesystem is not written to; if it returns false, the new resource is written. 

Currently, on each run, the S3 object is actually pulled down twice since ```exists?``` and ```create``` methods both grab the object. This isn't great for performance and I would like
to update this in future versions. 

## Features

The S3 type and provider rely on ```aws-sdk 'version -> 2'```. There is a feature which the provider is ```:confined``` to that will post-pone S3 resources until the gems for the ```aws-sdk``` are 
present on the local filesystem. Ensure to ```include s3``` in your catalogue so those gems get installed. 
