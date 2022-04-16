// 这是一个已有的C++类库文件，其实现了一个Counter类

#include "Counter.hpp"

Counter::Counter()
{
    IN = 0;
    CNT = 0;
}

Counter::~Counter()
{
}

// 该类的执行函数，可以是任意名称
void Counter::do_count() {
    CNT += IN;
}
