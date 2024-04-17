

# error to raise raise IndexError if index.negative? || index >= @buckets.length
# should take a key (ex: 'Carlos'), hash it into something, store it in a bucket
# expand bucket as more values are added
class HashMap
  # this project is only concerned with hashmaps for strings
  LOAD_FACTOR = 0.8
  attr_accessor :bucket, :keys, :values, :codes, :bucket_size

  def initialize
    @bucket = Array.new(16)
    @keys = []
    @values = []
    @codes = []
    @bucket_size = 16
  end

  def hash(key)
    hash_code = 0
    prime_number = 31
       
    key.each_char do |char|
      hash_code = prime_number * hash_code + char.ord
    end
    hash_code
  end

  def set(key, value)
    # If a key already exists, then the old value is overwritten
    @keys << key
    @values << value
    code = hash(key)
    @codes << code
    @bucket.insert(code % bucket_size,{code => value})
    # a collision is when two different keys are in the same bucket (generate same hash)
    # grow buckets size when needed by seeing if it has reached load factor
  end

  def get(key)
    # takes one argument as a key and returns the value that is assigned to this key. If key is not found, return nil
    return nil unless has(key)

    code = hash(key)
    h = @bucket[code % @bucket_size]
    h.values[0]
  end

  def has(key)
    # takes a key as an argument and returns true or false based on whether or not the key is in the hash map.
    @keys.any?(key)
  end

  def remove(key)
    # If the given key is in the hash map,
    # it should remove the entry with that key
    # and return the deleted entry’s value.
    # If the key isn’t in the hash map, it should return nil
    return nil unless has(key)

    code = hash(key)
    removed_value = @bucket.delete_at(code % @bucket_size).values[0]
    @keys.delete(key)
    @values.delete(removed_value)
    removed_value
  end

  def length
    # returns the number of stored keys in the hash map
    @keys.length
  end

  def clear
    # removes all entries in the hash map
    initialize
  end

  def keys
    # returns an array containing all the keys inside the hash map.
    @keys
  end

  def values
    # returns an array containing all the values.
    @values
  end

  def entries
    # returns an array that contains each key, value pair.
    @bucket
  end
end

hashmap = HashMap.new
puts 'Round 1'
hashmap.set('Fred', 'Smith')
puts "entries: #{hashmap.entries}"
puts "values: #{hashmap.values}"
puts "keys: #{hashmap.keys}"
puts "length #{hashmap.length}"
puts "has: Fred #{hashmap.has('Fred')}"
puts "get: Fred #{hashmap.get('Fred')}"
puts 'Round 2, adding Jerry'
hashmap.set('Jerry', 'Davis')
puts "entries: #{hashmap.entries}"
puts "values: #{hashmap.values}"
puts "keys: #{hashmap.keys}"
puts "length #{hashmap.length}"
puts "has: Jeff #{hashmap.has('Jeff')}"
puts "get: Jerry #{hashmap.get('Jerry')}"
puts 'round 3, removing Fred'
puts "remove: Fred #{hashmap.remove('Fred')}"
puts "entries: #{hashmap.entries}"
puts "values: #{hashmap.values}"
puts "keys: #{hashmap.keys}"
puts "length #{hashmap.length}"
puts "has: Fred #{hashmap.has('Fred')}"
puts "get: Fred #{hashmap.get('Fred')}"
