#' Extract cite keys
#' 
#' Extract cite keys like "@foo:2014" from a text (.Rmd, .md) file. 
#' 
#' @param doc a string character
#' 
#' @returns a character vector of extracted cite keys
#' 
#' @export
#' 
#' @examples 
#' extract_cite_keys("@smith:2015")
#' extract_cite_keys("@smith2015first")
extract_cite_keys <- function(doc){
  cite_keys <- character(0)
  for(line in doc){
    if (stringr::str_detect(line, "@")) {
      cite_keys_i <- stringr::str_match_all(line, "(^|[\\[,; -])@([[[:alnum:]]_\\-:]+)")[[1]][, 3]
      cite_keys <- c(cite_keys, cite_keys_i)
    }
  }
  return(unique(cite_keys))
}



