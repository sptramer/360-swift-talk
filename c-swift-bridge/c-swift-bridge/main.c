//
//  main.c
//  c-swift-bridge
//
//  Created by Stephen Tramer on 8/16/14.
//  Copyright (c) 2014 Millinneal Media, Inc. All rights reserved.
//

#include <stdio.h>
#include <dlfcn.h>

int main(int argc, const char * argv[]) {
    // The "C name" has one _ removed from the prefix since C function x is
    // managled as _x
    
    const char* swapName = "_TF3bar4swapFTRVSs5Int32RS0__T_";
    
    void (*swiftSwap)(long*, long*);
    char* error = NULL;
    void* module = dlopen("libbar.dylib", RTLD_LAZY);
    if ((error = dlerror()) != NULL) {
        printf("DYLIB load error: %s\n", error);
        return 1;
    }
    swiftSwap = dlsym(module, swapName);
    
    if ((error = dlerror()) != NULL) {
        printf("Method error: %s\n", error);
        return 1;
    }
    else {
        long x = 1;
        long y = 2;
        
        printf("x: %ld\ty: %ld\n", x, y);
        swiftSwap(&x, &y);
        printf("x: %ld\ty: %ld\n", x, y);
    }
    
    return 0;
}
