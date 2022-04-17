
# 可以自行设置include路径
include_directories(${CMAKE_CURRENT_LIST_DIR})

# 可以自行设置各种flags
set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -g")

# 显示设置所有需要编译的文件
set (MOD_FULL_SRC
    ${CMAKE_CURRENT_LIST_DIR}/implements/cpp/wa_func.c
    ${CMAKE_CURRENT_LIST_DIR}/myfunc.c
    # 不编译错误的fake.c文件
)
