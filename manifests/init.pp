# == Class: s3
#
# Install the aws-sdk for use by the s3 type/provider
#
# === Parameters
#
# No parameters used.
#
# === Variables
#
# [*_provider*]
#   If running under Puppet Enterprise, this is set to 'pe-gem',
#   otherwise the provider is set to gem.
#
# === Examples
#
# include ::s3
#
# s3 { '/path/to/file/on/my/local/filesystem':
#   # Required paramters:
#   ensure            => present,
#   source            => '/bucket/path/to/object',
#   access_key_id     => 'mysecret',
#   secret_access_key => 'anothersecret',
#   # Optional parameters:
#   region            => 'us-west-1', # Defaults to us-east-1
# }
#
# === Authors
#
# Jeff Malnick <malnick@gmail.com>
#
# === Copyright
#
# Copyright 2015 Jeff Malnick, unless otherwise noted.
#
class s3 {

  $_pe = pick(getvar(::is_pe), false)
  $_provider = $_pe ? {
    true    => 'pe_gem',
    default => 'gem',
  }

  package { 'aws-sdk':
    ensure   => present,
    provider => $_provider,
  }
}
