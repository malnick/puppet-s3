class s3 {

    package { 'aws-sdk-core':
        ensure   => present,
        provider => 'gem',
    }

    package { 'aws-sdk-resources':
        ensure   => present,
        provider => 'gem',
    }

    Package ['aws-sdk-core','aws-sdk-resources'] -> S3 <| |>
}
