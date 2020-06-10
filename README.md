Condense .bib
=============

<!-- badges: start -->
  [![R build status](https://github.com/andybega/condensebib/workflows/R-CMD-check/badge.svg)](https://github.com/andybega/condensebib/actions)
<!-- badges: end -->

Condense a global .bib file used for citations in a Rmarkdown article to a local .bib with only references that are used in the article. 

```r
library(condensebib)

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
remotes::install_github("andybega/condensebib")
```


