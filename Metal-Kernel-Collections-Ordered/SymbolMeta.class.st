Class {
	#name : #SymbolMeta,
	#superclass : #StringMeta,
	#category : #'Kernel-Collections-Ordered'
}

{ #category : #'as yet unclassified' }
SymbolMeta >> new: size [
	"Symbols are unique. You can create a new Symbol from a String using 'asSymbol'."

	self cannotInstantiate
]
