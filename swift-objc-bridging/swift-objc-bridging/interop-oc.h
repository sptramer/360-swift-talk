//
//  interop-oc.h
//  swift-objc-bridging
//
//  Created by Stephen Tramer on 8/24/14.
//  Copyright (c) 2014 Millinneal Media, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface interop_oc : NSObject

-(int)call_a:(int)x;
-(int)call_b:(int)x;
-(int)call_c:(int)x;

@end
