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
vars = ["08-03-2016", "09-05-2007", "01-02-2016"]
print( vars[0].find('2016') )
print( vars[1].find('2016') )
print( [v.find('2016') for v in vars] )



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

## @knitr py-escape

strings = ["Hello", "Hello.", "Hello\nthere", "Hello\\nthere"]
print(strings[2])
print(strings[3])     
re.search(".", strings[0])     ## . means any character
re.search("\.", strings[0])    ## \. escapes the period and treats it literally
re.search("\.", strings[1])    ## \. escapes the period and treats it literally
re.search("\n", strings[2])    ## \n looks for the special symbol \n
re.search("\n", strings[3])    ## \n looks for the special symbol \n
re.search("\\\\", strings[3])  ## string parser removes two \ to give \\;
                               ## then in regex \\ treats second \ literally

