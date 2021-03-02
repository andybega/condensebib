

test_that("return empty character vector if no matches", {
  expect_equal(extract_cite_keys(""), character(0))
})

test_that("match beginning of line", {
  expect_equal(extract_cite_keys("@valid:2011"), "valid:2011")
})

test_that("don't match email addresses", {
  expect_equal(extract_cite_keys("foo@gmail.com"), character(0))
})

test_that("cite key with '-' is matched", {
  expect_equal(extract_cite_keys("-@doe-smith:2017"), "doe-smith:2017")
})

test_that("Latex cite commands are recognized", {
  expect_equal(extract_cite_keys("\\cite{foo:2017}"), 
               "foo:2017")
})


# Latex -------------------------------------------------------------------


test_that("lines are correctly tagged", {
  expect_true(has_cite_latex("\\cite{foo:2017}"))
  expect_true(has_cite_latex("\\citep{foo:2017}"))
  expect_true(has_cite_latex("\\citet*{foo:2017}"))
  expect_true(has_cite_latex("\\citeauthor{foo:2017}"))
  expect_true(has_cite_latex("\\cite[foo][]{foo:2017}"))
  
  expect_false(has_cite_latex("\\hypersetup{colorlinks=true, urlcolor=blue, linkcolor=blue, citecolor=blue}"))
})

test_that("cite variants work correctly", {
  
  expect_equal(extract_keys_latex("\\cite{foo:2017}"), 
               "foo:2017")
  expect_equal(extract_keys_latex("\\cite{foo:2017,baz:2020}"), 
               c("foo:2017", "baz:2020"))
  expect_equal(extract_keys_latex("\\cite{foo:2017,baz:2020}"),
               c("foo:2017", "baz:2020"))
  expect_equal(extract_keys_latex("\\cite[foo][]{foo:2017}"),
               "foo:2017")
  
})



