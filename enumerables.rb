# rubocop: disable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity, Metrics/ModuleLength

# module enumerable
module Enumerable
  def my_each
    return to_enum unless block_given?

    i = 0
    while i < to_a.length
      yield(to_a[i])
      i += 1
    end
    self
  end

  def my_each_with_index
    return to_enum unless block_given?

    to_a.length.times do |i|
      yield(to_a[i], i)
    end
    self
  end

  def my_select
    return to_enum unless block_given?

    newarray = []
    my_each { |item| newarray.push(item) if yield(item) }
    newarray
  end

  def my_all?(arg = nil)
    unless block_given?
      if arg.is_a?(Class)
        my_each { |item| return false unless item.is_a?(arg) }
      elsif arg.is_a?(Regexp)
        my_each { |item| return false if item.scan(arg).length.zero? }
      elsif arg.nil?
        my_each { |item| return false unless item }
      else
        my_each { |item| return false unless item == arg }
      end
      return true
    end
    my_each { |item| return false unless yield(item) }
    true
  end

  def my_any?(arg = nil)
    unless block_given?
      if arg.is_a?(Class)
        my_each { |item| return true if item.is_a?(arg) }
      elsif arg.is_a?(Regexp)
        my_each { |item| return true unless item.scan(arg).length.zero? }
      elsif arg.nil?
        my_each { |item| return true if item }
      else
        my_each { |item| return true if item == arg }
      end
      return false
    end
    my_each { |item| return true if yield(item) }
    false
  end

  def my_none?(arg = nil)
    unless block_given?
      if arg.is_a?(Class)
        my_each { |item| return false if item.is_a?(arg) }
      elsif arg.is_a?(Regexp)
        my_each { |item| return false unless item.scan(arg).length.zero? }
      elsif arg.nil?
        my_each { |item| return false if item }
      else
        my_each { |item| return false if item == arg }
      end
      return true
    end
    my_each { |item| return false if yield(item) }
    true
  end

  def my_count(arg = nil)
    count = 0
    unless block_given?
      return to_a.length if arg.nil?

      my_each { |item| count += 1 if item == arg }
      return count
    end
    my_each { |item| count += 1 if yield(item) }
    count
  end

  def my_map(proc = nil)
    return to_enum unless block_given?

    newarray = []
    if proc.nil?
      my_each { |item| newarray.push(yield(item)) }
    else
      my_each { |item| newarray.push(proc[item]) }
    end
    newarray
  end

  def my_inject(ini = nil, arg = nil)
    if ini.is_a?(Symbol)
      arg = ini
      result = nil
    elsif !ini.nil?
      result = ini
    end
    if !block_given? && arg.is_a?(Symbol)
      op = arg.to_proc
      my_each { |item| result = result.nil? ? item : op.call(result, item) }
      return result
    end
    my_each { |item| result = result.nil? ? item : yield(result, item) }
    result
  end
end

def multiply_els(arr)
  arr.my_inject { |factora, factorb| factora * factorb }
end

# rubocop: enable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity, Metrics/ModuleLength
