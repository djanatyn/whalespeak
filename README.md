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

## examples
whales are very verbose.

english | whalespeak
--------|-----------
hello i am a whale | UddWdHuWHDwdOhhhoWhhDOHwddDhDohHOduDOwuoOwhOOdWdUHwhHddWWUHOu
i love krill | dOoUHouuUoWOwOwODDUuduwWhdWWWuuDdWOWUdHDOW
bye | uDwDDOoodw
