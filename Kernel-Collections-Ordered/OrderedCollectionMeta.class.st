Class {
	#name : #OrderedCollectionMeta,
	#superclass : #Class,
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