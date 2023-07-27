#include "../../.MODULE/cpp/wa_interface.h"


/************* Function Block counter *************/
void
__init_counter(counter_FUNCTION_BLOCK *self) {
    self->IN1 = 0;
    self->CNT = 0;
}

void
counter(counter_FUNCTION_BLOCK *self) {
    self->CNT += self->IN1;
}
/*********** End Function Block counter ***********/
