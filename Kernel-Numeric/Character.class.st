Class {
	#name : #Character,
	#superclass : #Magnitude,
	#role : 'Character',
	#type : #immediate,
	#metaclass : #CharacterMeta,
	#category : #'Kernel-Numeric'
}

{ #category : #'as yet unclassified' }
Character >> < aCharacter [
	"Answer true if my value is less than the given character's value."

	^ self asciiValue < aCharacter asciiValue
]

{ #category : #'as yet unclassified' }
Character >> = aCharacter [
	"Primitive. Answer true if the receiver and the argument are the same object (have the same object pointer) and false otherwise. Optional. See Object documentation whatIsAPrimitive."

	<primitive: 110>
	^ self == aCharacter
]

{ #category : #'as yet unclassified' }
Character >> > aCharacter [
	"Answer true if my value is greater than the given character's value."

	^ self asciiValue > aCharacter asciiValue
]

{ #category : #'as yet unclassified' }
Character >> asCharacter [
	"Answer the receiver itself."

	^ self
]

{ #category : #'as yet unclassified' }
Character >> asInteger [
	"Answer the receiver's character code."
	<primitive: 171>
	^self primitiveFailed
]

{ #category : #'as yet unclassified' }
Character >> asLowercase [
	"If I am uppercase, answer the matching lowercase Character. Otherwise, answer myself."

	(65 <= self asciiValue and: [ self asciiValue <= 90 ])
		ifTrue: [ ^ (self asciiValue + 32) asCharacter ]
		ifFalse: [ ^ self ]	"self isUppercase"
]

{ #category : #'as yet unclassified' }
Character >> asString [
	^ String with: self
]

{ #category : #'as yet unclassified' }
Character >> asUppercase [
	"If the receiver is lowercase, answer its matching uppercase Character."

	(97 <= self asciiValue and: [ self asciiValue <= 122 ])
		ifTrue: [ ^ (self asciiValue - 32) asCharacter ]
		ifFalse: [ ^ self ]	"self isLowercase"
]

{ #category : #'as yet unclassified' }
Character >> asciiValue [
	"Answer the receiver's character code.
	 This will be ascii for characters with value <= 127,
	 and Unicode for those with higher values."
	<primitive: 171>
	^self primitiveFailed
]

{ #category : #'as yet unclassified' }
Character >> basicCopy [
	"Answer myself because Characters are unique."

	^ self
]

{ #category : #'as yet unclassified' }
Character >> digitValue [
	"Answer 0-9 if the receiver is $0-$9, 10-35 if it is $A-$Z, and -1 otherwise. This is used to parse literal numbers of radix 2-36."

	self asciiValue <= $9 asciiValue
		ifTrue: [ ^ self asciiValue - $0 asciiValue ].
	self asciiValue >= $A asciiValue
		ifTrue: [ self asciiValue <= $Z asciiValue
				ifTrue: [ ^ self asciiValue - $A asciiValue + 10 ] ].
	^ -1
]

{ #category : #'as yet unclassified' }
Character >> hash [
	"Hash is reimplemented because = is implemented.
	 Answer the receiver's character code."
	<primitive: 171>
	^self primitiveFailed
]

{ #category : #'as yet unclassified' }
Character >> isDigit [
	"Answer whether the receiver is a digit."

	^ self asciiValue >= 48 and: [ self asciiValue <= 57 ]
]

{ #category : #'as yet unclassified' }
Character >> isLetter [
	"Answer whether the receiver is a letter."

	^ (65 <= self asciiValue and: [ self asciiValue <= 90 ])
		or: [ 97 <= self asciiValue and: [ self asciiValue <= 122 ] ]
]

{ #category : #'as yet unclassified' }
Character >> isSpecial [
	"Answer whether the receiver is one of the special characters"

	^ '+/\*~<>=@%|&?!' includes: self
]

{ #category : #'as yet unclassified' }
Character >> isUppercase [
	"Answer whether the receiver is an uppercase letter."

	^ 65 <= self asciiValue and: [ self asciiValue <= 90 ]
]

{ #category : #'as yet unclassified' }
Character >> isVowel [
	"Answer true if the receiver is one of the vowels AEIOU (either upper- or lowercase)."

	^ 'AEIOU' includes: self asUppercase
]

{ #category : #'as yet unclassified' }
Character >> printOn: aStream [
	aStream nextPut: $$.
	aStream nextPut: self
]

{ #category : #'as yet unclassified' }
Character >> to: other [
	"Answer with a collection of all characters in the given ASCII range. For example, $a to: $z"

	^ (self asciiValue to: other asciiValue)
		collect: [ :i | i asCharacter ]
]

{ #category : #'as yet unclassified' }
Character >> tokenish [
	"Answer true if the receiver is a valid token-character--that is, a letter, digit, or colon."

	^ self isLetter or: [ self isDigit or: [ self = $: ] ]
]
