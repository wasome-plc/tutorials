#include "../../.MODULE/cpp/wa_interface.h"

#include "stdio.h"

void greeting_from_c(char * msg) {
    printf("[c_module] %s\n", msg);
}

