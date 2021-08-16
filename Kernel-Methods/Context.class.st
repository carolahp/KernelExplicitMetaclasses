Class {
	#name : #Context,
	#superclass : #Object,
	#role : 'Context',
	#type : #variable,
	#instVars : [
		'sender',
		'pc',
		'stackp',
		'method',
		'closureOrNil',
		'receiver'
	],
	#metaclass : #ContextMeta,
	#category : #'Kernel-Methods'
}

{ #category : #'as yet unclassified' }
Context >> blockCopy: numArgs [
	"Primitive. Distinguish a block of code from its enclosing method by creating a new BlockContext for that block. The compiler inserts into all methods that contain blocks the bytecodes to send the message blockCopy:. Do not use blockCopy: in code that you write! Only the compiler can decide to send the message blockCopy:. Fail if numArgs is not a SmallInteger. Optional. No Lookup. See Object documentation whatIsAPrimitive."

	<primitive: 80>
	^ (BlockClosure newForMethod: self home method)
		home: self home
		startpc: pc + 2
		nargs: numArgs
]

{ #category : #'as yet unclassified' }
Context >> callStack [
	^ self sender isNil 
		ifTrue:  [{ self } asOrderedCollection]
		ifFalse: [{ self } asOrderedCollection addAll: self sender callStack; yourself]
]

{ #category : #'as yet unclassified' }
Context >> isContextPart [
	^ true
]

{ #category : #'as yet unclassified' }
Context >> method [
	"Answer the context that sent the message that created the receiver."

	^ method
]

{ #category : #'as yet unclassified' }
Context >> printOn: aStream [
	aStream
		nextPutAll:  '*', receiver asString, '* ';
		nextPutAll: receiver class asString;
		nextPutAll: '(', method methodClass asString, ')';
		nextPutAll: ' >>> ';
		nextPutAll: method selector asString
]

{ #category : #'as yet unclassified' }
Context >> receiver [
	"Answer the context that sent the message that created the receiver."

	^ receiver
]

{ #category : #'as yet unclassified' }
Context >> sender [
	"Answer the context that sent the message that created the receiver."

	^ sender
]

{ #category : #'as yet unclassified' }
Context >> stringCallStack [
	| stream |
	stream := WriteStream on: (String new: 100).
	self callStack do: [:contx | 
		stream 
			nextPutAll: contx asString;
			nextPutAll: Character cr asString ].
	^ stream contents
]

Context >> object: anObject instVarAt: anIndex [
	"Primitive. Answer a fixed variable in an object. The numbering of the 
	 variables corresponds to the named instance variables. Fail if the index 
	 is not an Integer or is not the index of a fixed variable. Essential for the
	 debugger. See  Object documentation whatIsAPrimitive."

	<primitive: 73>
	"Access beyond fixed variables."
	^self object: anObject basicAt: anIndex - (self objectClass: anObject) instSize
]

Context >> object: anObject instVarAt: anIndex put: aValue [
	"Primitive. Store a value into a fixed variable in the argument anObject.
	 The numbering of the variables corresponds to the named instance
	 variables.  Fail if the index is not an Integer or is not the index of a
	 fixed variable.  Answer the value stored as the result. Using this
	 message violates the  principle that each object has sovereign control
	 over the storing of values into its instance variables. Essential for the
	 debugger. See Object documentation whatIsAPrimitive."

	<primitive: 74>
	"Access beyond fixed fields"
	^self object: anObject basicAt: anIndex - (self objectClass: anObject) instSize put: aValue
]

Context >> object: anObject basicAt: index [
	"Answer the value of an indexable element in the argument anObject without sending
	 it a message. Fail if the argument index is not an Integer or is out of bounds, or if
	 anObject is not indexable. This mimics the action of the VM when it indexes an object.
	 Used to simulate the execution machinery by, for example, the debugger.
	 Primitive.  See Object documentation whatIsAPrimitive."

	<primitive: 60>
	index isInteger ifTrue: [self errorSubscriptBounds: index].
	index isNumber
		ifTrue: [^self object: anObject basicAt: index asInteger]
		ifFalse: [self errorNonIntegerIndex]
]

Context >> object: anObject basicAt: index put: value [
	"Store the last argument 
	 value in the indexable element of the argument anObject indicated by index without sending
	 anObject a message. Fail if the argument index is not an Integer or is out of bounds, or if
	 anObject is not indexable, or if value is an inappropriate value for anObject's indexable slots.
	 This mimics the action of the VM when it indexes an object.
	 Used to simulate the execution machinery by, for example, the debugger.
	 Primitive.  See Object documentation whatIsAPrimitive."

	<primitive: 61>
	index isInteger
		ifTrue: [(index >= 1 and: [index <= (self objectSize: anObject)])
					ifFalse: [self errorSubscriptBounds: index]].
	index isNumber
		ifTrue: [^self object: anObject basicAt: index asInteger put: value]
		ifFalse: [self errorNonIntegerIndex].
	anObject isReadOnlyObject 
		ifTrue: [ ^self error: 'ModificationForbidden' ].
	self errorImproperStore
]

Context >> tempAt: index [
	"Answer the value of the temporary variable whose index is the 
	 argument, index.  Primitive. Assumes receiver is indexable. Answer the
	 value of an indexable element in the receiver. Fail if the argument index
	 is not an Integer or is out of bounds. Essential. See Object documentation
	 whatIsAPrimitive.  Override the default at: primitive to give latitude to the
	 VM in context management."

	<primitive: 210>
	^self at: index
]
Context >> tempAt: index put: value [
	"Store the argument, value, as the temporary variable whose index is the 
	 argument, index.  Primitive. Assumes receiver is indexable. Answer the
	 value of an indexable element in the receiver. Fail if the argument index
	 is not an Integer or is out of bounds. Essential. See Object documentation
	 whatIsAPrimitive.  Override the default at:put: primitive to give latitude to
	 the VM in context management."

	<primitive: 211>
]
{ #category : #'as yet unclassified' }
Context >> asContext [
	^ self
]

{ #category : #'as yet unclassified' }
Context >> home [
	"Answer the context in which the receiver was defined."

	closureOrNil == nil
		ifTrue: [ ^ self ].
	^ closureOrNil outerContext home
]


{ #category : #'as yet unclassified' }
Context >> privRefresh [
	"Reinitialize the receiver so that it is in the state it was at its creation."

	closureOrNil
		ifNotNil: [ pc := closureOrNil startpc.
			self stackp: closureOrNil numArgs + closureOrNil numCopiedValues.
			1 to: closureOrNil numCopiedValues do:
				[ :i | self tempAt: closureOrNil numArgs + i put: (closureOrNil at: i) ] ]
		ifNil: [ pc := method initialPC.
			self stackp: method numTemps.
			method numArgs + 1 to: method numTemps do: [ :i | self tempAt: i put: nil ] ]
]

{ #category : #'as yet unclassified' }
Context >> removeSelf [
	"Nil the receiver pointer and answer its former value."

	| result |
	result := receiver.
	receiver := nil.
	^ result
]

{ #category : #'as yet unclassified' }
Context >> setSender: s receiver: r method: m closure: c startpc: startpc [
	"Create the receiver's initial state."

	sender := s.
	receiver := r.
	method := m.
	closureOrNil := c.
	pc := startpc.
	stackp := 0
]

{ #category : #'as yet unclassified' }
Context >> stackp: newStackp [
	"Storing into the stack pointer is a potentially dangerous thing.
	This primitive stores nil into any cells that become accessible as a result,
	and it performs the entire operation atomically."

	"Once this primitive is implemented, failure code should cause an error"

	<primitive: 76>
	self error: 'stackp store failure'
]

Context >> objectClass: aReceiver [
	<primitive: 111>
	self primitiveFailed
]