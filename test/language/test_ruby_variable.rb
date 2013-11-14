require 'minitest/autorun'

describe 'The reference which Ruby Variable holds' do
  it 'can be assigned to anther variable' do
  	var1 = "Same string"
  	var2 = var1
  	var1.must_be_same_as var2
  end

  it 'can be prevented to modify' do
  	var1 = "Same string"
  	var1.freeze
  	lambda{ var1[0] = "K"}.must_raise RuntimeError
  end

  it 'can be duplicated as a new object' do
  	var1 = "Same string"
  	var2 = var1.dup
  	var1.wont_be_same_as var2
  end
end

describe 'Ruby Variable' do
  it 'is defined without assignment executed' do
  	lambda{a}.must_raise NameError
  	a = 1 if false
    a.must_be :==, nil
  end
end