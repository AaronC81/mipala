module Mipala::Mixins
  module Contracts
    # Ensures that a variable is of a given type (and optionally non-empty
    # using #length), throwing an exception if not. If all checks pass, returns
    # the variable.
    def is_a! variable_val, variable_name, type, also_non_empty=false
      raise TypeError, "#{variable_name} must be a #{type}, got " \
        "#{variable_val.class}" unless variable_val.is_a? type

      raise ArgumentError, "#{variable_name} must not be empty" \
        if also_non_empty && variable_name.length == 0

      variable_val
    end

    # Ensures that a variable is an array consisting only of elements of a 
    # given type, and optionally also nil. If all checks pass, returns the
    # variable.
    def is_array! variable_val, variable_name, type, allow_nil=false
      raise TypeError, "#{variable_name} must be an Array of #{type}" \
        unless (variable_val.is_a? Array) && \
          variable_val.all? { |x| (x.is_a? type) || (allow_nil && x.nil?) }

      variable_val
    end
  end
end