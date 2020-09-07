Class {
	#name : #Form,
	#superclass : #Object,
	#instVars : [
		'bits',
		'width',
		'height',
		'depth',
		'bitBlt'
	],
	#category : #'Kernel-Optional-Graphics'
}

{ #category : #'as yet unclassified' }
Form class >> over [
	^ 3
]

{ #category : #'as yet unclassified' }
Form class >> paint [
	^ 25
]

{ #category : #'as yet unclassified' }
Form class >> width: w height: h depth: d [
	^ self basicNew setWidth: w height: h depth: d
]

{ #category : #'as yet unclassified' }
Form >> beDisplayDepth: d [
	"Install myself as the Display. Drawing onto me will then cause the screen or window to be updated."

	| screenExtent |
	screenExtent := self primScreenSize.
	self
		setWidth: (screenExtent instVarAt: 1)
		height: (screenExtent instVarAt: 2)
		depth: d.
	System specialObjectsArray at: 15 put: self	"make this Form the Display"
]

{ #category : #'as yet unclassified' }
Form >> bits [
	^ bits
]

{ #category : #'as yet unclassified' }
Form >> copyX: x y: y width: w height: h [
	"Answer a new form containing given rectangular portion of this form."

	| result |
	result := Form basicNew setWidth: w height: h depth: depth.
	BitBlt new
		sourceForm: self;
		destForm: result;
		sourceX: x y: y;
		width: w height: h;
		copyBits.
	^ result
]

{ #category : #'as yet unclassified' }
Form >> depth [
	^ depth
]

{ #category : #'as yet unclassified' }
Form >> drawForm: aForm x: x y: y rule: anInteger [
	"Fill the given rectangle with the current fill color."

	| oldFill |
	oldFill := bitBlt fillWords.
	bitBlt
		sourceForm: aForm;
		destX: x
			y: y
			width: aForm width
			height: aForm height;
		rule: anInteger;
		copyBits.
	bitBlt sourceForm: nil.
	bitBlt fillWords: oldFill
]

{ #category : #'as yet unclassified' }
Form >> fillRectX: x y: y w: w h: h [
	"Fill the given rectangle with the current fill color."

	bitBlt
		destX: x
			y: y
			width: w
			height: h;
		copyBits
]

{ #category : #'as yet unclassified' }
Form >> height [
	^ height
]

{ #category : #'as yet unclassified' }
Form >> primScreenSize [
	"Answer the actual screen size. In Pharo Candle, this will be an Association object since Pharo Candle doesn't have Points."

	<primitive: 106>
	self primitiveFailed
]

{ #category : #'as yet unclassified' }
Form >> setColorR: r g: g b: b [
	"Set the fill color for rectangle drawing operations."

	bitBlt fillR: r g: g b: b
]

{ #category : #'as yet unclassified' }
Form >> setWidth: w height: h depth: d [
	| wordsPerLine |
	wordsPerLine := (w * d + 31) // 32.
	bits := ByteArray new: 4 * wordsPerLine * h.
	width := w.
	height := h.
	depth := d.
	bitBlt := BitBlt new
		destForm: self;
		fillR: 255 g: 0 b: 0	"default color"
]

{ #category : #'as yet unclassified' }
Form >> width [
	^ width
]
