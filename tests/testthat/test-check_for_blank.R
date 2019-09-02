source('R/check_for_blank.R')
library(testthat)



test_that("blank returns error", {
  blank_address <- NA
  expect_error(check_for_blank(blank_address))
})

test_that('good address returns itself'){
  good_address <- "The White House"
  expect_equal(good_address, check_for_blank(good_address))
}
