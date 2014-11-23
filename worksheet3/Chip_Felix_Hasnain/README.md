#Worksheet 3 Documentation

## Dates and Fates
*	*Wenesday 12.11.14* Start of WS3

##Helpful links

[Array2Table info for TODO](http://www.mathworks.de/help/matlab/ref/array2table.html)

## TODO's


*	Fill the worksheet or print out result table for exam.

## Theory Discussion
### Theory links:
[Gauss-Siedel method Wiki](http://en.wikipedia.org/wiki/Gauss-Seidel_method)

[Jacobi-Method Wiki](http://en.wikipedia.org/wiki/Jacobi_method)  

[Partial-Differentail Equations wiki](http://en.wikipedia.org/wiki/Partial_differential_equation)  

[Dirichlet Boundary](http://en.wikipedia.org/wiki/Dirichlet_boundary_condition#PDE)  

[Finite Difference](http://en.wikipedia.org/wiki/Finite_difference)  

###Open questions:
 
*	What is internally happening with solving with mldivide opposed to linsolve? It is even faster!!! Why???
        The backslash operator (mldivide) checks for matrix properties in order to apply the correct procedure. linsolve assumes sth., if no opts are specified. That's why wrong results may occur when using linsolve and not knowing what properties the respective matrix has. In order to be able to compare full matrix and sparse matrix calculations, mldivide is used in both cases.
*	So, why is Sparse so incredibly fast and for that, why not always just using sparse matrices intead of iterative scheme?
	As can be obtained from the result table, sparse matrices soon need more storage as indices for non-zero elements have to be stored as well.
*	Discuss the questions at the end of WS3.
*	Determine runtime and storage order.
*	What is the relation between R and e? e gets smaller with increasing Nx, but Rmin remains fixed (of course).
