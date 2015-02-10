class s3 {

    package { 'aws-sdk':
        ensure   => present,
        provider => 'gem',
    }

    Package ['rubygems'] -> Package ['aws-sdk'] -> S3 <| |>
}
