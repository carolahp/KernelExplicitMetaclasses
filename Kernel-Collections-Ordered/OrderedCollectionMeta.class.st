Class {
	#name : #OrderedCollectionMeta,
	#superclass : #Class,
	#metaclass : #Class,
	#category : #'Kernel-Collections-Ordered'
}

{ #category : #'as yet unclassified' }
OrderedCollectionMeta >> new [
	^ self new: 8
]

{ #category : #'as yet unclassified' }
OrderedCollectionMeta >> new: anInteger [
	"If a subclass adds fields, then that subclass must reimplement new:."

	^ self basicNew setCollection: (Array new: anInteger)
]

{ #category : #'as yet unclassified' }
OrderedCollectionMeta >> newFrom: aCollection [
	"Answer an instance of me containing the same elements as aCollection."

	| newCollection |
	newCollection := self new: aCollection size.
	newCollection addAll: aCollection.
	^newCollection
]
