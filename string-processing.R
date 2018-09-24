## @knitr r-basics1
out <- paste("My", "name", "is", "Chris", ".", sep = " ")
paste(c("My", "name", "is", "Chris", "."), collapse = " ") # equivalent
strsplit(out, split = ' ')
nchar(out)


## @knitr r-basics2
times <- c("04:18:04", "12:12:53", "13:47:00")
substring(times, 7, 8)

substring(times[3], 1, 2) <- '01'   ## replacement
times

## @knitr r-pattern
dates <- c("2016-08-03", "2007-09-05", "2016-01-02")
grep("2016", dates)
gregexpr("2016", dates)
gsub("2016", "16", dates)


## @knitr stringr-example
library(stringr)
str <- c("Apple Computer", "IBM", "Apple apps")

str_locate(str, fixed("app", ignore_case = TRUE))
str_locate_all(str, fixed("app", ignore_case = TRUE))

dates <- c("2016-08-03", "2007-09-05", "2016-01-02")
str_locate(dates, "20[^0][0-9]") ## regular expression: years begin in 2010

## @knitr detect1

text <- c("Here's my number: 919-543-3300.", "hi John, good to meet you",
          "They bought 731 bananas", "Please call 919.554.3800")
str_detect(text, "[[:digit:]]")

## grep("[[:digit:]]", text, perl = TRUE)

## @knitr detect2

str_detect(text, "[:,\t.]")
## grep("[:,\t.]", text)

str_locate_all(text, "[:,\t.]")
## gregexpr("[:,\t.]", text)

str_extract_all(text, "[[:digit:]]+")
## matches <- gregexpr("[[:digit]]+", text)
## regmatches(text, matches)

str_replace_all(text, "[[:digit:]]", "Z")
## gsub("[[:digit:]]", "Z", text)


## @knitr location
str_detect(text, "^[[:upper:]]") # text starting with upper case letter
## grep("^[[:upper:]]", text) 

str_detect(text, "[[:digit:]]$") # text with a digit
## grep("[[:digit:]]$", text) 

## @knitr repetitions

text <- c("Here's my number: 919-543-3300.", "hi John, good to meet you",
          "They bought 731 bananas", "Please call 919.554.3800")
pattern <- "[[:digit:]]{3}[-.][[:digit:]]{3}[-.][[:digit:]]{4}"
str_extract_all(text, pattern)
## matches <- gregexpr(pattern, text)
## regmatches(text, matches)


## @knitr grouping
str_extract_all(text, "(1[-.])?([[:digit:]]{3}[-.]){1,2}[[:digit:]]{4}")
## matches <- gregexpr("(1[-.])?([[:digit:]]{3}[-.]){1,2}[[:digit:]]{4}", text)
## regmatches(text, matches)

## @knitr grouping2
text <- c("at the site http://www.ibm.com", "other text", "ftp://ibm.com")
str_locate(text, "(http|ftp):\\/\\/")
## gregexpr("(http|ftp):\\/\\/", text)

## @knitr references

text <- ('"H4NY07011","ACKERMAN, GARY L.","H","$13,242",,,')
clean_text <- str_replace_all(text, "([^\",]),", "\\1")
clean_text
cat(clean_text)
## gsub("([^\",]),", "\\1", text)

## @knitr greedy

text <- "Do an internship <b> in place </b> of <b> one </b> course."
str_replace_all(text, "<.*>", "")
## gsub("<.*>", "", text)

## @knitr greedy2

str_replace_all(text, "<.*?>", "")
## gsub("<.*?>", "", text)

## @knitr newlines
myex <- regex("<p>.*</p>", dotall = TRUE)
html_string <- "And <p>here is some\ninformation</p> for you."
str_extract(html_string, myex)
str_extract(html_string, "<p>.*</p>")


## @knitr split
line <- "a dog\tjumped\nover \tthe moon."
cat(line)
str_split(line, "[[:space:]]+")
str_split(line, "[[:blank:]]+")

## @knitr escaping

## last case here is literally a backslash and then 'n'
strings <- c("Hello", "Hello.", "Hello\nthere", "Hello\\nthere")
cat(strings, sep = "\n")
str_detect(strings, ".")           ## . means any character
## str_detect(strings, "\.")       ## \. looks for the special symbol \.
str_detect(strings, "\\.")         ## \\ says treat \ literally, which then escapes the .
str_detect(strings, "\n")          ## \n looks for the special symbol \n
## str_detect(strings, "\\")       ## \\ says treat \ literally, but \ is not meaningful regex
str_detect(strings, "\\\\")        ## R parser removes two \ to give \\; then in regex \\ treats second \ literally
                             



