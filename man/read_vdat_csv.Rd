% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/load-read_vdat_csv.r
\name{read_vdat_csv}
\alias{read_vdat_csv}
\title{Read data from an Innovasea Fathom VDAT CSV file}
\usage{
read_vdat_csv(src, record_types = NULL, show_progress = FALSE)
}
\arguments{
\item{src}{A character string with path and name of an Innovasea VDAT CSV
detection file. If only file name is given, then the file must be located
in the working directory.}

\item{record_types}{An optional vector of character strings with names of
record types to read from the file. E.g., "DET" for detection records.
Default (\code{NULL}) will read all record types present in input CSV
\code{src}.}

\item{show_progress}{Optional argument passed to \code{data.table::fread}'s
\code{showProgress}.}
}
\value{
A list of class \code{vdat_list} with one named element for each
record type and attributes: \code{fathom_csv_format_version} with version
of the input Fathom CSV format; \code{source} with version of
VDAT.exe used to create the input file.
}
\description{
Read data from an Innovasea Fathom VDAT CSV file
}
\details{
Reading is done via \code{\link[data.table]{fread}}.

All timestamp columns are assumed to be in UTC and are assigned
class \code{POSIXct}. The internal value of timestamps will include
fractional seconds but the printed value (i.e., displayed or written to
file) will be truncated according to \code{options()$digits.secs}. By
default (\code{options()$digits.secs = NULL}), values are truncated (i.e.,
rounded down) to the nearest second. To maintain the full resolution
present in the input Fathom CSV file, set \code{options(digits.secs = 6)}.
}
\examples{
\dontrun{
# Example 1. Read a single file

vrl_file <- system.file("extdata", "detection_files_raw",
  "VR2W_109924_20110718_1.vrl",
  package = "glatos"
)

temp_dir <- tempdir()

csv_file <- vdat_convert(vrl_file, out_dir = temp_dir)

# utils::browseURL(temp_dir)

# read all record types
vdat <- read_vdat_csv(csv_file)

# read only one record type
vdat <- read_vdat_csv(csv_file, record_types = c("DET"))


# Example 2. Read and combine detection records from multiple files

# get two example files
vrl_files <- system.file("extdata", "detection_files_raw",
  c(
    "VR2W_109924_20110718_1.vrl",
    "HR2-180_461396_2021-04-20_173145.vdat"
  ),
  package = "glatos"
)

csv_files <- vdat_convert(vrl_files, out_dir = temp_dir)


# using dplyr

library(dplyr)

# basic steps: import each to list element, subset DET records,
#              add column with source file name, combine.

det2_tbl <- csv_files \%>\%
  lapply(
    function(x) {
      read_vdat_csv(x, record_types = "DET")$DET \%>\%
        dplyr::as_tibble() \%>\%
        mutate(source_file = basename(x))
    }
  ) \%>\%
  bind_rows()


# using data.table

library(data.table)

det2_dt <- rbindlist(
  lapply(
    csv_files,
    function(x) {
      read_vdat_csv(x, record_types = "DET")$DET[
        ,
        source_file := basename(x)
      ]
    }
  )
)


# get current version of digits.secs
op_digits.secs <- options()$digits.secs

# set digits.secs = NULL (default, truncates to nearest second)
options(digits.secs = NULL)

# note truncation to nearest second
vdat$DET$Time[2]

# set digits.secs to see fractional seconds
options(digits.secs = 6)

# note fractional seconds
vdat$DET$Time[2]

# return to default values
options(digits.secs = op_digits.secs)

# or specify via format \%OSn e.g., when writing to disk or external database
# see ?strptime
format(vdat$DET$Time[2], format = "\%Y-\%m-\%d \%H:\%M:\%OS6")
}

}
\author{
C. Holbrook (cholbrook@usgs.gov)
}
