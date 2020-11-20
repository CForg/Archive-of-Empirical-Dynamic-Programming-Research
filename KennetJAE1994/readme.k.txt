M. Kennet, "A Structural Model of Aircraft Engine Maintenance", Journal 
of Applied Econometrics, 1994, Vol. 9, No. 4, pp. 351-368.

The datafiles JT8REG.ASC, JT8DREG.ASC, JT9REG.ASC, and JT9DREG.ASC are the
final, "clean" ASCII data used in this paper. The filenames are defined as
follows: 

JT8REG.ASC  = data from JT8D engines, regulated years (1964-1977)

JT8DREG.ASC = data from JT8D engines, unregulated years (1977-1988)

JT9REG.ASC  = data from JT9D engines, regulated years

JT9DREG.ASC = data from JT9D engines, unregulated years.

The data in the files are unformatted.  Each row contains one observation as
follows:

CHOICE  STATE  DSTATE  AL2  AL3  AL4  AL5  AL6  AL7

where

CHOICE = trichotomous variable taking values
                0 do nothing
                1 convenience engine removal
                2 shop visit engine removal

STATE =  discretized state variable taking values 1 through 88, with odd
         values indicating no engine shutdown currently in history and
         even values indicating that the shutdown has occurred.  For example,
         State 1 indicates that the engine has less than 795 hours of flight
         time with no engine shutdown; State 2 indicates less than 795 hours
         of flight time, but with an engine shutdown.  The value of the
         state variable reverts to unity immediately following a shop visit.

DSTATE = difference between this month's state variable and last month's.

AL2
through
AL7    = indicators for Airlines numbered 2 through 7.  Note that there
         are only four airlines (i.e., AL2 through AL4) in the sample for
         JT9D engines.

Each observation represents one engine in one calendar month.  A complete
shop visit cycle begins in States 1, 2, 3, or 4 with Choice 0 and continues
to the point where we observe a Choice 2, at which point the cycle is
regenerated.

See Kennet (1994) for further details, or contact the author at

        kennetm@ore.psb.bls.gov

        Mark Kennet
        Economist
        Office of Economic Research
        U.S. Bureau of Labor Statistics
        Suite 4915
        2 Massachusetts Avenue, N.E.
        Washington, DC  20212
