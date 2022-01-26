Class {
	#name : #AssociationMeta,
	#superclass : #Class,
	#metaclass : #Class,
	#category : #'Kernel-Collections-Unordered'
}

{ #category : #'as yet unclassified' }
AssociationMeta >> key: newKey value: newValue [
	"Answer a new Association with the given key and value."
	^ self new key: newKey value: newValue
]
