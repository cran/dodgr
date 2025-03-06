## ----pkg-load, echo = FALSE, message = FALSE----------------------------------
library (dodgr)

## ----numcores-----------------------------------------------------------------
parallel::detectCores ()
RcppParallel::defaultNumThreads ()

## ----single-core, eval = FALSE------------------------------------------------
# RcppParallel::setThreadOptions (numThreads = 1L)

