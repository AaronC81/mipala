class Hash
  # Gets the first key which represents a given value in the Hash. Returns nil
  # if it does not exist.
  def key_for_value(value)
    rassoc_result = self.rassoc value
    rassoc_result.nil? ? nil : rassoc_result[0]
  end
end