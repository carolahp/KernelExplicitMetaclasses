Class {
	#name : #ArrayedCollectionMeta,
	#superclass : #Class,
	#metaclass : #Class,
	#category : #'Kernel-Collections-Abstract'
}

{ #category : #'as yet unclassified' }
ArrayedCollectionMeta >> new [
	"Answer a new instance of me, with size = 0."

	^ self new: 0
]

{ #category : #'as yet unclassified' }
ArrayedCollectionMeta >> with: anObject [
	"Answer a new instance of me, containing only anObject."

	| newCollection |
	newCollection := self new: 1.
	newCollection at: 1 put: anObject.
	^ newCollection
]

{ #category : #'as yet unclassified' }
ArrayedCollectionMeta >> with: firstObject with: secondObject [
	"Answer a new instance of me containing the two arguments as elements."

	| newCollection |
	newCollection := self new: 2.
	newCollection at: 1 put: firstObject.
	newCollection at: 2 put: secondObject.
	^ newCollection
]

{ #category : #'as yet unclassified' }
ArrayedCollectionMeta >> with: firstObject with: secondObject with: thirdObject [
	"Answer a new instance of me, containing the three arguments as elements."

	| newCollection |
	newCollection := self new: 3.
	newCollection at: 1 put: firstObject.
	newCollection at: 2 put: secondObject.
	newCollection at: 3 put: thirdObject.
	^ newCollection
]
