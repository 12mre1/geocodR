# source('R/remove_weird_characters.R')

test_that("weird characters are removed", {
  weird_address <- as.data.frame("720 Bathurst St #411, Toronto, ON M5S 2R4")
  expect_equal(as.character(remove_weird_characters(weird_address)[1,]),
               '720 Bathurst St  411, Toronto, ON M5S 2R4')
})

