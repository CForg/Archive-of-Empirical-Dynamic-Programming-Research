COMPUTER CODE FOR THE IMPLEMENTATION OF THE NESTED PSEUDO LIKELIHOOD (NPL) 
ESTIMATOR OF DYNAMIC PROGRAMMING DISCRETE CHOICE MODELS


This ZIP file contains computer code that implements the NPL estimator 
proposed by Aguirregabiria and Mira in the papers "Swapping the Nested 
Fixed Point Algorithm: A Class of Estimators for Discrete Markov Decision 
Models," Econometrica, 70, 1519-1543, and "Sequential Estimation of 
Dynamic Discrete Games," Econometrica, 75 (1), 1--53. 
The code is written in GAUSS. 

--------------------------------------------------------------------------
SINGLE-AGENT DISCRETE-CHOICE DYNAMIC-PROGRAMMING MODELS 

FILES:

npl_sing.e	Program that estimates the bus replacement model in Rust 
		(Econometrica, 1987) using the NPL method. This program 
		calls the library nplprocs.lcg and the procedures 
		npl_sing.src, multilog.src , discthre.src and the 
		GAUSS dataset: bus1234.dat (bus1234.dht)

nplprocs.lcg	Gauss library

npl_sing.src	Procedure that estimates the structural parameters of a 
		discrete-choice single-agent dynamic programming model 
		using the Nested Pseudo Likelihood (NPL) algorithm in 
		Aguirregabiria and Mira (Econometrica, 2002). 
		It calls the procedures clogit.src.

clogit.src	Procedure for the Maximum Likelihood estimation of 
		McFadden Conditional Logit.

clogit.e 	Program that runs an example calling the procedure clogit.src.

multilog.src  	Procedure for the Maximum Likelihood estimation of 
		a Multinomial Logit.

multilog.e      Program that runs an example calling the procedure 
		multilog.src.

discthre.src	Procedure for the discretization and codification of 
		a variable using a prefixed vector of thresholds

bus1234.dat	Rust's bus replacement data set (bus engine groups 1, 2, 3 and 4)
bus1234.dht       

--------------------------------------------------------------------------------
DYNAMIC DISCRETE GAMES 

FILES:

mcarlo_psd_261207.prg	Programa that implements a Monte Carlo experiment on the 
			estimation of dynamic duopoly game of market entry-exit.
			The Monte Carlo experiment considers two-step estimator,
			NPL fixed points, and NPL estimator. The file includes
			all the procedures called in the program.

--------------------------------------------------------------------------------