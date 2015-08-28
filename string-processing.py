## @knitr py-basics 
print( "My" + "name" + "is" + "Chris" +  "." )
out = ' '.join(("My", "name", "is", "Chris", "."))
print(out)
print( len(out) )
print( out.split(' ') )

## @knitr py-substrings 

var = "HCA24"
print( var[1:3] )

## @knitr py-lists

var = list("HCA24")
print( var )
var[1:3] = ["Z", "Z"]
print( ''.join(var) )


## @knitr py-find-substrings
vars = ["xxx98weights98", "blah"]
print( vars[0].find('98') )
print( vars[1].find('98') )
print( [v.find('98') for v in vars] )



## @knitr py-search
import re
addresses = ["john@att.com", "stat243@bspace.berkeley.edu", 
  "john_smith3@att.com"]
m = re.search("[\d_]+", addresses[1])
print( m.group() )
print( m.start() )
print( m.end() )
print( m.span() )
 
## @knitr py-search2
import re
addresses = ["john@att.com", "stat243@bspace.berkeley.edu", 
  "john_smith3@att.com"]
m = re.search("[\d_]+", addresses[2])
print( m.group() )
print( m.start() )

## @knitr py-search3
import re
addresses = ["john@att.com", "stat243@bspace.berkeley.edu", 
  "john_smith3@att.com"]
print( re.findall("[\d_]+", addresses[2]) )

## @knitr py-ignore-case

import re
str = "That cat in the Hat"
print( re.findall("hat", str, re.IGNORECASE) )


## @knitr py-list-comp

import re
addresses = ["john@att.com", "stat243@bspace.berkeley.edu", 
  "john_smith3@att.com"]

def return_group(pattern, txt):
    m = re.search(pattern, txt)
    if m:
       return(m.group())
    else:
       return(None)

print( [return_group("[\d_]+", txt) for txt in addresses] )



## @knitr py-replace1

import re
text = ["john","holly pierce","Juan carlos rey"]
print( re.sub("^j", "J", text[0]) )
print( re.sub("^j", "J", text[1]) )


## @knitr py-replace2

import re
text = '"H4NY07011","ACKERMAN, GARY L.","H","$13,242",,,'
print( re.sub("([^\",]),", "\\1", text) )


## @knitr py-greedy

import re
text = "Do an internship <b> in place </b> of <b> one </b> course."
print( re.sub("<.*>", "", text) )
print( re.sub("<.*?>", "", text) )

## @knitr py-compile

import re
addresses = ["john@att.com", "stat243@bspace.berkeley.edu", "john_smith3@att.com"]
p = re.compile('\d+')
m = p.search(addresses[1])
print( m.group() )

