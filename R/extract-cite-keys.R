#' Extract cite keys
#' 
#' Extract cite keys like "@foo:2014" or "\\cite\{foo:2014\}" from a markdown 
#' (.Rmd, .md) or Latex (.tex) file. 
#' 
#' @param doc a string character
#' @param verbose print extra progress messages
#' 
#' @returns a character vector of extracted cite keys
#' 
#' @export
#' 
#' @examples 
#' extract_cite_keys("@smith:2015")
#' extract_cite_keys("@smith2015first")
extract_cite_keys <- function(doc, verbose = FALSE) {
  set1 <- extract_cite_keys_md(doc, verbose)
  set2 <- extract_cite_keys_latex(doc, verbose)
  sort(unique(c(set1, set2)))
}


extract_cite_keys_md <- function(doc, verbose = FALSE) {
  cite_keys <- character(0)
  for(line in doc){
    if (stringr::str_detect(line, "@")) {
      keys_i <- stringr::str_match_all(line, "(^|[\\[,; -])@([[[:alnum:]]_\\-:]+)")[[1]][, 3]
      if (verbose) {
        cat(match(line, doc), " ", paste0(keys_i, collapse = ", "), "\n")
      }
      cite_keys <- c(cite_keys, keys_i)
    }
  }
  sort(unique(cite_keys))
}

has_cite_latex <- function(line) {
  stringr::str_detect(line, "cite[pt\\*(author)(year)]*[\\[\\][:alnum:]\", -]*\\{")
}

extract_keys_latex <- function(line) {
  # extract the whole cite command(s), to avoid false positives on figure/table
  # refs
  cmd <- stringr::str_match_all(line, "(cite[pt(author)(year)]?)[\\[\\][:alnum:]\", -]*\\{([[[:alnum:]]_\\-:,]+)\\}")[[1]][, 3]
  # extract the keys
  stringr::str_split(cmd, ",[ ]?")[[1]]
}

extract_cite_keys_latex <- function(doc, verbose = FALSE) {
  cite_keys <- character(0)
  for (line in doc) {
    if (has_cite_latex(line)) {
      keys_i <- extract_keys_latex(line)
      if (verbose) {
        cat(match(line, doc), " ", paste0(keys_i, collapse = ", "), "\n")
      }
      cite_keys <- c(cite_keys, keys_i)
    }
  }
  sort(unique(cite_keys))
}

