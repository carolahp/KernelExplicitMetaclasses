Class {
	#name : #ValueLink,
	#superclass : #Object,
	#instVars : [
		'nextLink',
		'value'
	],
	#metaclass : #ValueLinkMeta,
	#category : #'Kernel-Collections-Ordered'
}

{ #category : #'as yet unclassified' }
ValueLink >> = anotherObject [
	^ self species == anotherObject species
		and: [ self value = anotherObject value
				and: [ self nextLink == anotherObject nextLink ] ]
]

{ #category : #'as yet unclassified' }
ValueLink >> asLink [
	^ self
]

{ #category : #'as yet unclassified' }
ValueLink >> hash [
	^ self value hash bitXor: nextLink identityHash
]

{ #category : #'as yet unclassified' }
ValueLink >> nextLink [
	^ nextLink
]

{ #category : #'as yet unclassified' }
ValueLink >> nextLink: aLink [
	nextLink := aLink
]

{ #category : #'as yet unclassified' }
ValueLink >> printOn: aStream [
	aStream nextPutAll: 'ValueLink('.
	value printOn: aStream.
	aStream nextPut: $)
]

{ #category : #'as yet unclassified' }
ValueLink >> value [
	^ value
]

{ #category : #'as yet unclassified' }
ValueLink >> value: aValue [
	value := aValue
]
