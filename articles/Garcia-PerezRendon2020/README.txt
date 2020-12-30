This README file guides users that would like to replicate results of the paper

"Family Job Seach and Wealth: The Added Workers Effect Revisited", by J.I. Garcia-Perez and S. Rendon.

1.
The SIPP data were downloaaded from the NBER webpage
https://data.nber.org/data/survey-of-income-and-program-participation-sipp-data.html

These downloads are dat-files and STATA dct-(dictionary) and do-files, all of them available in compressed form in the subdirectory "Data_Stata."

2.
The STATA do-file that creates the samples used in the paper is located in subdirectory "code". The samples are saved both in the subdirectory "data", and in the subdirectory "fortran".

These samples have the following endings:

_1hct: no more than one child, High School Graduates
_2hct: two children or more, High School Graduates
_1uct: no more than one child, College Graduates
_2uct: two children or more, College Graduates

Additionally, some files (used in the estimation for a job search model without wealth) have the following ending:

_1hcta: no more than one child, High School Graduates. NO WEALTH

3.
The samples are then processed by a FORTRAN code that 

i) creates descriptive statistics and exports them into a tex-file.
ii) creates Bootstrap moments and exports them into a tex-file and text-file.
iii) estimates the Dynamic Programming Model.
iv) simulates the model once estimated, creates predicted moments, and exports them into a tex-file.

This work is contained in the subdirectory "Estim_Fortran."

The main fortran program is resubjoinhet. This file is a parallelized fotran code that requires MPI. It first reads the file isel.out, which determines the sample to estimate. Once this is done, the corresponding sample labels are selected as well as the parameter file.

The parameter files read the initial parameters and some key parameters such as iwhat, which selects what to do, and ipar, which select what set of parameters will be estimated:

!***************1. What do do  **********************************    
!	iwhat=0                !Compute moments and bootstrap variances
!	iwhat=1                !estimate and transform parameters smm
!	iwhat=2                !standard deviations
!	iwhat=3                !simulations and reporting. One
!	iwhat=4                !Policy experiments
!	iwhat=5                !Policy experiments. Switch genders
!	iwhat=6                !Policy experiments. Switch genders
!********************************************************************
!***************2. Parameters  **********************************    
!	ipar=0                !All parameters estimated
!	ipar=1                !Pr(types) estimated
!	ipar=2                !Specific parameters of types estimated
!********************************************************************



There are three possible sets of parameters: those that are shared by all types, those that are type-specific, the proportion of each type. Some parameters, clearly the proportion of types, do not require that the Dynamic Programming problem is solved.

The parameters are selected for maximizations in subsets that are indicated by file orpar_*.out that determines which parameters and in what orders are sent to maximization. This file has notes that indicates the subsets of parameters that will be estimated.

By a referee's suggestion, we introduced search intensity into the model, but this extension did not contribute to fit the data and had identification problems. We left this version of the DP-model in the main code. However, in order to mimic a model without job search intensity, we muted this mechanism by constraining search intensities to be zero and job search costs to be very high.

Policy experiments are the three main experiments in the paper, plus the labor market gender switch. They are explained in the main fortran file.

The main program is in the MPI master program. It calls the Powell maximization routine for the function func, which calls several other objects.

The method of estimation is a simulated method of moments (SMM). The first task is to create the observed and bootstrap moments for the SMM criterion function. Then we proceed with estimating the parameters of the DP-Model. Then we compute standard errors, and then we perform comparative statics exercises.

Because there is heterogeneity, four types of couples, the DP-program has to be estimated four times. All moments computed for each type are stored in one matrix xmoments_types(m,types), from which a weighted sum is created to compute the moments for the whole sample. These moments are average values and averages of squared values, with which variances for the whole simulated population can be recreated. 

The files are organized as follows:

- resubjoinhet.f: main file that contains "include" terms to call other program objects:

- dpresubjoin.f: this block performs the DP-problem in the target function

- subwork.f: this is a subroutine that contains all the work that is done by the MPI-workers

- severalsub.f: this is a block than contains several subroutines invoked by the target function. T
This subroutine contains on its turn include commands to the following files:
- thresholds.f: this block defines the cuts for the wealth and wage buckets.
- producing.f: this block produces all the tables for the model
- tablemoment.f: this block recovers the moments from the tables
- momentable.f: this block recovers the tables from the moments     
- report.f: this block reports the tables in -tex files


- des_fit: this is a subroutine that performs the assessment of fit and does its reports.
This subroutine contains on its turn include commands to the following files:
- thresholds.f: this block defines the cuts for the wealth and wage buckets.
- momentables.f: this block recovers the tables from the actual moments     
- momentable.f: this block recovers the tables from the simulated moments     

- standevhet.f: this is a subroutine that computes the standard deviations of the estimated parameters. It has the option to store the target function derivatives or run the program using these stored derivatives to compute the standard errors.


This same structure exists for the estimation of the model without wealth, for which files are the same unless they have the ending "noa", for instance, "resubjoinhetnoa.f." 


The output of this code varies by the iwhat command. There are two types of output files out-files and tex-files. TeX-files are loadable directly in Scientific Workplace ore any LaTeX editor. 