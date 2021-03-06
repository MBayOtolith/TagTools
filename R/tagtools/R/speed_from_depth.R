#' Estimate the forward speed of a diving animal 
#' 
#' This function is used to estimate the forward speed of a diving animal by first computing the depth-rate (i.e., the first differential of the depth) and then correcting for the pitch angle. or v=speed_from_depth(p,sampling_rate,fc) just estimate the depth-rate (i.e., the first differential of the depth). 
#' 
#' Possible input combinations: speed_from_depth(p,A) if p and A are lists, speed_from_depth(p,A,fc = fc) if p and A are lists, speed_from_depth(p,A,fc = fc,plim = plim) if p and A are lists, speed_from_depth(p,A,sampling_rate) if p and A are vectors/matrices, speed_from_depth(p,A,sampling_rate,fc) if p and A are vectors/matrices, speed_from_depth(p,A,sampling_rate,fc,plim) if p and A are vectors/matrices.
#' @param p The depth vector (a regularly sampled time series) in meters. sampled at sampling_rate Hz. This can either be a sensor list, or a vector.
#' @param A An nx3 acceleration matrix with columns [ax ay az]. Acceleration can be in any consistent unit, e.g., g or m/s^2. A must have the same number of rows as p.
#' @param sampling_rate The sampling rate of p and A in Hz (samples per second).
#' @param fc (optional) Specifies the cut-off frequency of a low-pass filter to apply to p after computing depth-rate and to A before computing pitch. The filter cut-off frequency is in Hz. The filter length is 4*sampling_rate/fc. Filtering adds no group delay. If fc is empty or not given, the default value of 0.2 Hz (i.e., a 5 second time constant) is used.
#' @param plim (optional) Specifies the minimum pitch angle in radians at which speed can be computed. Errors in speed estimation using this method increase strongly at low pitch angles. To avoid estimates with poor accuracy being used in later analyses, speed estimates at low pitch angles are replaced by NaN (not-a-number). The default threshold for this is 20 degrees.
#' @return A list with 2 elements:
#' \itemize{
#' \item{\strong{s: }}The forward speed estimate in m/s
#' \item{\strong{v: }} The depth-rate (or vertical velocity) in m/s
#' }
#' @note Output sampling rate is the same as the input sampling rate so s and v have the same size as p.
#' @note Frame: This function assumes a [north,east,up] navigation frame and a [forward,right,up] local frame. In these frames, a positive pitch angle is an anti-clockwise rotation around the y-axis. A descending animal will have a negative pitch angle.
#' @export

speed_from_depth <- function(p, A, sampling_rate, fc = NULL, plim = NULL) {
  # input checks-----------------------------------------------------------
  if (nargs() < 2) {
    stop("inputs p and A must be specified")
  }
  if (is.list(p) & is.list(A)) {
    if (nargs() < 3) {
      sampling_rate <- c()
    }
    if (nargs() < 4) {
      fc <- c()
    }
    plim <- fc 
    fc <- sampling_rate 
    sampling_rate <- p$sampling_rate 
    p <- p$data
    A <- A$data
  } else {
    if (missing(sampling_rate)) {
      stop("sampling_rate required for vector/matrix sensor data")
    }
    if (missing(fc)) {
      fc <- c()
    }
    if (missing(plim)) {
      plim <- c()
    }
  }
  sizearray <- dim(A)
  # second call type - no A
  if (sizearray[1] == 1 & sizearray[2] == 1) {
    if (nargs() < 3 | is.null(sampling_rate)) {
      fc <- 0.2 #default filter cut-off of 0.2 Hz
    } else {
      fc <- sampling_rate
    }
    sampling_rate <- A
    A <- c()
  } else {
    if (is.null(fc)) {
      fc <- 0.2  #default filter cut-off of 0.2 Hz
    }
  }
  if (is.null(plim)) {
    plim <- 20 / 180 * pi  #default 20 degree pitch angle cut-off
  }
  nf <- round(4 * sampling_rate / fc)
  abc <- p[2] - p[1]
  bcd <- diff(p)
  vec <- c(abc,bcd) * sampling_rate
  v <- fir_nodelay(vec, nf, fc / (sampling_rate / 2))$y
  if (!is.null(A)) {
    A <- fir_nodelay(A, nf, fc / (sampling_rate / 2))$y
    pitch <- a2pr(A)$p
    pitch[abs(pitch) < plim] = NA
    s <- v / sin(pitch)
  } else {
    s <- v
  }
  return(list(s = s, v = v))
}
