
#ifndef __CPP_ASSET_MODULE_H_
#define __CPP_ASSET_MODULE_H_


#include "plc-base/.MODULE/cpp/runtime_interface.h"


#ifdef __cplusplus
#include "plc-base/.MODULE/cpp/wa_fb_base.h"
#endif


#ifdef __cplusplus
extern "C" {
#endif

/************* Function Block cpp_asset_counter *************/
#ifdef __cplusplus
extern "C" {
void __init_cpp_asset_counter(FBData *self);
}

class cpp_asset_counter : public IECFBBase {
    enum {
      LOC_IN1,  // VAR_INPUT, int
      LOC_CNT,  // VAR_OUTPUT, int
    };

  private:
    cpp_asset_counter(const cpp_asset_counter &);
    cpp_asset_counter &operator=(const cpp_asset_counter &);

  public:
    cpp_asset_counter();
    virtual ~cpp_asset_counter();
    virtual void call() override;
    virtual void fb_get_value(int index, void *out) override;
    virtual void fb_set_value(int index, void *value) override;

  private:
    const static int IEC_FIELD_CNT = 2;
    void *pImpl;
};
#endif /* end of __cplusplus */
/*********** End Function Block cpp_asset_counter ***********/

#ifdef __cplusplus
}
#endif

#endif /* end of __CPP_ASSET_MODULE_H_ */

