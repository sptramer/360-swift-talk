//
//  foo.c
//  c-swift-bridge
//
//  Created by Stephen Tramer on 8/16/14.
//  Copyright (c) 2014 Millinneal Media, Inc. All rights reserved.
//

#include <string.h>
#include <stdio.h>
#include <stdarg.h>

#include "foo.h"


char foo_1(char* data) {
    union SampleUnion u;
    u.intRep = ('F') + ('O' << 8) + ('O' << 16);
    
    return (strncmp(data, u.byteRep, 4));
}

double foo_2(int x, double y) {
    struct SampleStruct s = {
        value_A,
        y * TypedEnumB,
        "BAR"
    };
    
    return (s.x + s.y * x * foo_1(s.z));
}

void foo_va(char* fmt, ...) {
    va_list args;

    va_start(args, fmt);
    vprintf(fmt, args);
    va_end(args);
}

void foo_explict_va(const char* fmt, va_list args)
{
    vprintf(fmt, args);
}