Class {
	#name : #Array,
	#superclass : #ArrayedCollection,
	#role : 'Array',
	#type : #variable,
	#metaclass : #Class,
	#category : #'Kernel-Collections-Ordered'
}

{ #category : #'as yet unclassified' }
Array >> asArray [
	"Answer with the receiver itself."

	^ self
]

{ #category : #'as yet unclassified' }
Array >> asDictionary [
	| dictionary |

	dictionary := Dictionary new.
	self do: [ :each | dictionary add: each ].
	^ dictionary
]

{ #category : #'as yet unclassified' }
Array >> asOrderedCollection [
	^ OrderedCollection newFrom: self
]

{ #category : #'as yet unclassified' }
Array >> elementsExchangeIdentityWith: otherArray [
	"This primitive performs a bulk mutation, causing all pointers to the elements of this array to be replaced by pointers to the corresponding elements of otherArray.  At the same time, all pointers to the elements of otherArray are replaced by pointers to the corresponding elements of this array."

	<primitive: 128>
	self primitiveFailed
]

{ #category : #'as yet unclassified' }
Array >> hash [
	"Make sure that equal (=) arrays hash equally."

	self size = 0
		ifTrue: [ ^ 17171 ].
	^ (self at: 1) hash + (self at: self size) hash
]

{ #category : #'as yet unclassified' }
Array >> printOn: aStream [
	aStream nextPutAll: '#('.
	self
		do: [ :each | 
			each printOn: aStream.
			aStream space ].
	aStream nextPut: $)
]

{ #category : #'as yet unclassified' }
Array >> replaceFrom: start to: stop with: replacement startingAt: repStart [
	"Primitive. This destructively replaces elements from start to stop in the receiver starting at index, repStart, in the collection, replacement. Answer the receiver. Range checks are performed in the primitive only. Optional. See Object documentation whatIsAPrimitive."

	<primitive: 105>
	super
		replaceFrom: start
		to: stop
		with: replacement
		startingAt: repStart
]
