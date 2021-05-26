#include "«MyModel».oxh"

«MyModel»::Create() {
	Initialize(new «MyModel»(), «INITARGS»); 
	Build();
	CreateSpaces(«CSARGS»);
	// SetDelta(Delta); 
    // SetUpdateTime(Time); 
    // Hooks::Add(«Time»,«»); 
	}

«MyModel»::Build() {
	SetClock(«CLK»,«CLKARGS»);

	«AVCREATE»
	Actions(«AVLIST»);

	«SVCREATE»
	EndogenousStates(«SVLIST»);
	oxwarning("Template put all state variables in Theta);

	«RECREATE»
	«FECREATE»
	RandomEffectGroups(«RELIST»);
	FixedEffectGroups(«FELIST»);
	}
	

«MyModel»::Utility()  {
	return zeros(OnlyFeasible(),1);
	}	

/*
«MyModel» :: Reachable()	{
            // Create as many separate conditions as required.
    if («endogenous state condition») return FALSE;     //NOT Reachable
    if («endogenous state condition») return TRUE;      //REACHABLE
    return TRUE;        //default return value
	}
*/


/* 
«MyModel»::FeasibleActions() {
    // column vector of 0s and 1s indicating which rows of A are feasible at the current state
    // Create as many as needed
    if («endogenous state condition»)
		return  0s for infeasible and 1s feasible;
    }
*/
