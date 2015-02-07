class s3 {

    package { 'aws-sdk-core':
        ensure   => present,
        provider => 'pe_gem',
    }

    package { 'aws-sdk-resources':
        ensure   => present,
        provider => 'pe_gem',
    }

    Package <|title == 'aws-sdk-core' and title == 'aws-sdk-resources'|> -> s3<||>
}
