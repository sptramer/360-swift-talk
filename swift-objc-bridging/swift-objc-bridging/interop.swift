//
//  interop.swift
//  swift-objc-bridging
//
//  Created by Stephen Tramer on 8/24/14.
//  Copyright (c) 2014 Millinneal Media, Inc. All rights reserved.
//

import Foundation

class Foo : NSObject { // Automatically @objc and dynamic
    func a() {
        println("Hello from Foo::a()!");
    }
    
    @objc func b() {
        println("Hello from Foo::b()!");
    }
    
    dynamic func c() {
        println("Hello from Foo::c()!");
    }
}

/*
 * NOTE: Because Bar does not inherit from an Objective-C base class,
 * it has no concept of what Objective-C considers required for such a class -
 * such as +[NSObject alloc] or -[NSObject init]. This means we need a class
 * method, within Swift, to construct a new object.
 */
@objc
class Bar {
    private func a(x: Int) -> Int { // private keyword Prevents exposure via @objc
        return x*x;
    }
    
    class func newInstance() -> Bar {
        return Bar();
    }
    
    @objc func b(x: Int) -> Int {
        return x*x;
    }
    
    dynamic func c(x: Int) -> Int { // 'dynamic' is a compiler hint
        // dynamic also implies @objc -- for now (Xcode 6b6)
        return x*x;
    }
}

class FooBar { // Not exposed to Objective-C
    func a(x: Int) -> Int {
        return x*x;
    }
    
    func b(x: Int) -> Int {
        return x*x;
    }
    
    func c(x: Int) -> Int {
        return x*x;
    }
}