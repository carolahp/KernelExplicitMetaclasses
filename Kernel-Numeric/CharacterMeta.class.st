Class {
	#name : #CharacterMeta,
	#superclass : #Class,
	#metaclass : #Class,
	#category : #'Kernel-Numeric'
}

{ #category : #'as yet unclassified' }
CharacterMeta >> cr [
	"Answer the Character representing a carriage return."

	^ 13 asCharacter
]

{ #category : #'as yet unclassified' }
CharacterMeta >> digitValue: x [
	"Answer the Character whose digit value is x. For example,
	 answer $9 for x=9, $0 for x=0, $A for x=10, $Z for x=35."

	| n |
	n := x asInteger.
	^self value: (n < 10 ifTrue: [n + 48] ifFalse: [n + 55])
]

{ #category : #'as yet unclassified' }
CharacterMeta >> lf [
	"Answer the Character representing a linefeed."

	^ 10 asCharacter
]

{ #category : #'as yet unclassified' }
CharacterMeta >> new [
	"There are 256 unique Characters; creating new ones is not allowed."

	self cannotInstantiate
]

{ #category : #'as yet unclassified' }
CharacterMeta >> space [
	"Answer the Character representing a space."

	^ 32 asCharacter
]

{ #category : #'as yet unclassified' }
CharacterMeta >> tab [
	"Answer the Character representing a tab."

	^ 9 asCharacter
]

{ #category : #'as yet unclassified' }
CharacterMeta >> value: anInteger [
	"Answer the Character whose value is anInteger."
	<primitive: 170>
	^self primitiveFailed
]
