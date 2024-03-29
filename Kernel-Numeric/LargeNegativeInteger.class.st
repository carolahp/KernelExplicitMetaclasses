Class {
	#name : #LargeNegativeInteger,
	#superclass : #LargePositiveInteger,
	#role : 'LargeNegativeInteger',
	#type : #bytes,
	#metaclass : #Class,
	#category : #'Kernel-Numeric'
}

{ #category : #'as yet unclassified' }
LargeNegativeInteger >> abs [
	self asd.
	^ self negated
]

{ #category : #'as yet unclassified' }
LargeNegativeInteger >> negated [
	^ self copyto: (LargePositiveInteger new: self digitLength)
]

{ #category : #'as yet unclassified' }
LargeNegativeInteger >> negative [
	"Answer whether the receiver is mathematically negative."

	^ true
]

{ #category : #'as yet unclassified' }
LargeNegativeInteger >> normalize [
	"Check for leading zeroes and return shortened copy if so"

	| sLen val len oldLen minVal |
	"First establish len = significant length"
	len := oldLen := self digitLength.
	[ len = 0
		ifTrue: [ ^ 0 ].
	(self digitAt: len) = 0 ] whileTrue: [ len := len - 1 ].	"Now check if in SmallInteger range"
	sLen := 4.	"SmallInteger minVal digitLength"
	len <= sLen
		ifTrue: [ minVal := SmallInteger minVal.
			(len < sLen or: [ (self digitAt: sLen) < minVal lastDigit ])
				ifTrue: [ val := 0.
					len to: 1 by: -1 do: [ :i | val := val * 256 - (self digitAt: i) ].
					^ val ].
			"If high digit less, then can be small"
			1 to: sLen do: [ :i"If all digits same, then = minVal"
				 | 
				(self digitAt: i) = (minVal digitAt: i)
					ifFalse: [ len < oldLen
							ifTrue: [ ^ self growto: len ]
							ifFalse: [ ^ self ] ]
				"Not so; return self shortened" ].
			^ minVal ].	"Return self, or a shortened copy"
	len < oldLen
		ifTrue: [ ^ self growto: len ]
		ifFalse: [ ^ self ]
]

{ #category : #'as yet unclassified' }
LargeNegativeInteger >> printOn: aStream base: b [
	"Refer to the comment in Integer|printOn:base:."

	aStream nextPut: $-.
	super printOn: aStream base: b
]

{ #category : #'as yet unclassified' }
LargeNegativeInteger >> sign [
	"Optimization. Answer -1 since receiver is less than 0."

	^ -1
]
