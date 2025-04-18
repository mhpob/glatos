dets_path <- system.file("extdata", "blue_shark_detections.csv",
  package = "glatos"
)
deploy_path <- system.file("extdata", "hfx_deploy_simplified.xlsx",
  package = "glatos"
)
tag_path <- system.file("extdata", "otn_nsbs_tag_metadata.xls",
  package = "glatos"
)

dets <- read_otn_detections(dets_path)
tags <- prepare_tag_sheet(tag_path, 5, 2)
deploy <- prepare_deploy_sheet(deploy_path, header_line = 1)


test_that("matches internal data: blue_shark_att", {
  expect_no_error(
    bs_att <- convert_otn_to_att(dets, tags, deploymentSheet = deploy)
  )

  # Check if expected and actual results are the same
  expect_identical(bs_att, blue_shark_att)
})

test_that("matches type/class of internal data: blue_shark_att", {
  bs_att <- convert_otn_to_att(dets, tags, deploymentSheet = deploy)

  expect_s3_class(bs_att, "ATT")
  expect_type(bs_att, "list")
})
