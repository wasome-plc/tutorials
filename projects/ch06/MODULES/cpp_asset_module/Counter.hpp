#pragma once

#include <stdint.h>

class Counter
{
public:
    int32_t IN;
    int32_t CNT;

    Counter();
    ~Counter();
    void do_count();
};
