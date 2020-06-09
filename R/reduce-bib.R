
library(RefManageR)
library(stringr)

#' Read a .bib file
#' 
#' Thin wrapper around [RefManageR::ReadBib()] that suppresses warnings and 
#' messages.
#' 
#' @param file Path to the .bib file. 
#' 
#' @examples 
#' master <- read_bib("master.bib")
read_bib <- function(file, ...) {
  bib <- suppressWarnings(suppressMessages(RefManageR::ReadBib(file, ...)))
}

#' Write a .bib file
#' 
#' Thin wrapper around [RefManageR::WriteBib()].
#' 
#' @param bib A [RefManageR::BibEntry()] object.
#' @param ... Passed to [RefManageR::WriteBib()]
write_bib <- function(bib, ...) {
  RefManageR::WriteBib(bib, ...)
}

#' Strip cite keys
#' 
#' Strip cite keys like "@foo:2014" from a text (.Rmd, .md) file. 
#' 
#' @param doc a string character
#' 
#' @returns a character vector of extracted cite keys
#' 
#' @examples 
strip_cite_keys <- function(doc){
  cite_keys <- character(0)
  for(line in doc){
    if(str_detect(line, "@")) {
      cite_keys_i <- stringr::str_match_all(line, "(^|[\\[,; ])@([[[:alnum:]]_:]+)")[[1]][, 3]
      cite_keys <- c(cite_keys, cite_keys_i)
    }
  }
  return(unique(cite_keys))
}

#' Reduce a central .bib file down to used elements
#' 
#' Condense a master.bib file to only the references that are used in a paper.
#' 
#' @param file path to the target .Rmd file
#' @param master_bib path to whistle/master.bib (or any other central .bib file 
#'   for that matter)
#' @param out_bib path/name of the output .bib file to write
reduce_bib <- function(file, master_bib, out_bib) {
  doc <- readLines(file)
  cite_keys <- strip_cite_keys(doc)
  master    <- read_bib(master_bib)
  bib       <- master[cite_keys]
  if (!all(cite_keys %in% names(master))) {
    missing <- cite_keys[!cite_keys %in% names(master)]
    warning(sprintf(
      "Could not find entries in '%s' for key(s): %s",
      basename(master_bib), paste(missing, collapse = ", ")
    ))
  }
  write_bib(bib, out_bib)
  invisible(structure(
    cite_keys = cite_keys,
    bib = bib
  ))
}




