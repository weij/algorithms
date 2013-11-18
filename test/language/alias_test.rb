require 'minitest/autorun'

describe "alias" do
  
  it "able to alias method and operator" do
    class Fixnum
      alias plus +
    end

    3.plus(1).must_equal 4 	
  end

  it "able to alias global variable and regular expression backreference" do
  	alias $prematch $`
  	"string" =~ /i/
  	$prematch.must_equal 'str'
  end

  it "won't work with local variable, instance variable, class variable, or Constant" do
  	-> {alias a b}.must_raise NameError
  	-> {alias a Fixnum}.must_raise NameError
  	# will raise SyntaxError when dealing with instance/class variable
  end

  it "reference a copy of original method" do
  	def meth
      "original method"
  	end
  	alias original meth

  	def meth
      "new and improved"
  	end

  	original.must_equal "original method"
    meth.must_equal "new and improved"
  end
end