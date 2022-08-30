---
title: Basic text manipulation in R and Python
layout: default
---

Text manipulations in R, Python, Perl, and bash have a number of things
in common, as many of these evolved from UNIX. When I use the term
*string* here, I’ll be referring to any sequence of characters that may
include numbers, white space, and special characters. Note that in R a
character vector is a vector of one or more such strings.

Some of the basic things we need to do are paste/concatenate strings
together, split strings apart, take subsets of strings, and replace
characters within strings. Often these operations are done based on
patterns rather than a fixed string sequence. This involves the use of
regular expressions, covered in Section 3.

## 1 R

In general, strings in R are stored in character vectors. R’s functions
for string manipulation are fully vectorized and will work on all of the
strings in a vector at once.

Here’s a [cheatsheet from
RStudio](https://raw.githubusercontent.com/rstudio/cheatsheets/main/strings.pdf)
on manipulating strings using the *stringr* package in R.

### 1.1 String manipulation in base R

A few of the basic R functions for manipulating strings are *paste*,
*strsplit*, and *substring*. *paste* and *strsplit* are basically
inverses of each other: *paste* concatenates together an arbitrary set
of strings (or a vector, if using the *collapse* argument) with a
user-specified separator character, while *strsplit* splits apart based
on a delimiter/separator. *substring* splits apart the elements of a
character vector based on fixed widths. *nchar* returns the number of
characters in a string. Note that all of these operate in a vectorized
fashion.

``` r
out <- paste("My", "name", "is", "Chris", ".", sep = " ")
paste(c("My", "name", "is", "Chris", "."), collapse = " ") # equivalent
```

    ## [1] "My name is Chris ."

``` r
nchar(out)
```

    ## [1] 18

``` r
strsplit(out, split = ' ')
```

    ## [[1]]
    ## [1] "My"    "name"  "is"    "Chris" "."

> *Note*
>
> Some string processing functions (such as *strsplit* above) can return
> multiple values for each input string (each element of the character
> vector). As a result, the functions will return a list, which will be
> a list with one element when the function operates on a single string.
>
> ``` r
> out <- c("Her name is Maya", "Hello everyone")
> strsplit(out, split = ' ')
> ```
>
>     ## [[1]]
>     ## [1] "Her"  "name" "is"   "Maya"
>     ## 
>     ## [[2]]
>     ## [1] "Hello"    "everyone"

Here are some examples of using *substring*:

``` r
times <- c("04:18:04", "12:12:53", "13:47:00")
substring(times, 7, 8)
```

    ## [1] "04" "53" "00"

``` r
substring(times[3], 1, 2) <- '01'   ## replacement
times
```

    ## [1] "04:18:04" "12:12:53" "01:47:00"

To identify particular subsequences in strings, there are several
closely-related R functions. *grep* will look for a specified string
within an R character vector and report back indices identifying the
elements of the vector in which the string was found. Note that using
the `fixed=TRUE` argument ensures that regular expressions are NOT used.
*gregexpr* will indicate the position in each string that the specified
string is found (use *regexpr* if you only want the first occurrence).
*gsub* can be used to replace a specified string with a replacement
string (use *sub* if you only want to replace only the first
occurrence).

``` r
dates <- c("2016-08-03", "2007-09-05", "2016-01-02")
grep("2016", dates)
```

    ## [1] 1 3

``` r
gregexpr("2016", dates)
```

    ## [[1]]
    ## [1] 1
    ## attr(,"match.length")
    ## [1] 4
    ## attr(,"index.type")
    ## [1] "chars"
    ## attr(,"useBytes")
    ## [1] TRUE
    ## 
    ## [[2]]
    ## [1] -1
    ## attr(,"match.length")
    ## [1] -1
    ## attr(,"index.type")
    ## [1] "chars"
    ## attr(,"useBytes")
    ## [1] TRUE
    ## 
    ## [[3]]
    ## [1] 1
    ## attr(,"match.length")
    ## [1] 4
    ## attr(,"index.type")
    ## [1] "chars"
    ## attr(,"useBytes")
    ## [1] TRUE

``` r
gsub("2016", "16", dates)
```

    ## [1] "16-08-03"   "2007-09-05" "16-01-02"

### 1.2 String manipulation using *stringr*

The *stringr* package wraps the various core string manipulation
functions to provide a common interface. It also removes some of the
clunkiness involved in some of the string operations with the base
string functions, such as having to to call *gregexpr* and then
*regmatches* to pull out the matched strings. In general, I’d suggest
using *stringr* functions in place of R’s base string functions.

Here’s

First let’s see *stringr*’s versions of some of the base R string
functions mentioned in the previous sections.

The basic interface to *stringr* functions is
`function(character_vector, pattern, [replacement])`.

Table 1 provides an overview of the key functions related to working
with patterns, which are basically wrappers for *grep*, *gsub*,
*gregexpr*, etc.

| Function                    | What it does                                                |
|-----------------------------|-------------------------------------------------------------|
| str_detect                  | detects pattern, returning TRUE/FALSE                       |
| str_count                   | counts matches                                              |
| str_locate/str_locate_all   | detects pattern, returning positions of matching characters |
| str_extract/str_extract_all | detects pattern, returning matches                          |
| str_replace/str_replace_all | detects pattern and replaces matches                        |

The analog of *regexpr* vs. *gregexpr* and *sub* vs. *gsub* is that most
of the functions have versions that return all the matches, not just the
first match, e.g. *str_locate_all* *str_extract_all*, etc. Note that the
\*\_all\* functions return lists while the non-\*\_all\* functions
return vectors.

To specify options, you can wrap these functions around the pattern
argument: `fixed(pattern, ignore_case)` and
`regex(pattern, ignore_case)`. The default is *regex*, so you only need
to specify that if you also want to specify additional arguments, such
as *ignore_case* or others listed under `help(regex)` (invoke the help
after loading *stringr*)

Here’s an example:

``` r
library(stringr)
str <- c("Apple Computer", "IBM", "Apple apps")

str_detect(str, fixed("app", ignore_case = TRUE))
```

    ## [1]  TRUE FALSE  TRUE

``` r
str_count(str, fixed("app", ignore_case = TRUE))
```

    ## [1] 1 0 2

``` r
str_locate(str, fixed("app", ignore_case = TRUE))
```

    ##      start end
    ## [1,]     1   3
    ## [2,]    NA  NA
    ## [3,]     1   3

``` r
str_locate_all(str, fixed("app", ignore_case = TRUE))
```

    ## [[1]]
    ##      start end
    ## [1,]     1   3
    ## 
    ## [[2]]
    ##      start end
    ## 
    ## [[3]]
    ##      start end
    ## [1,]     1   3
    ## [2,]     7   9

``` r
dates <- c("2016-08-03", "2007-09-05", "2016-01-02")
str_locate(dates, "20[^0][0-9]") ## regular expression: years begin in 2010
```

    ##      start end
    ## [1,]     1   4
    ## [2,]    NA  NA
    ## [3,]     1   4

``` r
str_extract_all(dates, "20[^0][0-9]")
```

    ## [[1]]
    ## [1] "2016"
    ## 
    ## [[2]]
    ## character(0)
    ## 
    ## [[3]]
    ## [1] "2016"

``` r
str_replace_all(dates, "20[^0][0-9]", "XXXX")
```

    ## [1] "XXXX-08-03" "2007-09-05" "XXXX-01-02"

## 2 Basic text manipulation in Python

Let’s see basic concatenation, splitting, working with substrings, and
searching/replacing substrings. Notice that Python’s string
functionality is object-oriented (though *len* is not). Note: apologies
for all the extra print statements in the code - this is required when
running Python chunks in R Markdown.

``` python
out = "My" + "name" + "is" + "Chris" +  "."
out
```

    ## 'MynameisChris.'

``` python
out = ' '.join(("My", "name", "is", "Chris", "."))
out
```

    ## 'My name is Chris .'

``` python
len(out) 
```

    ## 18

``` python
out.split(' ')
```

    ## ['My', 'name', 'is', 'Chris', '.']

Hitting tab after typing `out.` when *out* is a string will show the
full suite of string-related methods.

Unlike in R, you cannot use the string methods directly on a list or
tuple of strings, but you of course can do things like list
comprehension to easily process multiple strings.

Working with substrings relies on the fact that Python works with
strings as if they are vectors of individual characters.

``` python
var = "13:47:00"
var[3:5]
```

    ## '47'

However strings are immutable - you cannot alter a subset of characters
in the string. Another option is to work with strings as lists.

``` python
var = list("13:47:00")
var
```

    ## ['1', '3', ':', '4', '7', ':', '0', '0']

``` python
var[0:2] = ["0", "1"]
''.join(var)
```

    ## '01:47:00'

Now let’s consider finding substrings. Here Python tells us that ‘2016’
starts in the 6th position in the first and third elements (with 0-based
indexing).

``` python
vars = ["08-03-2016", "09-05-2007", "01-02-2016"]
vars[0].find('2016')
```

    ## 6

``` python
vars[1].find('2016')
```

    ## -1

``` python
[v.find('2016') for v in vars]
```

    ## [6, -1, 6]
