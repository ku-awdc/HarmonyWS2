## TODO:

# move general setup code here so it is re-used
# use start/end functions
# set working directory and auto-cleanup anything created

library("tidyverse")
library("runjags")
library("knitr")

set.seed(2021-06-22)

# Reduce the width of R code output for PDF only:
if(params$presentation) options(width=60)
knitr::opts_chunk$set(echo = TRUE, eval=TRUE)

# Reduce font size of R code output for Beamer:
if(params$presentation){
  knitr::knit_hooks$set(size = function(before, options, envir) {
    if(before){
      knitr::asis_output(paste0("\\", options$size))
    }else{
      knitr::asis_output("\\normalsize")
    }
  })
  knitr::opts_chunk$set(size = "scriptsize")
}

# Collapse successive chunks:
space_collapse <- function(x){ gsub("```\n*```r*\n*", "", x) }
# Reduce space between chunks:
space_reduce <- function(x){ gsub("```\n+```\n", "", x) }
knitr::knit_hooks$set(document = space_collapse)

# To collect temporary filenames:
cleanup <- character(0)

exercise_start <- function(){
	rv <- ""
	if(params$presentation & !exercise_current){
		rv <- "\\begin{comment}"
		knitr::opts_chunk$set(eval = FALSE)
		exercise_current <<- TRUE
	}
	return(rv)
}

exercise_end <- function(){
	rv <- ""
	if(params$presentation & exercise_current){
		rv <- "\\end{comment}"
		knitr::opts_chunk$set(eval = TRUE)
		exercise_current <<- FALSE
	}
	return(rv)
}

exercise_current <- FALSE