Class {
	#name : #IntegerMeta,
	#superclass : #NumberMeta,
	#metaclass : #Class,
	#category : #'Kernel-Numeric'
}

{ #category : #'as yet unclassified' }
IntegerMeta >> new: length neg: neg [
	"Answer an instance of a large integer with the given size and sign."

	neg
		ifTrue: [ ^ LargeNegativeInteger new: length ]
		ifFalse: [ ^ LargePositiveInteger new: length ]
]

{ #category : #'as yet unclassified' }
IntegerMeta >> readFrom: aStream [
	"Answer a new Integer as described on the stream, aStream.
	Embedded radix specifiers not allowed - use Number readFrom: for that."

	^ self readFrom: aStream base: 10
]

{ #category : #'as yet unclassified' }
IntegerMeta >> readFrom: aStream base: base [
	"Answer an instance of one of my concrete subclasses. Initial minus sign 
	accepted, and bases > 10 use letters A-Z. Embedded radix specifiers not 
	allowed--use Number readFrom: for that. Answer zero (not an error) if 
	there are no digits."

	| digit value neg |
	neg := aStream peekFor: $-.
	value := 0.
	[ aStream atEnd ]
		whileFalse: [ digit := aStream next digitValue.
			(digit < 0 or: [ digit >= base ])
				ifTrue: [ aStream skip: -1.
					neg
						ifTrue: [ ^ value negated ].
					^ value ]
				ifFalse: [ value := value * base + digit ] ].
	neg
		ifTrue: [ ^ value negated ].
	^ value
]
