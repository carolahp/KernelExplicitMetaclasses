Class {
	#name : #AssociationMeta,
	#superclass : #Class,
	#category : #'Kernel-Collections-Unordered'
}

AssociationMeta >> key: newKey value: newValue [
	"Answer a new Association with the given key and value."
	^ self new key: newKey value: newValue
]