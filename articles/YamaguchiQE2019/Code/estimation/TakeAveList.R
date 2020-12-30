TakeAveList <- function(x) {
    ## Arg
    ##   x: list. each element is a matrix.
    ##
    ## Return
    ##   mean of the input matrices.

    n <- length(x)

    out <- x[[1]]

    if (length(x) > 1) {
        for (i in 2:n) {
            out <- out + x[[i]]
        }
    }

    out / n
}
