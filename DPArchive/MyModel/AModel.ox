#include "AModel.oxh"


AModel::Create() {
	Initialize(new AModel()); 
	Build();
	CreateSpaces();
	// SetDelta(Delta); 
    // SetUpdateTime(Time); 
    // Hooks::Add(«Time»,«»); 
	}

AModel::Build() {
//	SetClock();

//	Actions(ALIST);

//	EndogenousStates(«SLIST»);

//	RandomEffectGroups();
//	FixedEffectGroups();
	}
	

//AModel::Utility()  {	}	

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
