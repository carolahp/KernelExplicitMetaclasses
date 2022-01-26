Class {
	#name : #StringMeta,
	#superclass : #ArrayedCollectionMeta,
	#metaclass : #Class,
	#category : #'Kernel-Collections-Ordered'
}

{ #category : #'as yet unclassified' }
StringMeta >> cr [
	"Answer a string containing a carriage return character."

	^ self with: Character cr
]

{ #category : #'as yet unclassified' }
StringMeta >> asciiOrder [
	^ (0 to: 255) asByteArray
]

{ #category : #'as yet unclassified' }
StringMeta >> caseInsensitiveOrder [
	| caseInsensitiveOrder |
	caseInsensitiveOrder := (0 to: 255) asByteArray.
	($a to: $z)
		do: [ :c | 
			caseInsensitiveOrder
				at: c asciiValue + 1
				put: (caseInsensitiveOrder at: c asUppercase asciiValue + 1) ].	
]

{ #category : #'as yet unclassified' }
StringMeta >> caseSensitiveOrder [
	| caseSensitiveOrder order |
	caseSensitiveOrder := (self asciiOrder collect: [ :x | 255 ]) asByteArray.
	order := -1.
	' 0123456789'
		do:
			[ :c | caseSensitiveOrder at: c asciiValue + 1 put: (order := order + 1) ].

	($a to: $z)
		do: [ :c | 
			caseSensitiveOrder
				at: c asUppercase asciiValue + 1
				put: (order := order + 1).
			caseSensitiveOrder at: c asciiValue + 1 put: (order := order + 1) ].

	1 to: caseSensitiveOrder size do: [ :i | 
		(caseSensitiveOrder at: i) = 255
			ifTrue: [ caseSensitiveOrder at: i put: (order := order + 1) ] ].

	order = 255
		ifFalse: [ self error: 'order problem' ].
]

StringMeta >> lowercasingTable [
	^ ((0 to: 255) collect: [ :i | i asCharacter asLowercase ]) asString
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

{ #category : #'as yet unclassified' }
StringMeta >> new: size [
	"Answer a string containing a carriage return character."

	^ ByteString basicNew: size
]
