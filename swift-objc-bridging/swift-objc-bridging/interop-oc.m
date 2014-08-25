//
//  interop-oc.m
//  swift-objc-bridging
//
//  Created by Stephen Tramer on 8/24/14.
//  Copyright (c) 2014 Millinneal Media, Inc. All rights reserved.
//

#import "interop-oc.h"
#import "swift_objc_bridging-Swift.h"

@implementation interop_oc

-(int)call_a:(int)x
{
    Foo* foo = [[Foo alloc] init];
    
    [foo a];
    return 0;
}

-(int)call_b:(int)x
{
    Foo* foo = [[Foo alloc] init];
    Bar* bar = [Bar newInstance];
    
    [foo b];
    return (int)[bar b:x];
}

// Swift Int is really int64_t on 64-bit systems, int32_t on 32-bit systems -- BE CAREFUL!
// NSInteger is the same size as Int - it aliases to the type of the correct size.
// Note that CInt, the C-interoperable int, is Int32 in Swift.

-(int)call_c:(int)x
{
    Foo* foo = [[Foo alloc] init];
    Bar* bar = [Bar newInstance];
    
    [foo c];
    return (int)[bar c:x];
}

@end
