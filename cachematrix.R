## Put comments here that give an overall description of what your
## functions do

## Write a short comment describing this function
##  The makeCacheMatrix creates and returns a list of functions
##  used by cacheSolve to get and set the inverted matrix in cache
makeCacheMatrix <- function(x = matrix()) {
        m.matrix <- NULL
        set <- function(y) {
                x <<- y
                m.matrix <<- NULL
        }
        get <- function()
                x
        setmatrix <- function(inverse)
                m.matrix <<- inverse
        getinverse <- function()
                m.matrix
        list(  set = set, 
               get = get,
               setmatrix = setmatrix,
               getinverse = getinverse
        )
}


## Write a short comment describing this function
## cacheSolve function calcluates the inverse of the matrix created in makeCacheMatrix and
## if the inverted matrix does not exist in cache, it computes the inverse of the matrix using solve.
## save a copy of the inverted matrix in the cache and returns the inverted matrix.
## Then saves a copy of the inverted matrix in the cache
## if it exist in the cache it returns the cache's copy instead.
cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
        cache <- x$getinverse()
        if (!is.null(cache)) {
                message("getting cached data")
                return(cache)
        }
        #
        matrix <- x$get()
        
        cache <- solve(matrix, ...)
        # set inverted matrix in cache
        x$setmatrix(cache)
        
        return(cache)
}
