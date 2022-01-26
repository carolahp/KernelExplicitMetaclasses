Class {
	#name : #ByteArray,
	#superclass : #ArrayedCollection,
	#role : 'ByteArray',
	#type : #bytes,
	#metaclass : #Class,
	#category : #'Kernel-Collections-Ordered'
}

{ #category : #'as yet unclassified' }
ByteArray >> asByteArray [
	^ self
]

{ #category : #'as yet unclassified' }
ByteArray >> asString [
	"Answer the receiver converted to a String."

	^ (String new: self size)
		replaceFrom: 1
		to: self size
		with: self
		startingAt: 1
]

{ #category : #'as yet unclassified' }
ByteArray >> replaceFrom: startIndex to: stopIndex with: source startingAt: srcStartIndex [
	"Primitive. Destructively replace the elements from startIndex to stopIndex in the receiver with the elements starting at srcStartIndex in the source collection. Answer the receiver. Range checks are performed in the primitive. Optional. See Object documentation whatIsAPrimitive."

	<primitive: 105>
	super
		replaceFrom: startIndex
		to: stopIndex
		with: source
		startingAt: srcStartIndex
]
