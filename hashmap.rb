# frozen_string_literal: true

# DIY Hash Map
class HashMap
  # this project is only concerned with hashmaps for strings
  LOAD_FACTOR = 0.8
  attr_accessor :bucket, :keys, :values, :codes, :bucket_size

  def initialize
    @bucket = Array.new(16) { [] }
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
    remove(key) if has(key)

    @keys << key
    @values << value
    code = hash(key)
    @codes << code
    @bucket[code % bucket_size] << { code => value }
    # this circumvents needing an index error while respecting fixed bucket sizes
    # a collision is when two different keys are in the same bucket (generate same hash)
    # grow buckets size when needed by seeing if it has reached load factor
    return unless length >= @bucket_size * LOAD_FACTOR

    @bucket_size *= 2
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

    code_index = hash(key) % @bucket_size
    rm_key(key)
    removed_value = nil
    if @bucket[code_index].length > 1
      removed_value = @bucket[code_index].pop.values[0]
      @values.delete_at(@values.index(removed_value))
    else
      removed_value = @bucket[code_index][0]
      @bucket[code_index] = []
      @values.delete(removed_value.values[0])
    end
    removed_value.values[0]
  end

  def rm_key(key)
    @keys.delete_at(@keys.index(key))
  end

  def length
    # returns the number of stored keys in the hash map
    @keys.length
  end

  def clear
    # removes all entries in the hash map
    initialize
  end

  def entries
    # returns an array that contains each key, value pair.
    @bucket
  end
end

hm = HashMap.new
hm.set('bread', 'butter')
hm.set('sugar', 'salt')
p hm.entries
p hm.remove('bread')
p hm.entries
p hm.remove('sugar')
p hm.entries
