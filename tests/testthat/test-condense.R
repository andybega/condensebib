test_that("single RMarkdown file", {
  rmd_files <- "../testdata/r2.rmd"
  tmp_bib <- tempfile(fileext = ".bib")
  reduce_bib(rmd_files, "../testdata/main.bib", tmp_bib, check = FALSE)
  x <- read_bib(tmp_bib, check = FALSE)
  expect_equal(length(x), 2) ## only two cites
  dois <- lapply(x, function(g) g$doi)
  expect_true(dois[[1]] == "10.18637/jss.v040.i01")
  expect_true(is.null(dois[[2]]))
  unlink(tmp_bib)
})

test_that("multiple RMarkdown files", {
  rmd_files <- c("../testdata/r1.rmd", "../testdata/r2.rmd")
  tmp_bib <- tempfile(fileext = ".bib")
  reduce_bib(rmd_files, "../testdata/main.bib", tmp_bib, check = FALSE)
  x <- read_bib(tmp_bib, check = FALSE)
  expect_equal(length(x), 4) ## cohen is not there
  unlink(tmp_bib)
})
