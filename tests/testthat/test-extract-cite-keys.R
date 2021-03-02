

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

