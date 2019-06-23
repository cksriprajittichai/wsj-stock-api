# frozen_string_literal: true

class Hash

  def contains_same_keys_deep(other)
    stack = [self, other]

    while !stack.empty?
      other_ptr = stack.pop
      self_ptr = stack.pop

      return false if self_ptr.size != other_ptr.size

      self_ptr.keys.each do |key|
        # Check key names
        return false unless other_ptr.has_key?(key)

        # Check value (of keys) types
        if self_ptr[key].instance_of?(Hash) && other_ptr[key].instance_of?(Hash)
          stack.push(self_ptr[key], other_ptr[key])
        elsif self_ptr[key].instance_of?(Hash) || other_ptr[key].instance_of?(Hash)
          return false
        end
      end
    end

    true
  end

  def contains_no_blank_values_deep
    stack = [self]

    while !stack.empty?
      self_ptr = stack.pop

      self_ptr.values.each do |value|
        return false if value.blank?

        stack.push(value) if value.instance_of?(Hash)
      end
    end

    true
  end

end
