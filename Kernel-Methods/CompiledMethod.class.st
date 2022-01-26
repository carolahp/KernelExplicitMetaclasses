Class {
	#name : #CompiledMethod,
	#superclass : #ByteArray,
	#role : 'CompiledMethod',
	#type : #compiledMethod,
	#metaclass : #Class,
	#category : #'Kernel-Methods'
}

{ #category : #'as yet unclassified' }
CompiledMethod >> asString [
	^ self printString
]

{ #category : #'as yet unclassified' }
CompiledMethod >> classBinding [

	^self literalAt: self numLiterals
]

{ #category : #'as yet unclassified' }
CompiledMethod >> frameSize [
	"Answer the size of temporary frame needed to run the receiver."

	"NOTE:  Versions 2.7 and later use two sizes of contexts."

	(self header bitAnd: 16r20000) = 0
		ifTrue: [ ^ 16 ]
		ifFalse: [ ^ 56 ]
]

{ #category : #'as yet unclassified' }
CompiledMethod >> header [
	"Answer the method header word containing information about the form of this method (e.g., number of literals) and the context needed to run it."

	^ self objectAt: 1
]

{ #category : #'as yet unclassified' }
CompiledMethod >> initialPC [
	"Answer the program counter for my first bytecode."

	^ 4 * (self numLiterals + 1) + 1
]

{ #category : #'as yet unclassified' }
CompiledMethod >> isCompiledMethod [
	^ true
]

{ #category : #'as yet unclassified' }
CompiledMethod >> literalAt: index [
	"Answer the literal indexed by the argument."

	^self objectAt: index + 1
]

{ #category : #'as yet unclassified' }
CompiledMethod >> methodClass [

	^self classBinding value
]

{ #category : #'as yet unclassified' }
CompiledMethod >> numLiterals [
	"Answer the number of literals used by the receiver."

	"^ (self header bitShift: -9) bitAnd: 16rFF"
	^ self header bitAnd: 16r7FFF
]

{ #category : #'as yet unclassified' }
CompiledMethod >> numTemps [
	"Answer the number of temporary variables used by this method."

	^ (self header bitShift: -18) bitAnd: 16r3F
]

{ #category : #'as yet unclassified' }
CompiledMethod >> objectAt: index [
	"Primitive. Answer the method header (if index = 1) or a literal (if index > 1) from the receiver. Essential. See Object documentation whatIsAPrimitive."

	<primitive: 68>
	self primitiveFailed
]

{ #category : #'as yet unclassified' }
CompiledMethod >> objectAt: index put: value [
	"Primitive. Store the value argument into a literal in the receiver. An index of 2 corresponds to the first literal. Fails if the index is less than 2 or greater than the number of literals. Answer the value as the result. Normally only the compiler sends this message because only the compiler stores values in CompiledMethods. Essential. See Object documentation whatIsAPrimitive."

	<primitive: 69>
	self primitiveFailed
]

{ #category : #'as yet unclassified' }
CompiledMethod >> penultimateLiteral [
	"Answer the penultimate literal of the receiver, which holds either
	 the receiver's selector or its properties (which will hold the selector)."
	| pIndex |
	^(pIndex := self numLiterals - 1) > 0 
		ifTrue: [self literalAt: pIndex]
		ifFalse: [nil]
]

{ #category : #'as yet unclassified' }
CompiledMethod >> printOn: aStream [
	"Overrides method inherited from the byte arrayed collection."

	aStream 
		nextPutAll: self methodClass asString; 
		nextPutAll: '>>'; 
		nextPutAll: self selector asString.
]

{ #category : #'as yet unclassified' }
CompiledMethod >> selector [
	"Answer a method's selector.  This is either the penultimate literal,
	 or, if the method has any properties or pragmas, the selector of
	 the MethodProperties stored in the penultimate literal."
	| penultimateLiteral | 
	penultimateLiteral := self penultimateLiteral.
	penultimateLiteral isNil ifTrue: [^nil].
	^ penultimateLiteral isSymbol
		ifTrue: [penultimateLiteral]
		ifFalse: [penultimateLiteral instVarAt: 2]
]
