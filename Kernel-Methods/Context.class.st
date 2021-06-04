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
	#indexInClassTable : 36,
	#category : #'Kernel-Methods'
}

{ #category : #'as yet unclassified' }
Context >> blockCopy: numArgs [
	"Primitive. Distinguish a block of code from its enclosing method by creating a new BlockContext for that block. The compiler inserts into all methods that contain blocks the bytecodes to send the message blockCopy:. Do not use blockCopy: in code that you write! Only the compiler can decide to send the message blockCopy:. Fail if numArgs is not a SmallInteger. Optional. No Lookup. See Object documentation whatIsAPrimitive."

	<primitive: 80>
	^ (Block newForMethod: self home method)
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
		nextPutAll: receiver asString;
		nextPutAll: ' >>> ';
		nextPutAll: self method selector asString
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
