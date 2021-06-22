Class {
	#name : #Uninstantiable,
	#superclass : #Class,
	#metaclass : #Class,
	#category : #'Kernel-Abstract'
}

{ #category : #'as yet unclassified' }
Uninstantiable >> new [
	"There is a single unique instance of each boolean."
	self cannotInstantiate
]

{ #category : #'as yet unclassified' }
Uninstantiable >> new: size [
	"There is a single unique instance of each boolean."
	self cannotInstantiate
]
