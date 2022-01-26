Class {
	#name : #ByteSymbol,
	#superclass : #String,
	#role : 'ByteSymbol',
	#type : #bytes,
	#metaclass : #ByteSymbolMeta,
	#category : #'Kernel-Collections-Ordered'
}

{ #category : #'as yet unclassified' }
ByteSymbol >> = anObject [
	^ self == anObject
]

{ #category : #'as yet unclassified' }
ByteSymbol >> asString [
	"Answer a string containing my characters."

	| sz result |
	sz := self size.
	result := String new: sz.
	result
		replaceFrom: 1
		to: sz
		with: self
		startingAt: 1.
	^ result
]

{ #category : #'as yet unclassified' }
ByteSymbol >> asSymbol [
	^ self
]

{ #category : #'as yet unclassified' }
ByteSymbol >> at: anInteger put: anObject [
	"You cannot modify the receiver."

	self errorNoModification
]

{ #category : #'as yet unclassified' }
ByteSymbol >> basicCopy [
	"Answer myself because Symbols are unique."

	
]

{ #category : #'as yet unclassified' }
ByteSymbol >> errorNoModification [
	self error: 'Symbols can not be modified.'
]

{ #category : #'as yet unclassified' }
ByteSymbol >> hash [
	^ self identityHash
]

{ #category : #'as yet unclassified' }
ByteSymbol >> initFrom: aString [
	"Warning! Use only to initialize new Symbols. Symbols are assumed to be immutable there after."

	self size = aString size
		ifFalse: [ self error: 'size mismatch' ].
	super
		replaceFrom: 1
		to: self size
		with: aString
		startingAt: 1
]

{ #category : #'as yet unclassified' }
ByteSymbol >> isSymbol [
	^ true
]

{ #category : #'as yet unclassified' }
ByteSymbol >> printOn: aStream [
	aStream nextPutAll: self
]

{ #category : #'as yet unclassified' }
ByteSymbol >> replaceFrom: start to: stop with: replacement startingAt: repStart [
	self errorNoModification
]

{ #category : #'as yet unclassified' }
ByteSymbol >> species [
	^ String
]
