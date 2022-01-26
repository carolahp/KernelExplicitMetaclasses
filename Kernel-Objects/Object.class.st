Class {
	#name : #Object,
	#superclass : #nil,
	#metaclass : #Class,
	#category : #'Kernel-Objects'
}

{ #category : #'as yet unclassified' }
Object >> -> anObject [
	"Answer an Association with myself as its key and anObject as its value."

	^ Association new key: self value: anObject
]

{ #category : #'as yet unclassified' }
Object >> = anObject [
	"Answer whether the receiver and the argument represent the same 
	object. If = is redefined in any subclass, consider also redefining the 
	message hash."

	^ self == anObject
]

{ #category : #'as yet unclassified' }
Object >> == anObject [
	"Primitive. Answer whether the receiver and the argument are the same 
	object (have the same object pointer). Do not redefine the message == in 
	any other class! Essential. No Lookup. Do not override in any subclass. 
	See Object documentation whatIsAPrimitive."

	<primitive: 110>
	self primitiveFailed
]

{ #category : #'as yet unclassified' }
Object >> asLink [
	^ ValueLink value: self
]

{ #category : #'as yet unclassified' }
Object >> asString [
	^ self printString
]

{ #category : #'as yet unclassified' }
Object >> at: index [
	"Primitive. Assumes receiver is indexable. Answer the value of an indexable element in the receiver. Fail if the argument index is not an  Integer or is out of bounds. Essential. Do not override in a subclass. See Object documentation whatIsAPrimitive."

	<primitive: 60>
	index isInteger
		ifTrue: [ self errorSubscriptBounds: index ].
	index isNumber
		ifTrue: [ ^ self basicAt: index asInteger ]
		ifFalse: [ self errorNonIntegerIndex ]
]

{ #category : #'as yet unclassified' }
Object >> at: index put: value [
	"Primitive. Assumes receiver is indexable. Store the second argument 
	value in the indexable element of the receiver indicated by index. Fail 
	if the index is not an Integer or is out of bounds. Or fail if the value is 
	not of the right type for this kind of collection. Answer the value that 
	was stored. Essential. Do not override in a subclass. See Object 
	documentation whatIsAPrimitive."

	<primitive: 61>
	index isInteger
		ifTrue: [ (index >= 1 and: [ index <= self size ])
				ifTrue: [ self errorImproperStore ]
				ifFalse: [ self errorSubscriptBounds: index ] ].
	index isNumber
		ifTrue: [ ^ self basicAt: index asInteger put: value ]
		ifFalse: [ self errorNonIntegerIndex ]
]

{ #category : #'as yet unclassified' }
Object >> basicAt: index [
	"Primitive. Assumes receiver is indexable. Answer the value of an indexable element in the receiver. Fail if the argument index is not an  Integer or is out of bounds. Essential. Do not override in a subclass. See Object documentation whatIsAPrimitive."

	<primitive: 60>
	index isInteger
		ifTrue: [ self errorSubscriptBounds: index ].
	index isNumber
		ifTrue: [ ^ self basicAt: index asInteger ]
		ifFalse: [ self errorNonIntegerIndex ]
]

{ #category : #'as yet unclassified' }
Object >> basicAt: index put: value [
	"Primitive. Assumes receiver is indexable. Store the second argument 
	value in the indexable element of the receiver indicated by index. Fail 
	if the index is not an Integer or is out of bounds. Or fail if the value is 
	not of the right type for this kind of collection. Answer the value that 
	was stored. Essential. Do not override in a subclass. See Object 
	documentation whatIsAPrimitive."

	<primitive: 61>
	index isInteger
		ifTrue: [ (index >= 1 and: [ index <= self size ])
				ifTrue: [ self errorImproperStore ]
				ifFalse: [ self errorSubscriptBounds: index ] ].
	index isNumber
		ifTrue: [ ^ self basicAt: index asInteger put: value ]
		ifFalse: [ self errorNonIntegerIndex ]
]

{ #category : #'as yet unclassified' }
Object >> basicCopy [
	"Answer a copy of the receiver that shares the receiver's instance variables. This is usually handled by the primitive, so the code below is for documentation."

	<primitive: 148>
	| class result sz |
	class := self class.
	class isVariable
		ifTrue: [ sz := self basicSize.
			result := class basicNew: sz.
			1 to: sz do: [ :i | result basicAt: i put: (self basicAt: i) ] ]
		ifFalse: [ result := class basicNew ].
	1 to: class instSize do: [ :i | result instVarAt: i put: (self instVarAt: i) ].
	^ result
]

{ #category : #'as yet unclassified' }
Object >> basicIdentityHash [
	"Answer a SmallInteger whose value is related to the receiver's identity.
	This method must not be overridden, except by SmallInteger.
	Primitive. Fails if the receiver is a SmallInteger. Essential.
	See Object documentation whatIsAPrimitive.

	Do not override. Use #identityHash unless you really know what you're doing.'"

	<primitive: 75>
	self primitiveFailed
]

{ #category : #'as yet unclassified' }
Object >> basicSize [
	"Primitive. Answer the number of indexable variables in the receiver. This value is the same as the largest legal subscript. Essential. Do not override in any subclass. See Object documentation whatIsAPrimitive."

	<primitive: 62>
	^ 0	"for fixed-size objects"
]

{ #category : #'as yet unclassified' }
Object >> become: otherObject [
	"Swap the object pointers of the receiver and the argument. After this, all variables in the entire system that used to point to the receiver now point to the argument, and vice-versa. Fails if either object is a SmallInteger."

	(Array with: self)
		elementsExchangeIdentityWith: (Array with: otherObject)
]

{ #category : #'as yet unclassified' }
Object >> beep [
	"Emit a short beep sound. Do nothing if the primitive fails."

	<primitive: 140>
	
]

{ #category : #'as yet unclassified' }
Object >> class [
	"Primitive. Answer the object which is the receiver's class. Essential. See Object documentation whatIsAPrimitive."

	<primitive: 111>
	self primitiveFailed
]

{ #category : #'as yet unclassified' }
Object >> copy [
	"Answer a copy of me. Subclasses should usually override this method to change copying behavior, not basicCopy. The exception is classes with unique instances, such as ByteSymbol. This operation does not generally copy all the objects that I refer to.."

	^ self basicCopy
]

{ #category : #'as yet unclassified' }
Object >> doesNotUnderstand: aMessage [
	"Handle a failed attempt to send the given message to the receiver because the receiver does not implement or inherit a method for the message selector. The 'doesNotUnderstand:' message is sent by the virtual machine when a message send fails. If the receiver has an error handling block, invoke it. Otherwise, report an error."

	"Object new argh"

	| errorString handler |
	errorString := 'Message not understood -> ' , aMessage asString.
	System log: errorString.
	System log: Character cr asString, 'CallStack:'.
	System log: thisContext stringCallStack asString.
	System snapshotAndQuit.
	
	"(handler := (Smalltalk at: #Processor) activeProcess errorHandler) 
		ifNil: [ self handleExceptionName: errorString context: thisContext ]
			ifNotNil: [ handler value: errorString value: self ].
		^ aMessage sentTo: self	"
	"resend the message if the user proceeds from the debugger"
]

{ #category : #'as yet unclassified' }
Object >> error: aString [
	"The default behavior for error: is the same as halt:. The code is replicated in order to avoid having an extra message send on the stack. This additional message is the one a subclass should override in order to change the error handling behavior."
	| handler |
	System log: 'Error: ', aString asString.
	System log: Character cr asString, 'CallStack:'.
	System log: thisContext stringCallStack asString.
	System snapshotAndQuit.
	
	"(handler := (Smalltalk at: #Processor) activeProcess errorHandler)
			ifNil: [ self handleExceptionName: aString context: thisContext ]
			ifNotNil: [ handler value: aString value: self ]"
]

{ #category : #'as yet unclassified' }
Object >> errorImproperStore [
	"Error: an improper store was attempted."

	self error: 'Improper store into indexable object.'
]

{ #category : #'as yet unclassified' }
Object >> errorNonIntegerIndex [
	"Error: attempting to use a non-integer object as an index."

	self error: 'Only integers should be used as indices.'
]

{ #category : #'as yet unclassified' }
Object >> errorNotIndexable [
	"Create an error notification that the receiver is not indexable."

	self error: ('Instances of ' , self class name, ' are not indexable. (I am ', self asString,')')
]

{ #category : #'as yet unclassified' }
Object >> errorSubscriptBounds: index [
	"Error: the given index is out of range."

	self error: 'Subscript is out of bounds: ' , index printString
]

{ #category : #'as yet unclassified' }
Object >> handleExceptionName: aString context: aContext [
	"Handle an error or halt with the given name in the given context."

	"Not yet implemented. For now, just print the error and exit."

	Object superclass
		ifNil: [ self
				putString: aString;
				putcr.
			System exitToDebugger ]
		ifNotNil: [ super error: aString ]	"exit to the VM debugger"
]

{ #category : #'as yet unclassified' }
Object >> hash [
	"Answer a SmallInteger whose value is related to the receiver's identity.
	May be overridden, and should be overridden in any classes that define = "

	^ self identityHash
]

{ #category : #'as yet unclassified' }
Object >> identityHash [
	"Answer a SmallInteger whose value is related to the receiver's identity. This method must not be overridden, except by SmallInteger. Primitive. Fails if the receiver is a SmallInteger. Essential. See Object documentation whatIsAPrimitive. Do not override!"

	^ self basicIdentityHash bitShift: 8
]

{ #category : #'as yet unclassified' }
Object >> ifNil: nilBlock [
	"Return self, or evaluate the block if I'm == nil (q.v.)"

	^ self
]

{ #category : #'as yet unclassified' }
Object >> ifNil: nilBlock ifNotNil: ifNotNilBlock [
	"Evaluate the block, unless I'm == nil (q.v.)"

	^ ifNotNilBlock value
]

{ #category : #'as yet unclassified' }
Object >> ifNotNil: ifNotNilBlock [
	"Evaluate the block, unless I'm == nil (q.v.)"

	^ ifNotNilBlock value
]

{ #category : #'as yet unclassified' }
Object >> ifNotNil: ifNotNilBlock ifNil: nilBlock [
	"If I got here, I am not nil, so evaluate the block ifNotNilBlock"

	^ ifNotNilBlock value
]

{ #category : #'as yet unclassified' }
Object >> initialize [
	"Initialize this object. Usually called by new when a new object is created. This default implementation does nothing."

	^ self
]

{ #category : #'as yet unclassified' }
Object >> instVarAt: index [
	"Primitive. Answer a fixed variable in an object. The numbering of the 
	variables corresponds to the named instance variables. Fail if the index 
	is not an Integer or is not the index of a fixed variable. Essential. See 
	Object documentation whatIsAPrimitive."

	"Access beyond fixed variables."

	<primitive: 73>
	^ self basicAt: index - self class instSize
]

{ #category : #'as yet unclassified' }
Object >> instVarAt: index put: anObject [
	"Primitive. Store a value into a fixed variable in an object. The numbering of the
	 variables corresponds to the named instance variables, followed by the indexed
	 instance variables. Fail if the index is not an Integer or is not the index of a fixed
	 variable or indexed variable. Essential. See Object documentation whatIsAPrimitive."

	<primitive: 174 error: ec>
	 (index isInteger 
		and: [ index between: 1 and: self class instSize + self basicSize]) 
			ifFalse: [ ^ self errorSubscriptBounds: index ].
	self isReadOnlyObject 
		ifTrue: [ ^ self modificationForbiddenFor: #instVarAt:put: index: index value: anObject ]
]

{ #category : #'as yet unclassified' }
Object >> isBehavior [
	"Answer true if I am a subclass of Behavior."

	^ false
]

{ #category : #'as yet unclassified' }
Object >> isCompiledMethod [
	^ false
]

{ #category : #'as yet unclassified' }
Object >> isContextPart [
	^ false
]

{ #category : #'as yet unclassified' }
Object >> isInteger [
	"Overridden to return true in Integer."

	^ false
]

{ #category : #'as yet unclassified' }
Object >> isKindOf: aClass [
	"Answer whether the class, aClass, is a superclass or class of the receiver."

	self class == aClass
		ifTrue: [ ^ true ]
		ifFalse: [ ^ self class inheritsFrom: aClass ]
]

{ #category : #'as yet unclassified' }
Object >> isNil [
	"Answer true if the receiver is nil."

	^ false
]

{ #category : #'as yet unclassified' }
Object >> isNumber [
	"Overridden to return true in Number, natch"

	^ false
]

{ #category : #'as yet unclassified' }
Object >> isSelfEvaluating [
	^ false
]

{ #category : #'as yet unclassified' }
Object >> isSmallInteger [
	^ false
]

{ #category : #'as yet unclassified' }
Object >> isSymbol [
	^ false
]

{ #category : #'as yet unclassified' }
Object >> mustBeBoolean [
	"Error: attempt to use a non-Boolean object as if it were true or false. This message is sent by the virtual machine."

	self error: 'NonBoolean receiver.'.
	^ true
]

{ #category : #'as yet unclassified' }
Object >> nextInstance [
	"Primitive. Answer the next instance after the receiver in the enumeration of all instances of this class. Fails if all instances have been enumerated. Essential. See Object documentation whatIsAPrimitive."

	<primitive: 78>
	^ nil
]

{ #category : #'as yet unclassified' }
Object >> nextObject [
	"Primitive. Answer the next object after the receiver in the enumeration of all objects. Answer 0 when all objects have been enumerated."

	<primitive: 139>
	self primitiveFailed
]

{ #category : #'as yet unclassified' }
Object >> perform: aSymbol [
	"Primitive. Send the receiver the unary message indicated by the 
	argument. The argument is the selector of the message. Invoke 
	messageNotUnderstood: if the number of arguments expected by the 
	selector is not zero. Optional. See Object documentation whatIsAPrimitive."

	<primitive: 83>
	^ self perform: aSymbol withArguments: (Array new: 0)
]

{ #category : #'as yet unclassified' }
Object >> perform: aSymbol with: anObject [
	"Primitive. Send the receiver the keyword message indicated by the 
	arguments. The first argument is the selector of the message. The other 
	argument is the argument of the message to be sent. Invoke 
	messageNotUnderstood: if the number of arguments expected by the 
	selector is not one. Optional. See Object documentation whatIsAPrimitive."

	<primitive: 83>
	^ self perform: aSymbol withArguments: (Array with: anObject)
]

{ #category : #'as yet unclassified' }
Object >> perform: selector withArguments: anArray [
	"Primitive. Send the receiver the keyword message indicated by the 
	arguments. The argument, selector, is the selector of the message. The 
	arguments of the message are the elements of anArray. Invoke 
	messageNotUnderstood: if the number of arguments expected by the 
	selector is not the same as the length of anArray. Essential. See Object 
	documentation whatIsAPrimitive."

	<primitive: 84>
	selector class = ByteSymbol
		ifFalse: [ ^ self error: 'selector argument must be a ByteSymbol' ].
	self primitiveFailed
]

{ #category : #'as yet unclassified' }
Object >> perform: selector withArguments: argArray inSuperclass: lookupClass [
	"NOTE:  This is just like perform:withArguments: except that the message lookup process begins, not with the receivers's class, but with the supplied superclass instead. It will fail if lookupcannot be found among the receiver's superclasses. Primitive. Essential. See Object documentation whatIsAPrimitive."

	<primitive: 100>
	selector class = ByteSymbol
		ifFalse: [ ^ self error: 'selector argument must be a ByteSymbol' ].
	selector numArgs = argArray size
		ifFalse: [ ^ self error: 'incorrect number of arguments' ].
	(self class == lookupClass
		or: [ self class inheritsFrom: lookupClass ])
		ifFalse: [ ^ self error: 'lookupClass is not in my inheritance chain' ].
	self primitiveFailed
]

{ #category : #'as yet unclassified' }
Object >> pointsTo: anObject [
	"Answer true if the receiver contains a reference to the given object."

	<primitive: 132>
	1 to: self class instSize do: [ :i | 
		(self instVarAt: i) == anObject
			ifTrue: [ ^ true ] ].
	1 to: self basicSize do: [ :i | 
		(self basicAt: i) == anObject
			ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #'as yet unclassified' }
Object >> primitiveFailed [
	"Announce that a primitive has failed."

	self error: 'a primitive has failed'
]

{ #category : #'as yet unclassified' }
Object >> printOn: aStream [
	"Print a description of me on the given stream."

	| n |
	n := self class name.
	aStream
		nextPutAll:
			(n first isVowel
				ifTrue: [ 'an ' ]
				ifFalse: [ 'a ' ]) , n
]

{ #category : #'as yet unclassified' }
Object >> printString [
	"Answer a string describing me."

	| stream |
	stream := WriteStream on: (String new: 100).
	self printOn: stream.
	^ stream contents
]

{ #category : #'as yet unclassified' }
Object >> putAscii: asciiValue [
	"Put the given ascii character (0..255) to standard output. Do nothing if this primitive is not supported."

	<primitive: 249>
	
]

{ #category : #'as yet unclassified' }
Object >> putString: aString [
	"Write the given string to the standard output stream."

	aString do: [ :ch | self putAscii: ch asciiValue ]
]

{ #category : #'as yet unclassified' }
Object >> putcr [
	"Write a carriage return to the standard output stream."

	self putAscii: 13
]

{ #category : #'as yet unclassified' }
Object >> respondsTo: aSymbol [
	"Answer whether the receiver's class or one of its superclasses has the given symbol as a message selector."

	^ self class canUnderstand: aSymbol
]

{ #category : #'as yet unclassified' }
Object >> setPinnedInMemory: aBoolean [
	"The VM's garbage collector routinely moves objects as it reclaims and compacts
	 memory. But it can also pin an object so that it will not be moved around in memory,
    while still being reclamable by the garbage collector. This can make
	 it easier to pass objects out through the FFI. Objects are unpinnned when created.
	 This primitive either pins or unpins an object, and answers if it was already pinned."
	<primitive: 184 error: ec>
	^self primitiveFailed
]

{ #category : #'as yet unclassified' }
Object >> shouldBePrintedAsLiteral [
	^ false
]

{ #category : #'as yet unclassified' }
Object >> shouldNotImplement [
	"Announce that, although the receiver inherits this message, it should not implement it."

	self error: 'This message is not appropriate for this object'
]

{ #category : #'as yet unclassified' }
Object >> size [
	"Primitive. Answer the number of indexable variables in the receiver. 
	This value is the same as the largest legal subscript. Essential. See Object 
	documentation whatIsAPrimitive."

	<primitive: 62>
	self class isVariable ifFalse: [self errorNotIndexable].
	^ 0
]

{ #category : #'as yet unclassified' }
Object >> someObject [
	"Primitive. Answer the first object in the enumeration of all objects."

	<primitive: 138>
	self primitiveFailed
]

{ #category : #'as yet unclassified' }
Object >> species [
	"Answer the preferred class for reconstructing the receiver, which is typically some kind of collection. For example, the response to this message determines the type of object returned by the collect: or select: messages. Species and class are not always the same. For example, the species of Interval is Array."

	^ self class
]

{ #category : #'as yet unclassified' }
Object >> subclassResponsibility [
	"This message sets up a framework for the behavior of subclasses of this class. Announce that the subclass should have implemented this message."

	self error: 'My subclass should have overridden one of my messages.'
]

{ #category : #'as yet unclassified' }
Object >> tryPrimitive: primIndex withArgs: argumentArray [
	"This method is a template that the Smalltalk simulator uses to 
	execute primitives. See Object documentation whatIsAPrimitive."

	<primitive: 118 error: #code>
	self primitiveFailed
]

{ #category : #'as yet unclassified' }
Object >> yourself [
	"Answer the receiver. Useful in cascaded message expressions."

	^ self
]

{ #category : #'as yet unclassified' }
Object >> ~= anObject [
	"Answer whether the receiver and the argument do not represent the same object."

	^ self = anObject == false
]

{ #category : #'as yet unclassified' }
Object >> ~~ anObject [
	"Answer whether the receiver and the argument are not the same object 
	(do not have the same object pointer)."

	^ self == anObject
		ifTrue: [ false ]
		ifFalse: [ true ]
]
