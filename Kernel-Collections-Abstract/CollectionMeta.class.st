Class {
	#name : #CollectionMeta,
	#superclass : #Class,
	#metaclass : #Class,
	#category : #'Kernel-Collections-Abstract'
}

{ #category : #'as yet unclassified' }
CollectionMeta >> with: anObject [
	"Answer an instance of me containing anObject."

	| newCollection |
	newCollection := self new.
	newCollection add: anObject.
	^ newCollection
]

{ #category : #'as yet unclassified' }
CollectionMeta >> with: firstObject with: secondObject [
	"Answer an instance of me containing the two arguments as elements."

	| newCollection |
	newCollection := self new.
	newCollection add: firstObject.
	newCollection add: secondObject.
	^ newCollection
]

{ #category : #'as yet unclassified' }
CollectionMeta >> with: firstObject with: secondObject with: thirdObject [
	"Answer an instance of me containing the three arguments as elements."

	| newCollection |
	newCollection := self new.
	newCollection add: firstObject.
	newCollection add: secondObject.
	newCollection add: thirdObject.
	^ newCollection
]
