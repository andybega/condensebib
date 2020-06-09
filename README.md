Condense .bib
=============

Condense a global .bib file used for citations in a Rmarkdown article to a local .bib with only references that are used in the article. 

```r
reduce_bib(
  file       = "my_paper.Rmd",
  master_bib = "../../central_bib_file.bib",
  out_bib    = "references.bib"
)
```

This will look for cite keys like "@author:2008" or google-style "@authoryearword" in the input .Rmd file, extract those cite keys from the master bib, and write them to a local bib. 

## Installation

Requires **RefManageR** and **stringr**. 

```r
source("https://raw.githubusercontent.com/andybega/condensebib/master/R/reduce-bib.R")
```


