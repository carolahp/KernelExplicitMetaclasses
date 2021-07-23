Class {
	#name : #DynamicTest2,
	#superclass : #Object,
	#metaclass : #Class,
	#category : #'Kernel-Variables'
}

{ #category : #'as yet unclassified' }
DynamicTest >> test [
	| holahola |
	holahola := 'hola'.
	System log: holahola asString.
	self readHolahola.
	System log: holahola asString.
	self writeHolahola.
	System log: holahola asString.
]

DynamicTest >> readHolahola [
	System log: holahola asString
]

DynamicTest >> writeHolahola [
	holahola := 'chao'.
	
]