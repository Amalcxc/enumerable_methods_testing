require_relative '../enumerables.rb'

describe Enumerable do
  let(:array) { [1, 2, 3, 4] }  
  let(:range) {(1..10)}
  let(:hash) {Hash.new}




  describe "#my_each" do
    it 'returns an enumerator if no block is given' do        
      expect(array.my_each.is_a? Enumerable).to eql(array.to_enum.is_a? Enumerable)
    end

    it 'returns an array if the block is given' do
      expect(array.my_each{|num| num}).to eql([1,2,3,4])
    end

    it 'returns a range if the block is given' do
      expect(range.my_each{|num| num}).to eql((1..10))
    end
  end

  describe "#my_each_with_index" do
    it 'returns an enumerator if no block is given' do        
      expect(array.my_each_with_index.is_a? Enumerable).to eql(array.to_enum.is_a? Enumerable)
    end

    it 'returns a hash with the index as the value of the key' do
      %w(cat dog wombat).each_with_index { |item, index| hash[item] = index}
      expect(hash).to eql({"cat"=>0, "dog"=>1, "wombat"=>2})
    end

    it 'returns a range if the block is given' do
      expect(range.my_each_with_index{|num| num}).to eql((1..10))
    end
  end

  describe "#my_select" do
    it 'returns a range if the block is given' do
      expect(range.my_select{ |i|  i % 3 == 0 } ).to eql(([3, 6, 9]))
    end
    
    it 'returns a even number if the block is given' do
      expect(range.my_select{  |num|  num.even? } ).to eql(( [2, 4, 6, 8, 10]))
    end
  end

  describe "#my_count" do
    it 'returns a count number if a block and arguments is not given' do
      expect(array.my_count)
    end
    
    it 'returns a count if an arguments is given' do
      expect(array.my_count(2))
    end
    
    it 'returns a count number if a block and arguments is given' do
      expect(array.my_count{ |x| x%2==0 }).to eql(2)
    end
  end

  describe "#my_map" do
    it 'returns a count number if a block given' do
      expect(array.my_map{ |i| i*i }).to eql([1, 4, 9, 16])
    end
    
    it 'no block is given, an enumerator is returned instead' do
      expect(array.my_map {"cat"}).to eql(["cat", "cat", "cat", "cat"])
    end
  end

  describe '#my_all?' do
    it 'returns true if no block is given and none of the items are false or nil' do
      expect([].my_all?).to eql(true)
    end

    it 'returns false if no block is given and at least one of the items are false or nil' do
      expect([nil, true, 99].my_all?).to eql(false)
    end

    it 'returns true if every element in the array returns true for the condition' do
      expect(%w[ant bear cat].my_all? { |word| word.length >= 3 }).to eql(true)
    end

    it 'returns false if at least one of the elements returns false for the condition' do
      expect(%w[ant bear cat].my_all? { |word| word.length >= 4 }).to eql(false)
    end

    it 'returns whether pattern === element for every collection member' do
      expect(%w[ant bear cat].my_all?(/t/)).to eql(false)
    end

    it 'returns true if every element is a member of a given class' do
      expect([1, 2i, 3.14].my_all?(Numeric)).to eql(true)
    end
  end
end
