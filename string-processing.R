## @knitr r-basics1
out <- paste("My", "name", "is", "Chris", ".", sep = " ")
paste(c("My", "name", "is", "Chris", "."), collapse = " ") # equivalent
strsplit(out, split = ' ')
nchar(out)


## @knitr r-basics2
vars <- c("P", "HCA24", "SOH02")
substring(vars, 2, 3)
substring(vars, 2, 3) <- 'ZZ'

## @knitr r-pattern
vars <- c("date98", "size98", "x98weights98", "sdfsd")
grep("98", vars)
gregexpr("98", vars)
gsub("98", "04", vars)


## @knitr stringr-basics 
out <- str_c("My", "name", "is", "Chris", ".", sep = " ")
str_c(c("My", "name", "is", "Chris", "."), collapse = " ") # equivalent
str_split(out, pattern = ' ')
vars <- c("P", "HCA24", "SOH02")
str_sub(vars, 2, 3)
str_sub(vars, 2, 3) <- 'ZZ'

## @knitr stringr-example
library(stringr)
str <- c("Apple", "Basic", "applied apple")

str_locate(str, fixed("app", ignore_case = TRUE))
str_locate_all(str, fixed("app", ignore_case = TRUE))

str_locate(str, "a{1}[a-z]{2}")

## @knitr detect1

addresses <- c("john@att.com", "stat243@bspace.berkeley.edu", "john_smith@att.com")
str_detect(addresses, "[[:digit:]_]")
## grep("[[:digit:]_]", addresses, perl = TRUE)


## @knitr detect2

text <- c("john","jennifer Pierce","Juan carlos rey")
str_detect(text, "[ \t]")
## grep("[ \t]", text)
str_locate_all(text, "[ \t]")
## gregexpr("[ \t]", text)
str_extract_all(text, "^[[:upper:]][[:lower:]]+ ")
## matches <- gregexpr("^[[:upper:]][[:lower:]]+ ", text)
## regmatches(text, matches)
str_replace_all(text, "^j", "J")
## gsub("^j", "J", text)

## @knitr location

text <- c("john","jennifer Pierce","Juan carlos rey")
str_detect(text, "^[[:upper:]]") # text starting with upper case letter
## grep("^[[:upper:]]", text) 
str_detect(text, "e$") # text with an "e" at the end
## grep("e$", text) 

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


