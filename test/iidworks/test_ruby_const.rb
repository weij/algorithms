require 'minitest/autorun'

describe 'ruby Constant' do

  before do
    OUTER_CONST = 99
    class Const
      def get_const
        CONST
      end
      CONST = OUTER_CONST + 1
  	end
  end

  describe 'when it is assigned with a number' do
  	it 'can be re-assigned with new value' do
      MY_CONST = 1
      MY_CONST = 2
      MY_CONST.wont_be :==, 1 
    end
  end
  
  describe 'when the constant references a string'do
    it 'can be updated through []= format' do
      MY_CONST = 'weijun'
      MY_CONST[0] = 'Y'
      MY_CONST.must_be :==, 'Yeijun'
    end 	
  end

  describe 'when constant appears within class/module block' do

  	it "can be assessed through [module name]::[your constant]" do
  	  Const::CONST.must_be :==, 100
  	  ::OUTER_CONST.must_be :==, 99
  	end

  	it "can't defined within a class or instance method" do
  	  class Const2
  	    def self.get_const; CONST; end
  	    def get_const; CONST; end	
  	  end

      lambda {Const2.get_const}.must_raise NameError
  	  lambda {Const2.new.get_const}.must_raise NameError  
  	  Const.new.get_const.must_be :==, 100
  	end
  end

  it "can be added to existing class/module name" do
    lambda{ Const.const_get(:NEW_CONST)}.must_raise NameError	
    Const::NEW_CONST = 88
    Const.const_get(:NEW_CONST).must_be :==, 88
  end

end