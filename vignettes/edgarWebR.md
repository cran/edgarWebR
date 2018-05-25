---
title: "Introducing edgarWebR"
output: rmarkdown::html_vignette
date: "August 2, 2017"
autho: "Micah J Waldstein <micah@waldste.in>"
vignette: >
  %\VignetteIndexEntry{Introducing edgarWebR}
  %\VignetteEngine{knitr::rmarkdown}
  \usepackage[utf8]{inputenc}
---

There are plenty of packages for R that allow for fetching and manipulation of
companies' financial data, often fetching that direct from public filings with
the SEC. All of these packages have the goal of getting to the XBRL data,
containing financial statements, typically in annual (10-K) or quarterly (10-Q)
filings.

SEC filings however contain far more information. edgarWebR is the first step
in accessing that data by providing an interface to the SEC EDGAR search tools
and the metadata they provide.

## Current Features
 * Search for companies and mutual funds.
 * List filings for a company or mutual fund.
 * Get all information associated with a particular filing

## Simple Usecase
Using information about filings, we can use edgarWebR to see how long after the
close of a financial period it takes for a company to make a filing. We can
also see how that time has changed.

### Get Data
First, we'll fetch a bunch of 10-K and 10-Q filings for our given company using
`company_filings()`. To make sure we're going far enough back we'll take a peak
at the tail of our results

```r
ticker <- "EA"

filings <- company_filings(ticker, type = "10-", count = 100)
initial_count <- nrow(filings)
# Specifying the type provides all forms that start with 10-, so we need to
# manually filter.
filings <- filings[filings$type == "10-K" | filings$type == "10-Q", ]
```

Note that explicitly filtering caused us to go from 96 to
92 rows.


```r
filings$md_href <- paste0("[Link](", filings$href, ")")
knitr::kable(tail(filings)[, c("type", "filing_date", "accession_number", "size",
                               "md_href")],
             col.names = c("Type", "Filing Date", "Accession No.", "Size", "Link"),
             digits = 2,
             format.args = list(big.mark = ","))
```



|   |Type |Filing Date |Accession No.        |Size   |Link                                                                                   |
|:--|:----|:-----------|:--------------------|:------|:--------------------------------------------------------------------------------------|
|90 |10-Q |1996-08-14  |0000950005-96-000615 |72 KB  |[Link](https://www.sec.gov/Archives/edgar/data/712515/0000950005-96-000615-index.html) |
|91 |10-K |1996-07-01  |0000912057-96-013563 |197 KB |[Link](https://www.sec.gov/Archives/edgar/data/712515/0000912057-96-013563-index.html) |
|92 |10-Q |1996-02-14  |0000912057-96-002551 |85 KB  |[Link](https://www.sec.gov/Archives/edgar/data/712515/0000912057-96-002551-index.html) |
|93 |10-Q |1995-11-14  |0000912057-95-009843 |83 KB  |[Link](https://www.sec.gov/Archives/edgar/data/712515/0000912057-95-009843-index.html) |
|94 |10-Q |1995-08-10  |0000912057-95-006218 |142 KB |[Link](https://www.sec.gov/Archives/edgar/data/712515/0000912057-95-006218-index.html) |
|96 |10-Q |1995-02-13  |0000912057-95-000644 |83 KB  |[Link](https://www.sec.gov/Archives/edgar/data/712515/0000912057-95-000644-index.html) |

We've received filings dating  back to 1995 which seems good enough for our
purposes, so next we'll get the filing information for each filing.

So far we've done everything in base R, but now we'll use some useful functions
from dplyr and purrr to make things a bit easier.













