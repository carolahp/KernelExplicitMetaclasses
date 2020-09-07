Class {
	#name : #Uninstantiable,
	#superclass : #Class,
	#category : #'Kernel-Objects'
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