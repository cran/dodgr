## ----pkg-load, echo = FALSE, message = FALSE----------------------------------
library (dodgr)

## ----flowmat------------------------------------------------------------------
graph <- weight_streetnet (hampi, wt_profile = "foot")
set.seed (1)
from <- sample (graph$from_id, size = 10)
to <- sample (graph$to_id, size = 10)
flows <- matrix (10 * runif (length (from) * length (to)),
    nrow = length (from)
)

## ----initial-aggregation------------------------------------------------------
graph_f <- dodgr_flows_aggregate (graph, from = from, to = to, flows = flows)
head (graph_f)

## ----initial-summary----------------------------------------------------------
summary (graph_f$flow)

## ----flows-disperse-----------------------------------------------------------
dens <- rep (1, length (from)) # uniform densities
graph_f <- dodgr_flows_disperse (graph, from = from, dens = dens)
summary (graph_f$flow)

## ----merge-directed-----------------------------------------------------------
graph_undir <- merge_directed_graph (graph_f)

## ----print-graph-properties---------------------------------------------------
nrow (graph_f)
nrow (graph_undir) # the latter is much smaller

## ----merge-flows--------------------------------------------------------------
graph <- graph [graph_undir$edge_id, ]
graph$flow <- graph_undir$flow

## ----flowmap, eval = FALSE----------------------------------------------------
# graph_f <- graph_f [graph_f$flow > 0, ]
# dodgr_flowmap (graph_f, linescale = 5)

## ----flows_si_map1-png, echo = FALSE, eval = FALSE----------------------------
# graph_f <- dodgr_flows_si (graph, from = from, to = to)
# graph_undir <- merge_directed_graph (graph_f)
# graph <- graph [graph_undir$edge_id, ]
# graph$flow <- graph_undir$flow
# graph_f <- graph_f [graph_f$flow > 0, ]
# png (file.path (here::here (), "vignettes", "hampi-flowmap2.png"),
#     width = 480, height = 480, units = "px"
# )
# dodgr_flowmap (graph_f, linescale = 5)
# dev.off (which = dev.cur ())

## ----flows_si_map1, eval = FALSE----------------------------------------------
# graph_f <- dodgr_flows_si (graph, from = from, to = to)
# graph_undir <- merge_directed_graph (graph_f)
# graph <- graph [graph_undir$edge_id, ]
# graph$flow <- graph_undir$flow
# graph_f <- graph_f [graph_f$flow > 0, ]
# dodgr_flowmap (graph_f, linescale = 5)

## ----flows_si_map2-png, echo = FALSE, eval = FALSE----------------------------
# graph <- weight_streetnet (hampi, wt_profile = "foot")
# graph_f <- dodgr_flows_si (graph, from = from, to = to, k = 1e6)
# graph_undir <- merge_directed_graph (graph_f)
# graph <- graph [graph_undir$edge_id, ]
# graph$flow <- graph_undir$flow
# graph_f <- graph_f [graph_f$flow > 0, ]
# png (file.path (here::here (), "vignettes", "hampi-flowmap3.png"),
#     width = 480, height = 480, units = "px"
# )
# dodgr_flowmap (graph_f, linescale = 5)
# dev.off (which = dev.cur ())

## ----flows_si_map2, eval = FALSE----------------------------------------------
# graph <- weight_streetnet (hampi, wt_profile = "foot")
# graph_f <- dodgr_flows_si (graph, from = from, to = to, k = 1e6)
# graph_undir <- merge_directed_graph (graph_f)
# graph <- graph [graph_undir$edge_id, ]
# graph$flow <- graph_undir$flow
# graph_f <- graph_f [graph_f$flow > 0, ]
# dodgr_flowmap (graph_f, linescale = 5)

## ----graph-construction-repeat------------------------------------------------
graph <- weight_streetnet (hampi, wt_profile = "foot")
graphc <- dodgr_contract_graph (graph)
set.seed (1)
from <- sample (graphc$from_id, size = 10)
to <- sample (graphc$to_id, size = 5)
to <- to [!to %in% from]

## ----opt-source-targets-------------------------------------------------------
source_densities <- runif (length (from))
target_capacities <- runif (length (to))
target_capacities <- target_capacities *
    1.5 * sum (source_densities) / sum (target_capacities)

## ----optalloc-----------------------------------------------------------------
graph_f <- dodgr_flows_optalloc (
    graph,
    from = from,
    to = to,
    source_densities = source_densities,
    target_capacities = target_capacities
)
summary (graph_f$flow)

## ----eval = FALSE, echo = TRUE------------------------------------------------
# graph_undir <- merge_directed_graph (graph_f)
# graph <- graph [graph_undir$edge_id, ]
# graph$flow <- graph_undir$flow
# graph_f <- graph_f [graph_f$flow > 0, ]
# dodgr_flowmap (graph_f, linescale = 5)

## ----eval = FALSE, echo = FALSE-----------------------------------------------
# graph_undir <- merge_directed_graph (graph_f)
# graph <- graph [graph_undir$edge_id, ]
# graph$flow <- graph_undir$flow
# graph_f <- graph_f [graph_f$flow > 0, ]
# png (file.path (here::here (), "vignettes", "hampi-flowmap4.png"),
#     width = 480, height = 480, units = "px"
# )
# dodgr_flowmap (graph_f, linescale = 5)
# dev.off (which = dev.cur ())

