#!/usr/bin/env ruby
require 'set'

# converts text to and from the language of the whales
#
# works by:
# - creating a mapping of digits to characters
# - unpacking a string to it's binary representation
# - converting that binary representation to a base-n string (where n is the number of characters used in the encoding)
# - substituting each digit with it's mapping
#
# also randomizes capitalization because whales are expressive sometimes.

$common_whale_alphabet = %w{o d u h w}

module Whalespeak

  module Exceptions
    class TooManyCharacters < StandardError; end
    class BadEncoding < StandardError; end
  end

  class Converter
    attr_reader :alphabet

    def initialize(alphabet)
      raise ArgumentError, "alphabet must be an array of characters" unless alphabet.class == Array
      @alphabet = alphabet

      if @alphabet.length > 10
        raise Whalespeak::Exceptions::TooManyCharacters, 'too many characters in the whale language'
      end

      # generate mapping
      @mapping = {}
      (0..@alphabet.length - 1).each do |n|
        @mapping[n.to_s] = @alphabet[n]
      end

      @base = @mapping.length
    end

    # Encode string text to whalespeak encoding.
    #
    # @param text [String] the text to encode
    # @return [String] the encoded text as whalespeak
    def to_whalespeak text
      # convert the string supplied to binary
      binary = text.unpack('b*').first

      # convert binary string to base 10 integer
      decimal_representation = binary.to_i(2)

      # convert decimal to base-n string
      base_string = decimal_representation.to_s(@base)

      # convert each digit to the correct character
      whalespeak = base_string.chars.map {|digit| char = @mapping[digit]}

      return whalespeak.join
    end

    def from_whalespeak text
      # validate the encoding
      character_set = Set.new @alphabet
      text_chars = text.chars.to_set

      raise Whalespeak::Exceptions::BadEncoding, "encoding looks wrong" unless text_chars.subset? character_set

      # convert each character to it's respective digit
      base_string = text.chars.map {|char| @mapping.invert[char]}.join
      
      # convert base-n string to decimal
      decimal_representation = base_string.to_i(@base)

      # convert decimal back to binary
      binary = decimal_representation.to_s(2)

      # add padding as needed
      bit_string = "0" * (8 - (binary.length % 8)) + binary

      converted_text = [bit_string].pack('b*')

      # convert back to string
      return converted_text
    end
  end

  class CommonWhale
    @@converter = Whalespeak::Converter.new $common_whale_alphabet

    # this does not send blocks
    def self.method_missing(method, *args)
      @@converter.send(method, *args)
    end
  end
end
