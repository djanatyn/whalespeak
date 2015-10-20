#!/usr/bin/env ruby
require 'trollop'

# ./whalespeak.rb
#
# converts text to and from the language of the whales
#
# works by:
# - creating a mapping of digits to characters
# - unpacking a string to it's binary representation
# - converting that binary representation to a base-n string (where n is the number of characters used in the encoding)
# - substituting each digit with it's mapping
#
# also randomizes capitalization because whales are expressive sometimes.

module Whalespeak

  module Exceptions
    class TooManyCharacters < Exception; end
  end

  class Conversion
    # choose characters for the language
    @@whale_characters = %w{o d u h w}
    if @@whale_characters.length > 10
      raise Whalespeak::Exceptions::TooManyCharacters, "too many characters in the whale language"
    end

    # generate mapping
    @@mapping = {}
    (0..@@whale_characters.length - 1).each do |n|
      @@mapping[n.to_s] = @@whale_characters[n]
    end

    @@base = @@mapping.length

    def self.to_whalespeak text
      # convert the string supplied to binary
      binary = text.unpack('b*').first

      # convert binary string to base 10 integer
      decimal_representation = binary.to_i(2)

      # convert decimal to base-n string
      base_string = decimal_representation.to_s(@@base)

      # convert each digit to the correct character
      whalespeak = base_string.chars.map {|digit| char = @@mapping[digit]}

      return whalespeak.join
    end

    def self.from_whalespeak text
      # convert each character to it's respective digit
      base_string = text.chars.map {|char| @@mapping.invert[char]}.join
      
      # convert base-n string to decimal
      decimal_representation = base_string.to_i(@@base)

      # convert decimal back to binary
      binary = decimal_representation.to_s(2)

      # add padding as needed
      bit_string = "0" * (8 - (binary.length % 8)) + binary

      converted_text = [bit_string].pack('b*')

      # convert back to string
      return converted_text
    end
  end
end
