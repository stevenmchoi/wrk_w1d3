require 'byebug'

def range(start, end_pos)
  return [] if end_pos < start
  return [1] if end_pos <= 2
  range(start, end_pos - 1) + [end_pos - 1]
end

def i_sum_array(array)
  array.reduce(:+)
end

def r_sum_array(array)
  return nil if array.empty?
  return array[0] if array.length == 1
  array[0] + r_sum_array(array[1..-1])
end

def exponentiation(base, power)
  return 1 if power.zero?
  return nil if power < 0
  base * exponentiation(base, power - 1)
end

def exponentiation2(base, power)
  return 1 if power.zero?
  return nil if power < 0

  if power.even?
    exponentiation2(base, power / 2) ** 2
  else
    base * (exponentiation2(base, (power - 1) / 2) ** 2)
  end
end

class Array
  def deep_dup
    return [] if self.empty?
    hold = self[0]
    hold = case hold
      when Array then [hold.deep_dup]
      when !Fixnum then [hold.dup]
      else [hold]
    end
    hold + self[1..-1].deep_dup
  end

end

def i_fibonacci(n)
  fib_array = [1, 1]
  return nil if n < 1
  return fib_array[0...n] if n < 3

  until fib_array.length == n
    fib_array << (fib_array[-1] + fib_array[-2])
  end

  fib_array
end

def r_fibonnaci(n)
  return [1, 1] if n == 2
  back_array = r_fibonnaci(n - 1)
  back_array + [back_array[-1] + back_array[-2]]
end

# REMEMBER
def subsets(array) # [1,2,3]
  # return [[], [1]] if array == [1]
  return [[]] if array.empty?
  prev_subsets = subsets(array[0..-2])
  prev_subsets + ( prev_subsets.map { |el| el += [array.last] } )
end

def permutations(array)
  len = array.length
  return array if len == 1
  if len == 2
    orig = array.dup
    array[0], array[1] = array[1], array[0]
    return [orig, array]
  end
  new_arr = []
  array.each_with_index do |el, idx|
    result = permutations(array[0...idx] + array[idx+1..-1]).map { |array| array.unshift(el) }
    new_arr += result
  end
  new_arr
end

def bsearch(array, target)

  mid_idx = array.length / 2
  return nil if array.length <= 1 && array[mid_idx] != target
  return mid_idx if array[mid_idx] == target

  first_half = array[0...mid_idx]
  second_half = array[mid_idx..-1]
  if target < array[mid_idx]
    bsearch(first_half, target)
  else
    bsearch_second_half(bsearch(second_half, target), mid_idx)
  end
end

def bsearch_second_half(result, mid_idx)
  result ? result + (mid_idx) : nil
end

class Array
  def merge_sort
    mid_idx = length / 2
    return [] if length < 1
    return self if length == 1
    first_half = self[0...mid_idx]
    second_half = self[mid_idx..-1]

    merge(first_half.merge_sort, second_half.merge_sort)
  end

  def merge(arr1, arr2)
    return arr2 if arr1.empty?
    return arr1 if arr2.empty?

    if arr1.first < arr2.first
      p [arr1.shift] + merge(arr1, arr2)
    else
      p [arr2.shift] + merge(arr1,arr2)
    end

  end
end

def greedy_make_change(amount, coins)
  return [] if coins.empty?
  current_coin = coins.shift
  if amount % current_coin == 0
    return [current_coin] * (amount / current_coin)
  end


  while current_coin > amount
    current_coin = coins.shift
  end

  diff = amount / current_coin
  coin_amount = [current_coin] * diff
  coin_amount_total = coin_amount.reduce(:+)
  # debugger
  coin_amount + greedy_make_change((amount - coin_amount_total), coins)
end

def make_better_change(amount, coins)
  return [] if coins.empty?

  biggest_coin = coins[0]
  results_pair = []
  if amount < biggest_coin
    results_pair = make_better_change(amount, coins[1..-1])
  else
    results_pair << make_better_change(amount, coins[1..-1])
    results_pair << [biggest_coin, make_better_change(amount - biggest_coin, coins)]
  end

  results_pair.delete([])
  results_pair.min_by { |sets| sets.length }
  # arr_sets = []
  # arr_coins = []
  # p coins
  # coins.each do |coin|
  #
  #   if coin < amount
  #     p "this is coin: #{coin}"
  #     arr_coins.push(coin)
  #     arr_coins += greedy_make_change(amount - coin, coins)
  #   end
  # end
  # arr_sets.push(arr_coins)
  # # p arr_sets
  # arr_sets.min_by{|el| el.length }
end

p make_better_change(24, [10,7,1]) # => [25, 10, 1, 1, 1, 1]
