#include "udf.h"

DEFINE_SOURCE(xmom_source, cell, thread, dS, eqn)
{
    real source, time;

    time = CURRENT_TIME;
    if(time < 20.0e-3)
    {
      source = -C_R(cell, thread)*2.0*9.81;
     }
     else if (time < 30.0e-3) {
	source = -C_R(cell, thread)*0.0*9.81;
     }
     else if (time < 40.0e-3) {
     	source = -C_R(cell, thread)*(-4.0)*9.81;
     }
     else
     {
      source = -C_R(cell, thread)*0.0*9.81;
     }

    dS[eqn] = 0.0;                  // derivative w.r.t. u

    return source;
}