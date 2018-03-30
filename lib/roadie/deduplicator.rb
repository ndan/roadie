module Roadie
  class Deduplicator
    def self.apply(input)
      new(input).apply
    end

    def initialize(input)
      @input = input
      @duplicates = false
    end

    def apply
      # Bail early for very small inputs
      input if input.size < 2

      strip_out_duplicates.values
    end

    private

    attr_reader :input, :latest_occurance

    def strip_out_duplicates
      input.each_with_object({}) do |style_property, memo|
        property = style_property.property

        if !memo[property] || !memo[property].important?
          memo[property] = style_property
        end
      end
    end
  end
end
