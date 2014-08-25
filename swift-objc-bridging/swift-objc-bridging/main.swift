//
//  main.swift
//  swift-objc-bridging
//
//  Created by Stephen Tramer on 8/22/14.
//  Copyright (c) 2014 Millinneal Media, Inc. All rights reserved.
//

import Foundation
import ObjectiveC

// Native to Objective-C
let f = Foo()
f.a()
f.b()
f.c()

// Objective-C decorated (has stubs)
let b = Bar()

println(b.b(2));
println(b.c(3));

// Bridge
let interop = interop_oc()
println(interop.call_a(1))
println(interop.call_b(2))
println(interop.call_c(3))
