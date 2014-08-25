//
//  main.swift
//  swift-c-bridge
//
//  Created by Stephen Tramer on 8/16/14.
//  Copyright (c) 2014 Millinneal Media, Inc. All rights reserved.
//

import Foundation

let cStr: StringPtr = StringPtr.alloc(4)
cStr[0] = UInt8("F")
cStr[1] = UInt8("O")
cStr[2] = UInt8("O")
cStr[3] = UInt8(0)

if foo_1(UnsafeMutablePointer<Int8>(cStr)) == 0 {
    println("We found foo!")
}
else {
    println("What the heck?")
}
cStr.dealloc(4) // Note that Swift dealloc requires a specific amount of memory -- which is very very bad.

println("Our foo_2 is... \(foo_2(2, 1.5))")

//foo_va("%s %s %s", "foo", "bar", "baz") // Not allowed!!!

foo_explict_va("%s\t%s\t%d\n", getVaList(["Foo", "Bar", 2]))

let fooStr: COpaquePointer = COpaquePointer(("Foo" as NSString).UTF8String)
let barStr: COpaquePointer = COpaquePointer(("Bar" as NSString).UTF8String)

foo_explict_va("%s\t%s\t%d\n", getVaList([fooStr, barStr, 1]))
