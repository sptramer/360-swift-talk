360iDev 2014: Swift Interoperability In Depth
====

Here's a collection of slides and source code that you might find useful for the Swift Interoperability in Depth talk at 360iDev. The source code on the Swift side is meant to be as simple as possible, and there's a variety of available C constructs to play around with.

Slides
===
The slides are a good, high-level overview of the talk content. They'll be a nice, short reference if you want to keep some performance factors and bridging intricacies in mind when working on your own code! They're even relatively typo-free.

Caveats which were not in the talk
===
* SPECIAL THANKS to the gentleman who's name I've already forgotten who asked me about manualy performSelector: and objc_msgSend() on the Objective-C runtime from within Swift. These are actually NOT POSSIBLE - check your Apple documentation and you'll see that despite having Swift stubs for every other type of runtime interaction, these do NOT exist!
** But you can create an Objective-C wrapper function which calls them that is callable from Swift. Whew!
* You can absolutely do swizzling from inside Swift -- you just 'import ObjectiveC' and get all of your favorite friends from the runtime.
** You can do KVO, too -- just remember that the KVO observer itself must conform to the appropriate protocol, and that any properties you observe must be dynamic.

Sample projects
===

* swift-objc-bridging: An all-in-one project which bridges Swift to Objective-C, and back again.
* swift-c-bridge: The Swift project which calls the C code compiled into libfoo. It also contains the libbar source.
* c-swift-bridge: The C project which calls the Swift code compiles into libbar. It also contains the libfoo source.

Fun things for you to do
===
Here are a few things that you can do to learn more about the inner workings of Swift itself, how it compiles, what sort of optimizations it's capable of, and whether or not you can do certain A-to-B types of bridging when it comes to Swift. Why didn't I do them? Because exercises left to the reader are fun!

## Learn some Swift internals that will help you understand what's going on at the interoperability level!
* Compile some of the swift classes at various optimization levels and examine either the LLVM IR or the raw assembly generated (you'll need the command-line tools installed, and 'xcrun swiftc'.) You might be surprised at how much (or how little) changes -- although these functions are very simple and do not have in-depth call graphs on purpose.
** Hey, why don't you write some very detailed Swift functions and see what kind of optimizations happen? Recursion, overrides, convenience initializers -- see how these are affected (or not) by @objc, dynamic, and inheritance from NSObject.
* Write a Swift wrapper for foo_explicit_va() which takes varidic arguments.
* Try and determine the actual types assigned by the Swift compiler to the CVAListPointer during automatic promotion of String (tip: Apple-click on getVaList() and follow which types are possible by conforming to the CVarArgType protocol, and then setting breakpoints to examine values.)

## Play around with some Swift objects you can't use in C (or Objective-C!)
* Create a Swift object in C (tip: Use nm or otool to get mangled name for what you think is an initializer)
* libbar has the function func multireturn(x:CInt, y:CDouble) -> (CDouble, CDouble). Try and:
** Invoke this function correctly
** Parse its return value correctly

## Play around with some C types that are "not representable" in Swift!

* Use an UnsafeMutablePointer<Void> in Swift to create and initialize a SampleStruct object to pass to a C function you write that takes one. (tip: You might want to determine the structure's size and alignment.)
* Use an UnsafeMutablePointer<Void> in Swift to create a SampleUnion, initialize its byteRep value, and then extract that as an intRep value.


Useful Research links
====

* Swift-in-Flux, the documentation of all Swift bugs, fixes, and changes: https://github.com/ksm/SwiftInFlux
* Swift performance (as of 6b6): http://www.jessesquires.com/apples-to-apples-part-two/
* Swift name mangling & some implementation details: http://www.eswick.com/2014/06/inside-swift/
* The original source for the dlsym() C-to-Swift methodology: http://stackoverflow.com/questions/24245262/qa-call-a-method-from-a-string-in-swift
* NS_ENUM() and NS_OPTIONS() macros for enum expansion in Swift: http://albertmata.com/blog/2014/03/27/objective-c-ns-enum-and-ns-options/