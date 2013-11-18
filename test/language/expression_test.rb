require 'minitest/autorun'

describe 'Operation expression' do
  it 'allow to redefine' do
    class ScoreKeeper
      def initialize
      	@total_score = @count = 0
      end
      def <<(score)
      	@total_score += score
      	@count += 1
      	self
      end
      def average
      	fail "No score" if @count.zero?
      	@total_score / @count
      end
    end

    scores = ScoreKeeper.new
    scores << 10 << 20 << 30
    scores.average.must_be :==, 20
  end
end

describe 'Assignment expression' do

  it 'always return the value of params' do
    class SomeClass 
      def []=(*params)
        value = params.pop
        {params => value}
      end
    end

    s = SomeClass.new
    (s[1] = 2).must_be :==, 2
  end
  
  #  1. all rvalues are evaluated, collect into an array
  #  2. match the rvalue against the successive lvalue element
  describe 'parallel assignment' do
    it 'assign the whole array when single variable' do
      a = 1,2,3,4
      a.must_be :==, [1,2,3,4]
    end

    describe 'when lvalue contains comma and splat' do
      it 'collect the remaining rvalue' do
      	a, *b = 1,2,3
      	c, *d = 1
      	[a,b].must_be :==, [1,[2,3]]
      	[c,d].must_be :==, [a,[]]

      	*e, f, g = 1,2,3,4
        [e, f, g].must_be :==, [[1,2], 3, 4]

        h, *i, j = 1,2,3,4
        [h, i, j].must_be :==, [1, [2,3], 4]

        k, l, *m, n, o = 1,2,3,4
        [k,l,m,n,o].must_be :==, [1, 2, [], 3, 4]
      end

      it 'ignore some rvalues' do
        first, *, last = 1,2,3,4,5,6
        [first, last].must_be :==, [1,6]     	
      end        	

      describe 'when has nested assignment statement' do
      	it 'treat parenthesized term as one' do
      	  a, (b, c), d = 1,2,3,4
      	  [a, b, c, d].must_equal [1, 2, nil, 3]

      	  e, (f, g), h = [1,2,3,4]
      	  [e, f, g, h].must_equal [1, 2, nil, 3] 

      	  i, (j, k), l = 1, [2,3], 4
      	  [i, j, k, l].must_equal [1, 2, 3, 4]

      	  m, (n, o), p = 1,[2, 3, 4], 5
      	  [m, n, o, p].must_equal [1, 2, 3, 5]

      	  m = n = o = p = nil
      	  m, (n, *o), p = 1, [2,3,4], 5
      	  [m, n, o, p].must_equal [1,2, [3,4], 5]
      	end
      end
    end

    it 'discard the excess element when lvalue contains comma' do
      a, b = 1,2,3,4
      [a,b].must_equal [1, 2]
      c, = 1,2,3,4
      c.must_equal 1
    end
  end
end








