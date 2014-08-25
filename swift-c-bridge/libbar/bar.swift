//
//  bar.swift
//  swift-c-bridge
//
//  Created by Stephen Tramer on 8/17/14.
//  Copyright (c) 2014 Millinneal Media, Inc. All rights reserved.
//

import Foundation

enum Baz : CChar {
    // Swift does not have Character literals - just string literals that can be interpreted as Characters.
    // This certainly needs to be fixed. We also cannot cast them to Int8, UInt8, or CChar because swift
    // considers type coercion -- even of a literal -- to not be a constant value.
    
    case Tab = 0x09 // Character("\t").utf8
    case LF = 0x0A // Character("\n").utf8
    case CR = 0x0D // Character("\r").utf8
    
    func has_space(str: StringPtr, len: CInt) -> CBool {
        // NOTE: This has to be naieve because Swift's support for searching ranges in strings is quite lacking.
        // Furthermore it will not (smartly) enumerate blindly over a memory range.
        for i in 0..<Int(len) {
            
            // There is a type mismatch here(!!!) between UInt8 (StringPtr) and Int8 (CChar).
            // Note that there are no unsigned "C" types in Swift; this could be especially bad
            // for floating point types.
            
            let char: CChar = CChar(str[i])
            switch char {
                // Not sure why, but Swift explicitly demanded a reference to Baz here, even though the function
                // is part of the enumeration definition. Seems like a compiler bug, possibly due to the raw value
                // assignment?
            case Baz.Tab.toRaw():
                fallthrough
            case Baz.LF.toRaw():
                fallthrough
            case Baz.CR.toRaw():
                return true
            default:
                continue
                // no-op
            }
        }
        return false;
    }
}

struct BarS {
    let s: StringPtr
    var x: CInt
    
     init(in_s: StringPtr) {
        s = in_s
        x = 2
    }
    
     func f(y: CInt) -> CInt {
        return x * y;
    }
}

class Bar {
    let info: COpaquePointer
    
    dynamic init(x: COpaquePointer) {
        info = x
    }
    
    dynamic func f() -> StringPtr {
        let s: StringPtr = StringPtr.alloc(4)
        s[0] = UInt8("F")
        s[1] = UInt8("O")
        s[2] = UInt8("O")
        s[3] = 0x00
        
        return s
    }
}

func simple(s: StringPtr, b: CInt) {
    for i in 0..<b {
        println("Bar \(i): \(s)");
    }
}

func multireturn(x: CInt, y: CDouble) -> (CDouble, CDouble) {
    return (y / CDouble(x), CDouble(x) / y);
}

func swap(inout x: CInt, inout y: CInt) {
    let temp = x;
    x = y;
    y = temp;
}

func vargs(count: CInt, values: CInt...) {
    for i in 0..<count {
        print("\(values[Int(i)])\t");
    }
    print("\n");
}

func curry(x: CInt) -> (CInt) -> CInt {
    return { (y: CInt) -> CInt in  x * y };
}

infix operator  &*! {}
func &*! (l: CChar, r: CInt) -> StringPtr {
    let sPtr: StringPtr = StringPtr.alloc(Int(r)+1)
    // No way to specify specific type of i, for coercion? I guess we could interpret the range AS
    // something, but that's...
    
    for i in 0..<r {
        sPtr[Int(i)] = UInt8(l)
    }
    sPtr[Int(r)] = 0
    return sPtr;
}