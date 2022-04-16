#include "../../.MODULE/cpp/wa_interface.h"


/************* Function Block cpp_counter *************/
/* USER INCLUDE START */

/* USER INCLUDE END */

/* USER DECLARATION START */

/* USER DECLARATION END */

void __init_cpp_counter(FBData *self) { self->fb_self = new cpp_counter(); }

const int cpp_counter::IEC_FIELD_CNT;

cpp_counter::cpp_counter() {
    value_map_len = cpp_counter::IEC_FIELD_CNT;

    value_addr_map_ =
        (void **)malloc(cpp_counter::IEC_FIELD_CNT * sizeof(void *));
    value_addr_map_[LOC_IN] = &IN;
    value_addr_map_[LOC_CNT] = &CNT;

    value_bytes_map_ =
        (unsigned char *)malloc(cpp_counter::IEC_FIELD_CNT);
    value_bytes_map_[LOC_IN] = sizeof(int);
    value_bytes_map_[LOC_CNT] = sizeof(int);

    /* USER CONSTRUCT START */
    IN = 0;
    CNT = 0;
    /* USER CONSTRUCT END */
}

cpp_counter::~cpp_counter() {
    /* USER DESTRUCT START */

    /* USER DESTRUCT END */
}

void cpp_counter::call() {
    /* USER CALL START */
    CNT += IN;
    /* USER CALL END */
}

/* USER CODE START */

/* USER CODE END */
/*********** End Function Block cpp_counter ***********/
