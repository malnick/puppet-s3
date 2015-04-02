require 'spec_helper'

type = Puppet::Type.type(:s3)

describe type do
  let :params do
    [
      :name,
      :region,
      :access_key_id,
      :secret_access_key,
    ]
  end

  let :properties do
    [
      :ensure,
    ]
  end

  it 'should have expected properties' do
    properties.each do |property|
      expect(type.properties.map(&:name)).to be_include(property)
    end
  end

#  it 'should have expected parameters' do
#    params.each do |param|
#      expect(type.parameters).to be_include(param)
#    end
#  end

  it 'should require a name' do
    expect { 
      type.new({})
    }.to raise_error(Puppet::Error, "Title or name must be provided")
  end

  it 'should require a name with an absolute path' do
    expect {
      type.new({ name: 'vodka' })
    }.to raise_error(Puppet::Error, /Path not absolute: vodka/)
  end

end
