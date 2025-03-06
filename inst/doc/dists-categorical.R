## ----pkg-load, echo = FALSE, message = FALSE----------------------------------
library (dodgr)

## ----hampi-edge-types---------------------------------------------------------
graph <- weight_streetnet (hampi, wt_profile = "foot")
graph <- graph [graph$component == 1, ]
graph$edge_type <- graph$highway
table (graph$edge_type)

## ----full-dists1--------------------------------------------------------------
v <- dodgr_vertices (graph)
from <- to <- v$id
d <- dodgr_dists_categorical (graph, from, to)
class (d)
length (d)
sapply (d, dim)

## ----summary-full-dists, eval = FALSE-----------------------------------------
# summary (d)

## ----summary-out, echo = FALSE, collapse = TRUE-------------------------------
s <- summary (d)

## ----prop-only----------------------------------------------------------------
dodgr_dists_categorical (graph, from, to,
                         proportions_only = TRUE)

## ----prop-only-benchmark, warning = FALSE-------------------------------------
bench::mark (full = dodgr_dists_categorical (graph, from, to),
             prop_only = dodgr_dists_categorical (graph, from, to,
                                                  proportions_only = TRUE),
             check = FALSE, time_unit = "s") [, 1:3]

## ----dists-dlimit-------------------------------------------------------------
dlimit <- 2000 # in metres
d <- dodgr_dists_categorical (graph, from, dlimit = dlimit)
dim (d)
head (d)

## ----hist-path----------------------------------------------------------------
hist (d$path / d$distance,
      xlab = "Relative proportions of trips along paths", main = "")

## ----hist-track---------------------------------------------------------------
hist (d$service / d$distance,
      xlab = "Relative proportions of trips along service ways", main = "")

## ----benchmark3, warning = FALSE----------------------------------------------
bench::mark (full = dodgr_dists_categorical (graph, from, to),
             prop_only = dodgr_dists_categorical (graph, from, to,
                                                  proportions_only = TRUE),
             dlimit = dodgr_dists_categorical (graph, from, dlimit = 2000),
             check = FALSE, time_unit = "s") [, 1:3]

