% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/iso.R
\name{dodgr_isoverts}
\alias{dodgr_isoverts}
\title{Calculate isodistance or isochrone contours from specified points.}
\usage{
dodgr_isoverts(graph, from = NULL, dlim = NULL, tlim = NULL, heap = "BHeap")
}
\arguments{
\item{graph}{\code{data.frame} or equivalent object representing the network
graph. For \code{dodgr} street networks, this must be a network derived from
\pkg{silicate} ("sc") data, generated with \link{weight_streetnet}. This
function does not work with networks derived from \pkg{sf} data.}

\item{from}{Vector or matrix of points \strong{from} which isodistances or
isochrones are to be calculated.}

\item{dlim}{Vector of desired limits of isodistances in metres.}

\item{tlim}{Vector of desired limits of isochrones in seconds}

\item{heap}{Type of heap to use in priority queue. Options include
Fibonacci Heap (default; \code{FHeap}), Binary Heap (\code{BHeap}),
Trinomial Heap (\code{TriHeap}), Extended Trinomial Heap
(\code{TriHeapExt}, and 2-3 Heap (\code{Heap23}).}
}
\value{
A single \code{data.frame} of vertex IDs, with columns denoting the \code{from}
points and \code{tlim} value(s). The isochrones are given as \code{id} values and
associated coordinates of the series of points from each \code{from} point at the
specified isochrone times.

Isoverts are calculated by default using parallel computation with the
maximal number of available cores or threads. This number can be reduced by
specifying a value via \verb{RcppParallel::setThreadOptions (numThreads = <desired_number>)}.
}
\description{
Returns lists of all network vertices contained within the contours. Function
is fully vectorized to calculate accept vectors of central points and vectors
defining multiple isochrone thresholds. Provide one or more \code{dlim} values for
isodistances, or one or more \code{tlim} values for isochrones.
}
\examples{
\dontrun{
# Use osmdata package to extract 'SC'-format data:
library (osmdata)
dat <- opq ("hampi india") \%>\%
    add_osm_feature (key = "highway") \%>\%
    osmdata_sc ()
graph <- weight_streetnet (dat)
from <- sample (graph$.vx0, size = 100)
tlim <- c (5, 10, 20, 30, 60) * 60 # times in seconds
x <- dodgr_isoverts (graph, from = from, tlim)
}
}
\seealso{
Other distances: 
\code{\link{dodgr_distances}()},
\code{\link{dodgr_dists}()},
\code{\link{dodgr_dists_categorical}()},
\code{\link{dodgr_dists_nearest}()},
\code{\link{dodgr_flows_aggregate}()},
\code{\link{dodgr_flows_disperse}()},
\code{\link{dodgr_flows_si}()},
\code{\link{dodgr_isochrones}()},
\code{\link{dodgr_isodists}()},
\code{\link{dodgr_paths}()},
\code{\link{dodgr_times}()}
}
\concept{distances}
