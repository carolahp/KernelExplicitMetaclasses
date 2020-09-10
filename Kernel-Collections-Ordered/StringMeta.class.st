Class {
	#name : #StringMeta,
	#superclass : #ArrayedCollectionMeta,
	#category : #'Kernel-Collections-Ordered'
}

{ #category : #'as yet unclassified' }
StringMeta >> cr [
	"Answer a string containing a carriage return character."

	^ self with: Character cr
]

{ #category : #'as yet unclassified' }
StringMeta >> new: size [
	"Answer a string containing a carriage return character."

	^ ByteString basicNew: size
]

{ #category : #'as yet unclassified' }
StringMeta >> initialize [
	"self initialize"

"	| order |
	AsciiOrder := (0 to: 255) asByteArray.
	CaseInsensitiveOrder := AsciiOrder copy.
	($a to: $z)
		do: [ :c | 
			CaseInsensitiveOrder
				at: c asciiValue + 1
				put: (CaseInsensitiveOrder at: c asUppercase asciiValue + 1) ].	
	CaseSensitiveOrder := (AsciiOrder collect: [ :x | 255 ]) asByteArray.
	order := -1.
	' 0123456789'
		do:
			[ :c | CaseSensitiveOrder at: c asciiValue + 1 put: (order := order + 1) ].

	($a to: $z)
		do: [ :c | 
			CaseSensitiveOrder
				at: c asUppercase asciiValue + 1
				put: (order := order + 1).
			CaseSensitiveOrder at: c asciiValue + 1 put: (order := order + 1) ].

	1 to: CaseSensitiveOrder size do: [ :i | 
		(CaseSensitiveOrder at: i) = 255
			ifTrue: [ CaseSensitiveOrder at: i put: (order := order + 1) ] ].

	order = 255
		ifFalse: [ self error: 'order problem' ].
	LowercasingTable := ((0 to: 255)
		collect: [ :i | i asCharacter asLowercase ]) asString"
]
