
#ifndef __C_MODULE_H_
#define __C_MODULE_H_


#include "plc-base/.MODULE/cpp/runtime_interface.h"


#ifdef __cplusplus
extern "C" {
#endif

void greeting_from_c(char * msg);


/************* Function Block counter *************/
typedef struct counter_FUNCTION_BLOCK {
  int IN; // VAR_INPUT
  int CNT; // VAR_OUTPUT
} counter_FUNCTION_BLOCK;

void
__init_counter(counter_FUNCTION_BLOCK *self);

void
counter(counter_FUNCTION_BLOCK *self);
/*********** End Function Block counter ***********/

#ifdef __cplusplus
}
#endif

#endif /* end of __C_MODULE_H_ */

