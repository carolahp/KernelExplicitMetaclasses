Class {
	#name : #Association,
	#superclass : #Magnitude,
	#role : 'Association',
	#instVars : [
		'key',
		'value'
	],
	#metaclass : #AssociationMeta,
	#category : #'Kernel-Collections-Unordered'
}

{ #category : #'as yet unclassified' }
Association >> < aLookupKey [
	"Sort by keys."

	^ key < aLookupKey key
]

{ #category : #'as yet unclassified' }
Association >> = anAssociation [
	"True if the receiver and argument have equal keys."

	self species = anAssociation species
		ifTrue: [ ^ key = anAssociation key ]
		ifFalse: [ ^ false ]
]

{ #category : #'as yet unclassified' }
Association >> hash [
	"Hash is reimplemented because = is implemented."

	^ key hash
]

{ #category : #'as yet unclassified' }
Association >> key [
	^ key
]

{ #category : #'as yet unclassified' }
Association >> key: anObject [
	key := anObject
]

{ #category : #'as yet unclassified' }
Association >> key: aKey value: anObject [
	key := aKey.
	value := anObject
]

{ #category : #'as yet unclassified' }
Association >> printOn: aStream [
	"Print in the format (key->value)."

	aStream nextPut: $(.
	key printOn: aStream.
	aStream nextPutAll: '->'.
	value printOn: aStream.
	aStream nextPut: $)
]

{ #category : #'as yet unclassified' }
Association >> value [
	^ value
]

{ #category : #'as yet unclassified' }
Association >> value: anObject [
	value := anObject
]
