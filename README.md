# whalespeak
converts text to and from the language of the whales

## installing
```
git clone https://github.com/djanatyn/whalespeak.git --depth=1
cd whalespeak
rake build; rake install
```

gem to be hosted on rubygems shortly.

## usage
```ruby
# use the default dialect
puts Whalespeak::CommonWhale.to_whalespeak('hello world')

# create your own dialect
my_dialect = Whalespeak::Converter.new ['a','b','c','d']
puts my_dialect.to_whalespeak('hello there')
```

whalespeak also includes a command line program that uses Common Whale:
```
./whalespeak <args> 'text to convert'
```

## how?

works by:
- creating a mapping of digits to characters
- unpacking a string to it's binary representation
- converting that binary representation to a base-n string (where n is the number of characters used in the encoding)
- substituting each digit with it's mapping

## why?

because whales!

## examples
whales are very verbose.

english | whalespeak
--------|-----------
hello i am a whale | UddWdHuWHDwdOhhhoWhhDOHwddDhDohHOduDOwuoOwhOOdWdUHwhHddWWUHOu
i love krill | dOoUHouuUoWOwOwODDUuduwWhdWWWuuDdWOWUdHDOW
bye | uDwDDOoodw
