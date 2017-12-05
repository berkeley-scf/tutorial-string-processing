## @knitr py-basics 
print( "My" + "name" + "is" + "Chris" +  "." )
out = ' '.join(("My", "name", "is", "Chris", "."))
print(out)
print( len(out) )
print( out.split(' ') )

## @knitr py-substrings 

var = "13:47:00"
print( var[3:5] )

## @knitr py-lists

var = list("13:47:00")
print( var )
var[0:2] = ["0", "1"]
print( ''.join(var) )


## @knitr py-find-substrings
vars = ["xxx98weights98", "blah"]
print( vars[0].find('98') )
print( vars[1].find('98') )
print( [v.find('98') for v in vars] )



## @knitr py-search
import re
text = ["Here's my number: 919-543-3300.", "hi John, good to meet you",
          "They bought 731 bananas", "Please call 919.554.3800"]
m = re.search("\d+", text[0])
print( m.group() )
print( m.start() )
print( m.end() )
print( m.span() )
 
## @knitr py-search2
import re
text = ["Here's my number: 919-543-3300.", "hi John, good to meet you",
          "They bought 731 bananas", "Please call 919.554.3800"]
print( re.findall("\d+", text[0]) )


## @knitr py-ignore-case

import re
str = "That cat in the Hat"
print( re.findall("hat", str, re.IGNORECASE) )


## @knitr py-list-comp

import re
text = ["Here's my number: 919-543-3300.", "hi John, good to meet you",
          "They bought 731 bananas", "Please call 919.554.3800"]

def return_group(pattern, txt):
    m = re.search(pattern, txt)
    if m:
       return(m.group())
    else:
       return(None)

print( [return_group("\d+", str) for str in text] )


## @knitr py-replace1

import re
text = ["Here's my number: 919-543-3300.", "hi John, good to meet you",
          "They bought 731 bananas", "Please call 919.554.3800"]
print( re.sub("\d", "Z", text[0]) )


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
text = ["Here's my number: 919-543-3300.", "hi John, good to meet you",
          "They bought 731 bananas", "Please call 919.554.3800"]
p = re.compile('\d+')
m = p.search(text[0])
print( m.group() )

