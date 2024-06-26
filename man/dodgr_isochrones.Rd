% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/iso.R
\name{dodgr_isochrones}
\alias{dodgr_isochrones}
\title{Calculate isochrone contours from specified points.}
\usage{
dodgr_isochrones(
  graph,
  from = NULL,
  tlim = NULL,
  concavity = 0,
  length_threshold = 0,
  heap = "BHeap"
)
}
\arguments{
\item{graph}{\code{data.frame} or equivalent object representing the network
graph. For \code{dodgr} street networks, this must be a network derived from
\pkg{silicate} ("sc") data, generated with \link{weight_streetnet}. This
function does not work with networks derived from \pkg{sf} data.}

\item{from}{Vector or matrix of points \strong{from} which isochrones are to
be calculated.}

\item{tlim}{Vector of desired limits of isochrones in seconds}

\item{concavity}{A value between 0 and 1, with 0 giving (generally smoother
but less detailed) convex iso-contours and 1 giving highly concave (and
generally more detailed) contours.}

\item{length_threshold}{The minimal length of a segment of the iso-contour
to be made more convex according to the 'concavity` parameter.. Low values
will produce highly detailed hulls which may cause problems; if in doubt, or
if odd results appear, increase this value.}

\item{heap}{Type of heap to use in priority queue. Options include
Fibonacci Heap (default; \code{FHeap}), Binary Heap (\code{BHeap}),
Trinomial Heap (\code{TriHeap}), Extended Trinomial Heap
(\code{TriHeapExt}, and 2-3 Heap (\code{Heap23}).}
}
\value{
A single \code{data.frame} of isochrones as points sorted anticlockwise
around each origin (\code{from}) point, with columns denoting the \code{from} points
and \code{tlim} value(s). The isochrones are given as \code{id} values and associated
coordinates of the series of points from each \code{from} point at the specified
isochrone times.

Isochrones are calculated by default using parallel computation with the
maximal number of available cores or threads. This number can be reduced by
specifying a value via \verb{RcppParallel::setThreadOptions (numThreads = <desired_number>)}.
}
\description{
Function is fully vectorized to calculate accept vectors of central points
and vectors defining multiple isochrone thresholds.
}
\note{
Isodists are calculated by default using parallel computation with the
maximal number of available cores or threads. This number can be reduced by
specifying a value via
\verb{RcppParallel::setThreadOptions (numThreads = <desired_number>)}.
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
x <- dodgr_isochrones (graph, from = from, tlim)
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
\code{\link{dodgr_isodists}()},
\code{\link{dodgr_isoverts}()},
\code{\link{dodgr_paths}()},
\code{\link{dodgr_times}()}
}
\concept{distances}
