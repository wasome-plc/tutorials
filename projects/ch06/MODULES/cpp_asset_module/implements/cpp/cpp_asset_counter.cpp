#include "../../.MODULE/cpp/wa_interface.h"
#include "../../Counter.hpp"

/************* Function Block cpp_asset_counter *************/
/* USER INCLUDE START */

/* USER INCLUDE END */

/* USER DECLARATION START */

/* USER DECLARATION END */

void __init_cpp_asset_counter(FBData *self) { self->fb_self = new cpp_asset_counter(); }

const int cpp_asset_counter::IEC_FIELD_CNT;

cpp_asset_counter::cpp_asset_counter() {
    value_map_len = cpp_asset_counter::IEC_FIELD_CNT;

    value_addr_map_ =
        (void **)malloc(cpp_asset_counter::IEC_FIELD_CNT * sizeof(void *));
    memset(value_addr_map_, 0, cpp_asset_counter::IEC_FIELD_CNT * sizeof(void *));
    value_bytes_map_ =
        (unsigned char *)malloc(cpp_asset_counter::IEC_FIELD_CNT);

    value_bytes_map_[LOC_IN1] = sizeof(int);
    value_bytes_map_[LOC_CNT] = sizeof(int);

    /* USER CONSTRUCT START */
    // pImpl = new UserClass();
    /* USER CONSTRUCT END */
}

cpp_asset_counter::~cpp_asset_counter() {
    /* USER DESTRUCT START */
    /* delete实现类 */
    delete (Counter *)(pImpl);
    /* USER DESTRUCT END */
}

void cpp_asset_counter::call() {
    /* USER CALL START */
    /* 调用实现类的方法 */
    ((Counter *)pImpl)->do_count();
    /* USER CALL END */
}

void cpp_asset_counter::fb_get_value(int index, void *out) {
    if (value_addr_map_[index]) {
        IECFBBase::fb_get_value(index, out);
        return;
    }

    /* USER GET START */
    auto my_class = (Counter *)(pImpl);

    switch (index) {
    case LOC_CNT:
        /* 缓存该变量的地址，下次获取值时直接运行第48行，提升执行效率 */
        value_addr_map_[index] = &my_class->CNT;
        *(long long int *)out = my_class->CNT;
        break;
    }
    /* USER GET END */
}

void cpp_asset_counter::fb_set_value(int index, void *value) {
    if (value_addr_map_[index]) {
        IECFBBase::fb_set_value(index, value);
        return;
    }

    /* USER SET START */
    auto my_class = (Counter *)(pImpl);

    switch (index) {
    case LOC_IN1:
        /* 缓存该变量的地址，下次赋值时直接运行第70行，提升执行效率 */
        value_addr_map_[index] = &my_class->IN1;
        my_class->IN1 = *(int *)value;
        break;
    }
    /* USER SET END */
}

/* USER CODE START */

/* USER CODE END */
/*********** End Function Block cpp_asset_counter ***********/
