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
vars <- c("date98", "size98", "x98weights98", "sdfsd")
grep("98", vars)
gregexpr("98", vars)
gsub("98", "04", vars)


## @knitr stringr-example
library(stringr)
str <- c("Apple", "Basic", "applied apple")

str_locate(str, fixed("app", ignore_case = TRUE))
str_locate_all(str, fixed("app", ignore_case = TRUE))

str_locate(str, "a{1}[a-z]{2}") ## regular expression: 'a' then exactly two lower-case letters

## @knitr detect1

text <- c("Here's my number: 919-543-3300.", "hi John, good to meet you",
          "They bought 731 bananas", "Please call 919.554.3800")
str_detect(text, "[[:digit:]]")

## grep("[[:digit:]]", text, perl = TRUE)

## @knitr detect2

str_detect(text, "[:,\t\\.]")
## grep("[:,\t]", text)

str_locate_all(text, "[:,\t\\.]")
## gregexpr("[:,\t\\.]", text)

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
pattern <- "[[:digit:]]{3}[-\\.][[:digit:]]{3}[-\\.][[:digit:]]{4}"
str_extract_all(text, pattern)
## matches <- gregexpr(pattern, text)
## regmatches(text, matches)


## @knitr grouping
str_extract_all(text, "(1[-\\.])?([[:digit:]]{3}[-\\.]){1,2}[[:digit:]]{4}")
## matches <- gregexpr("(1[-\\.])?([[:digit:]]{3}[-\\.]){1,2}[[:digit:]]{4}", text)
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

## @knitr split
line <- "a dog\tjumped\nover \tthe moon."
cat(line)
str_split(line, "[[:space:]]+")
str_split(line, "[[:blank:]]+")


