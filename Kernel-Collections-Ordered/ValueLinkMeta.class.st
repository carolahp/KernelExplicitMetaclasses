Class {
	#name : #ValueLinkMeta,
	#superclass : #Class,
	#metaclass : #Class,
	#category : #'Kernel-Collections-Ordered'
}

{ #category : #'as yet unclassified' }
ValueLinkMeta >> value: aValue [
	^ self new value: aValue
]
