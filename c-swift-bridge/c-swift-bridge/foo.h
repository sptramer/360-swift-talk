//
//  foo.h
//  c-swift-bridge
//
//  Created by Stephen Tramer on 8/16/14.
//  Copyright (c) 2014 Millinneal Media, Inc. All rights reserved.
//

#ifndef __c_swift_bridge__foo__
#define __c_swift_bridge__foo__

enum SimpleEnum {
    value_A = 1,
    value_B
};

// Identical to NS_ENUM expansion
// BUT - swift doesn't allow it. It requires NS_ENUM to parse?
enum {
    TypedEnumA,
    TypedEnumB
};
typedef int TypedEnum;
  
struct SampleStruct {
    int x;
    double y;
    char z[4];
};

union SampleUnion {
    int32_t intRep;
    char byteRep[4];
};

char foo_1(char*);
double foo_2(int, double);
void foo_va(char* fmt, ...);
void foo_explict_va(const char* fmt, va_list args);

#endif /* defined(__c_swift_bridge__foo__) */
