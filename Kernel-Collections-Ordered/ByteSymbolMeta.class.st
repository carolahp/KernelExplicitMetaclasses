Class {
	#name : #ByteSymbolMeta,
	#superclass : #StringMeta,
	#category : #'Kernel-Collections-Ordered'
}

{ #category : #'as yet unclassified' }
ByteSymbolMeta >> new: size [
	"Symbols are unique. You can create a new Symbol from a String using 'asSymbol'."

	self cannotInstantiate
]
