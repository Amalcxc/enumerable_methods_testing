require_relative '../enumerables.rb'

describe Enumerable do
  let(:array) { [1, 2, 3, 4] }  
  let(:range) {(1..50)}
  let(:hash) {Hash.new}

  describe "#my_each" do
    it 'returns an enumerator if no block is given' do        
      expect(array.my_each.is_a? Enumerable).to eql(array.to_enum.is_a? Enumerable)
    end

    it 'returns an array if the block is given' do
      expect(array.my_each{|num| num}).to eql([1,2,3,4])
    end

    it 'returns a range if the block is given' do
      expect(range.my_each{|num| num}).to eql((1..50))
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
      expect(range.my_each_with_index{|num| num}).to eql((1..50))
    end
  end
end