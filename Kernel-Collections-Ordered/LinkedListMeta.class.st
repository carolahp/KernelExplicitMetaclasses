Class {
	#name : #LinkedListMeta,
	#superclass : #Class,
	#metaclass : #Class,
	#category : #'Kernel-Collections-Ordered'
}

{ #category : #'as yet unclassified' }
LinkedListMeta >> new: anInt [
	"LinkedList don't need capacity"

	^ self new
]

{ #category : #'as yet unclassified' }
LinkedListMeta >> newFrom: aCollection [
	"Answer an instance with same elements as aCollection."

	^ self new
		addAll: aCollection;
		yourself
]
