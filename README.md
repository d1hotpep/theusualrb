TheUsual
======

A handful of useful hacks...good for any project


#### Install
```gem install theusual```


#### Usage
```
require 'theusual'
TheUsual::load :all

Hash.map [:a, :b, :c] do |v|
  [ v, v ]
end
=> { a: :a, b: :b, c: :c }


[:a, nil, '', :b].compact :blanks
=> [ :a, :b ]
```
