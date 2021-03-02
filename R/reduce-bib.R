
#' Read a .bib file
#' 
#' Thin wrapper around [RefManageR::ReadBib()] that suppresses warnings and 
#' messages.
#' 
#' @param file Path to the .bib file. 
#' @param quiet Show [RefManageR::ReadBib()] output/warnings?
#' @param ... Arguments passed to [RefManageR::ReadBib()]
#' 
#' @examples 
#' \dontrun{
#'   master <- read_bib("master.bib")
#' }
#' 
#' @export
read_bib <- function(file, quiet = TRUE, ...) {
  if (isTRUE(quiet)) {
    return(suppressWarnings(suppressMessages(RefManageR::ReadBib(file, ...))))
  } else {
    return(RefManageR::ReadBib(file, ...))
  }
}

#' Write a .bib file
#' 
#' Thin wrapper around [RefManageR::WriteBib()].
#' 
#' @param bib A [RefManageR::BibEntry()] object.
#' @param ... Arguments passed to [RefManageR::WriteBib()]
#' 
#' @export
write_bib <- function(bib, ...) {
  RefManageR::WriteBib(bib, ...)
}


#' Reduce a central .bib file down to used elements
#' 
#' Condense a master.bib file to only the references that are used in a paper.
#' 
#' @param file path to the target .Rmd file
#' @param master_bib path to whistle/master.bib (or any other central .bib file 
#'   for that matter)
#' @param out_bib path/name of the output .bib file to write
#' 
#' @export
reduce_bib <- function(file, master_bib, out_bib) {
  doc <- readLines(file)
  cite_keys <- extract_cite_keys(doc)
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
  invisible(list(
    cite_keys = cite_keys,
    bib = bib
  ))
}




