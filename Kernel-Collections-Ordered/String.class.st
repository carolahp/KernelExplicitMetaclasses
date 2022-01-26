Class {
	#name : #String,
	#superclass : #ArrayedCollection,
	#metaclass : #StringMeta,
	#category : #'Kernel-Collections-Ordered'
}

{ #category : #'as yet unclassified' }
String >> < aString [
	"Answer whether the receiver sorts before aString.
	The collation order is simple ascii (with case differences)."

	^ (self compare: self with: aString collated: self class asciiOrder) = 1
]

{ #category : #'as yet unclassified' }
String >> <= aString [
	"Answer whether the receiver sorts before or equal to aString.
	The collation order is simple ascii (with case differences)."

	^ (self compare: self with: aString collated: self class asciiOrder) <= 2
]

{ #category : #'as yet unclassified' }
String >> = aString [
	"Answer whether the receiver sorts equally as aString.
	The collation order is simple ascii (with case differences)."

	aString species == String
		ifFalse: [ ^ false ].
	^ (self compare: self with: aString collated: self class asciiOrder) = 2
]

{ #category : #'as yet unclassified' }
String >> > aString [
	"Answer whether the receiver sorts after aString.
	The collation order is simple ascii (with case differences)."

	^ (self compare: self with: aString collated: self class asciiOrder) = 3
]

{ #category : #'as yet unclassified' }
String >> >= aString [
	"Answer whether the receiver sorts after or equal to aString.
	The collation order is simple ascii (with case differences)."

	^ (self compare: self with: aString collated: self class asciiOrder) >= 2
]

{ #category : #'as yet unclassified' }
String >> asByteArray [
	"Answer a ByteArray containing the ASCII values of my characters. Uses a fast primitive that avoids character conversion."

	^ (ByteArray new: self size)
		replaceFrom: 1
		to: self size
		with: self
]

{ #category : #'as yet unclassified' }
String >> asLowercase [
	"Answer a String made up from the receiver whose characters are all lowercase."

	| result |
	result := self copy asString.
	self
		translate: result
		from: 1
		to: result size
		table: self class lowercasingTable.
	^ result
]

{ #category : #'as yet unclassified' }
String >> asString [
	"Answer this string."

	^ self
]

{ #category : #'as yet unclassified' }
String >> asSymbol [
	"This is the only place that new Symbols are created. A Symbol is created if and only if there is not already a Symbol with its contents in existance."

	ByteSymbol
		allInstancesDo: [ :sym | 
			self = sym
				ifTrue: [ ^ sym ] ].
	^ (ByteSymbol basicNew: self size) initFrom: self
]

{ #category : #'as yet unclassified' }
String >> at: index [
	"Primitive. Answer the Character stored in the field of the receiver
	indexed by the argument. Fail if the index argument is not an Integer or
	is out of bounds. Essential. See Object documentation whatIsAPrimitive."

	<primitive: 63>
	^ (super at: index) asCharacter
]

{ #category : #'as yet unclassified' }
String >> at: index put: aCharacter [
	"Primitive. Store the Character in the field of the receiver indicated by
	the index. Fail if the index is not an Integer or is out of bounds, or if
	the argument is not a Character. Essential. See Object documentation
	whatIsAPrimitive."

	<primitive: 64>
	(aCharacter isKindOf: Character)
		ifTrue: [ index isInteger
				ifTrue: [ self errorSubscriptBounds: index ]
				ifFalse: [ self errorNonIntegerIndex ] ]
		ifFalse: [ self error: 'Strings only store Characters' ]
]

{ #category : #'as yet unclassified' }
String >> compare: aString [
	"Answer a comparison code telling how the receiver sorts relative to aString:
		1 - before
		2 - equal
		3 - after.
	The collation sequence is ascii with case differences ignored.
	To get the effect of a <= b, but ignoring case, use (a compare: b) <= 2."

	^ self compare: self with: aString collated: self class caseInsensitiveOrder
]

{ #category : #'as yet unclassified' }
String >> compare: string1 with: string2 collated: order [
	"Return 1, 2 or 3, if string1 is <, =, or > string2, with the collating order of characters given by the order array."

	<primitive: 235>
	| len1 len2 c1 c2 |
	len1 := string1 size.
	len2 := string2 size.
	1 to: (len1 min: len2) do: [ :i | 
		c1 := order at: (string1 basicAt: i) + 1.
		c2 := order at: (string2 basicAt: i) + 1.
		c1 = c2
			ifFalse: [ c1 < c2
					ifTrue: [ ^ 1 ]
					ifFalse: [ ^ 3 ] ] ].
	len1 = len2
		ifTrue: [ ^ 2 ].
	len1 < len2
		ifTrue: [ ^ 1 ]
		ifFalse: [ ^ 3 ]
]

{ #category : #'as yet unclassified' }
String >> findDelimiters: delimiters startingAt: start [
	"Answer the index of the character within the receiver, starting at start, that matches one of the delimiters. If the receiver does not contain any of the delimiters, answer size + 1."

	start to: self size do: [ :i | 
		delimiters
			do: [ :delim | 
				delim = (self at: i)
					ifTrue: [ ^ i ] ] ].
	^ self size + 1
]

{ #category : #'as yet unclassified' }
String >> findString: key startingAt: start caseSensitive: caseSensitive [
	"Answer the index in this String at which the substring key first occurs at or after the given starting index. The match can be case-sensitive or not. Answer zero if no match is found."

	^ self
		findSubstring: key
		in: self
		startingAt: start
		matchTable:
			(caseSensitive
				ifTrue: [ self class caseSensitiveOrder ]
				ifFalse: [ self class caseInsensitiveOrder ])
]

{ #category : #'as yet unclassified' }
String >> findSubstring: key in: body startingAt: start matchTable: matchTable [
	"Answer the index in the string body at which the substring key first occurs, at or beyond start. The match is determined using matchTable, which can be used to effect, eg, case-insensitive matches. If no match is found, zero will be returned."

	"Note: The algorithm below is not optimum because it is intended to be translated to C."

	<primitive: 246>
	| index |
	key size = 0
		ifTrue: [ ^ 0 ].
	start to: body size - key size + 1 do: [ :startIndex | 
		index := 1.
		[ (matchTable at: (body at: startIndex + index - 1) asciiValue + 1)
			= (matchTable at: (key at: index) asciiValue + 1) ]
			whileTrue: [ index = key size
					ifTrue: [ ^ startIndex ].
				index := index + 1 ] ].
	^ 0	"
' ' findSubstring: 'abc' in: 'abcdefabcd' startingAt: 1 matchTable: self class caseSensitiveOrder 1
' ' findSubstring: 'abc' in: 'abcdefabcd' startingAt: 2 matchTable: self class caseSensitiveOrder 7
' ' findSubstring: 'abc' in: 'abcdefabcd' startingAt: 8 matchTable: self class caseSensitiveOrder 0
' ' findSubstring: 'abc' in: 'abcdefABcd' startingAt: 2 matchTable: self class caseSensitiveOrder 0
' ' findSubstring: 'abc' in: 'abcdefABcd' startingAt: 2 matchTable: self class caseInsensitiveOrder 7
"
]

{ #category : #'as yet unclassified' }
String >> findTokens: delimiters [
	"Answer the collection of tokens that result from parsing self. Any character in the String delimiters marks a border. Several delimiters in a row are considered as just one separation."

	| tokens keyStart keyStop |
	tokens := OrderedCollection new.
	keyStop := 1.
	[ keyStop <= self size ]
		whileTrue: [ keyStart := self skipDelimiters: delimiters startingAt: keyStop.
			keyStop := self findDelimiters: delimiters startingAt: keyStart.
			keyStart < keyStop
				ifTrue: [ tokens add: (self copyFrom: keyStart to: keyStop - 1) ] ].
	^ tokens
]

{ #category : #'as yet unclassified' }
String >> hash [
	| l m |
	(l := m := self size) <= 2
		ifTrue: [ l = 2
				ifTrue: [ m := 3 ]
				ifFalse: [ l = 1
						ifTrue: [ ^ ((self at: 1) asciiValue bitAnd: 127) * 106 ].
					^ 21845 ] ].
	^ (self at: 1) asciiValue * 48 + ((self at: m - 1) asciiValue + l)
]

{ #category : #'as yet unclassified' }
String >> indexOf: aCharacter startingAt: start [
	^ self
		indexOfAscii: aCharacter asciiValue
		inString: self
		startingAt: start
]

{ #category : #'as yet unclassified' }
String >> indexOf: aCharacter startingAt: startIndex ifAbsent: absentBlock [
	"Answer the index of the given Character within me starting the search at the given index. If I do not contain the Character, answer the result of evaluating the given block."

	| ans |
	ans := self
		indexOfAscii: aCharacter asciiValue
		inString: self
		startingAt: startIndex.
	ans = 0
		ifTrue: [ ^ absentBlock value ]
		ifFalse: [ ^ ans ]
]

{ #category : #'as yet unclassified' }
String >> indexOfAscii: anInteger inString: aString startingAt: start [
	"	<primitive: 245>"

	| stringSize |
	stringSize := aString size.
	start to: stringSize do: [ :pos | 
		(aString basicAt: pos) = anInteger
			ifTrue: [ ^ pos ] ].
	^ 0
]

{ #category : #'as yet unclassified' }
String >> numArgs [
	"Answer the number of arguments that the receiver would take considered as a selector or -1 if it couldn't be a selector."

	| firstChar numColons |
	firstChar := self at: 1.
	firstChar isLetter
		ifTrue: [ numColons := 0.
			self
				do: [ :ch | 
					ch tokenish
						ifFalse: [ ^ -1 ].
					ch = $:
						ifTrue: [ numColons := numColons + 1 ] ].
			numColons > 0 & (self last ~= $:)
				ifTrue: [ ^ -1 ].
			^ numColons ].
	firstChar isSpecial
		ifTrue: [ self size = 1
				ifTrue: [ ^ 1 ].
			(self size = 2 and: [ (self at: 2) isSpecial ])
				ifTrue: [ ^ 1 ].
			^ -1 ].
	^ -1
]

{ #category : #'as yet unclassified' }
String >> printOn: aStream [
	"Print inside string quotes, doubling inbedded quotes."

	| x |
	aStream nextPut: $'.
	1 to: self size do: [ :i | 
		aStream nextPut: (x := self at: i).
		x == $'
			ifTrue: [ aStream nextPut: x ] ].
	aStream nextPut: $'
]

{ #category : #'as yet unclassified' }
String >> replaceFrom: start to: stop with: replacement startingAt: repStart [
	"Primitive. This destructively replaces elements from start to stop in the receiver starting at index, repStart, in the collection, replacement. Answer the receiver. Range checks are performed in the primitive only. Optional. See Object documentation whatIsAPrimitive."

	<primitive: 105>
	super
		replaceFrom: start
		to: stop
		with: replacement
		startingAt: repStart
]

{ #category : #'as yet unclassified' }
String >> size [
	"Primitive. Answer the number of indexable fields in the receiver. This
	value is the same as the largest legal subscript. Essential. See Object
	documentation whatIsAPrimitive."

	<primitive: 62>
	^ self basicSize
]

{ #category : #'as yet unclassified' }
String >> skipDelimiters: delimiters startingAt: start [
	"Answer the index of the first character in this string starting at the given index that does NOT match one of the delimiters. If the receiver does not contain any of the delimiters, answer size + 1. Assumes the delimiters to be a non-empty string."

	start to: self size do: [ :i | 
		(delimiters indexOf: (self at: i) startingAt: 1) = 0
			ifTrue: [ ^ i ] ].
	^ self size + 1
]

{ #category : #'as yet unclassified' }
String >> substrings [
	^ self findTokens: ' '
]

{ #category : #'as yet unclassified' }
String >> translate: aString from: start to: stop table: table [
	"Translate the characters in the given string in place using the given mapping table."

	<primitive: 243>
	start to: stop do: [ :i | aString at: i put: (table at: (aString at: i) asciiValue + 1) ]
]