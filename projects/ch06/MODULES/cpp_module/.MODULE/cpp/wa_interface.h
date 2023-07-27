
#ifndef __CPP_MODULE_H_
#define __CPP_MODULE_H_


#include "plc-base/.MODULE/cpp/runtime_interface.h"


#ifdef __cplusplus
#include "plc-base/.MODULE/cpp/wa_fb_base.h"
#endif


#ifdef __cplusplus
extern "C" {
#endif

/************* Function Block cpp_counter *************/
#ifdef __cplusplus
extern "C" {
void __init_cpp_counter(FBData *self);
}

class cpp_counter : public IECFBBase {
    enum {
      LOC_IN1,  // VAR_INPUT, int
      LOC_CNT,  // VAR_OUTPUT, int
    };

  private:
    cpp_counter(const cpp_counter &);
    cpp_counter &operator=(const cpp_counter &);

  private:
    int IN1;
    int CNT;

  public:
    cpp_counter();
    virtual ~cpp_counter();
    virtual void call() override;

    const static int IEC_FIELD_CNT = 2;
};
#endif /* end of __cplusplus */
/*********** End Function Block cpp_counter ***********/

#ifdef __cplusplus
}
#endif

#endif /* end of __CPP_MODULE_H_ */

