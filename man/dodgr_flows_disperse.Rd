% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/flows.R
\name{dodgr_flows_disperse}
\alias{dodgr_flows_disperse}
\title{Aggregate flows dispersed from each point in a network.}
\usage{
dodgr_flows_disperse(
  graph,
  from,
  dens,
  k = 500,
  contract = TRUE,
  heap = "BHeap",
  tol = 1e-12,
  quiet = TRUE
)
}
\arguments{
\item{graph}{\code{data.frame} or equivalent object representing the network
graph (see Details)}

\item{from}{Vector or matrix of points \strong{from} which aggregate dispersed
flows are to be calculated (see Details)}

\item{dens}{Vectors of densities corresponding to the \code{from} points}

\item{k}{Width coefficient of exponential diffusion function defined as
\code{exp(-d/k)}, in units of distance column of \code{graph} (metres by default). Can
also be a vector with same length as \code{from}, giving dispersal coefficients
from each point. If value of \code{k<0} is given, a standard logistic polynomial
will be used.}

\item{contract}{If \code{TRUE} (default), calculate flows on contracted graph
before mapping them back on to the original full graph (recommended as this
will generally be much faster). \code{FALSE} should only be used if the \code{graph}
has already been contracted.}

\item{heap}{Type of heap to use in priority queue. Options include
Fibonacci Heap (default; \code{FHeap}), Binary Heap (\code{BHeap}),
Trinomial Heap (\code{TriHeap}), Extended Trinomial Heap
(\code{TriHeapExt}, and 2-3 Heap (\code{Heap23}).}

\item{tol}{Relative tolerance below which dispersal is considered to have
finished. This parameter can generally be ignored; if in doubt, its effect
can be removed by setting \code{tol = 0}.}

\item{quiet}{If \code{FALSE}, display progress messages on screen.}
}
\value{
Modified version of graph with additional \code{flow} column added.
}
\description{
Disperse flows throughout a network based on a input vectors of origin points
and associated densities
}
\note{
Spatial Interaction models are often fitted through trialling a range
of values of 'k'. The specification above allows fitting multiple values of
'k' to be done with a single call, in a way that is far more efficient than
making multiple calls. A matrix of 'k' values may be entered, with each
column holding a different vector of values, one for each 'from' point. For a
matrix of 'k' values having 'n' columns, the return object will be a modified
version in the input 'graph', with an additional 'n' columns, named 'flow1',
'flow2', ... up to 'n'. These columns must be subsequently matched by the
user back on to the corresponding columns of the matrix of 'k' values.
}
\examples{
graph <- weight_streetnet (hampi)
from <- sample (graph$from_id, size = 10)
dens <- rep (1, length (from)) # Uniform densities
graph <- dodgr_flows_disperse (graph, from = from, dens = dens)
# graph then has an additonal 'flows` column of aggregate flows along all
# edges. These flows are directed, and can be aggregated to equivalent
# undirected flows on an equivalent undirected graph with:
graph_undir <- merge_directed_graph (graph)
}
\seealso{
Other distances: 
\code{\link{dodgr_distances}()},
\code{\link{dodgr_dists_categorical}()},
\code{\link{dodgr_dists_nearest}()},
\code{\link{dodgr_dists}()},
\code{\link{dodgr_flows_aggregate}()},
\code{\link{dodgr_flows_si}()},
\code{\link{dodgr_isochrones}()},
\code{\link{dodgr_isodists}()},
\code{\link{dodgr_isoverts}()},
\code{\link{dodgr_paths}()},
\code{\link{dodgr_times}()}
}
\concept{distances}
