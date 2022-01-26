Class {
	#name : #Behavior,
	#superclass : #Object,
	#instVars : [
		'superclass',
		'methodDict',
		'format'
	],
	#metaclass : #Class,
	#category : #'Kernel-Classes'
}

{ #category : #'as yet unclassified' }
Behavior >> >> aSelector [
	"a comment"
	^ self methodDict at: aSelector
]

{ #category : #'as yet unclassified' }
Behavior >> name [
	^ 'a Behavior'
]

{ #category : #'as yet unclassified' }
Behavior >> allInstVarNames [
	"Answer an Array of the names of all my instance variables."
	
	^ (1 to: self instSize) collect: [ :i | 'instVar' , i printString ]
]

{ #category : #'as yet unclassified' }
Behavior >> allInstances [
	"Answer a collection of all current instances of the receiver."

	| all |
	all := OrderedCollection new.
	self
		allInstancesDo: [ :x | 
			x == all
				ifFalse: [ all add: x ] ].
	^ all asArray
]

{ #category : #'as yet unclassified' }
Behavior >> allInstancesDo: aBlock [
	"Evaluate the given block for each instance of the receiver."

	| inst |
	self == UndefinedObject
		ifTrue: [ ^ aBlock value: nil ].
	inst := self someInstance.
	[ inst == nil ]
		whileFalse: [ aBlock value: inst.
			inst := inst nextInstance ]
]

{ #category : #'as yet unclassified' }
Behavior >> basicNew [
	"Primitive. Answer an instance of the receiver (which is a class) with no indexable fields. Fail if the class is variable-sized. Essential. See Object documentation whatIsAPrimitive."

	<primitive: 70>
	self isVariable
		ifTrue: [ ^ self basicNew: 0 ].	"space must be low"
	self error: 'low space'
]

{ #category : #'as yet unclassified' }
Behavior >> basicNew: desiredSize [
	"Primitive. Answer an instance of this class with the given number of indexable variables. Fail if this class is not indexable, if the argument is not a positive Integer, or if there is not enough memory available. Essential. See Object documentation whatIsAPrimitive."

	<primitive: 71>
	self isVariable
		ifFalse: [ self error: self name , ' is not variable-sized' ].
	(desiredSize isInteger not or: [ desiredSize < 0 ])
		ifTrue: [ self error: 'bad size' ].
	self error: 'low space'
]

{ #category : #'as yet unclassified' }
Behavior >> canUnderstand: selector [
	"Answer whether the receiver can respond to the message whose selector is the argument. The selector can be in the method dictionary of the receiver's class or any of its superclasses."

	^ (self lookupSelector: selector) ~~ nil
]

{ #category : #'as yet unclassified' }
Behavior >> classPool [
	^ nil
]

{ #category : #'as yet unclassified' }
Behavior >> format [
	"Answer a integer that encodes the format of instances of this class receiver."

	^ format
]

{ #category : #'as yet unclassified' }
Behavior >> indexIfCompact [
	"If my compact class index is non-zero, then instances of this class will be compact, and their class will have an entry in Smalltalk compactClassesArray."

	^ (format bitShift: -11) bitAnd: 16r1F
]

{ #category : #'as yet unclassified' }
Behavior >> inheritsFrom: aClass [
	"Answer whether the argument is on the receiver's superclass chain."

	| this |
	this := superclass.
	[ this == nil ]
		whileFalse: [ this == aClass
				ifTrue: [ ^ true ].
			this := this superclass ].
	^ false
]

{ #category : #'as yet unclassified' }
Behavior >> initialize [
	"Default initialization."

	superclass := Object.
	format := 2.
	methodDict := MethodDictionary new
]

{ #category : #'as yet unclassified' }
Behavior >> instSize [
	"Answer the number of named instance variables
	(as opposed to indexed variables) of the receiver.
	 Above Cog Spur the class format is
		<5 bits inst spec><16 bits inst size>"
	^format bitAnd: 16rFFFF
]

{ #category : #'as yet unclassified' }
Behavior >> instSpec [
	"Answer the instance specification part of the format that defines what kind of object
	 an instance of the receiver is.  The formats are
			0	= 0 sized objects (UndefinedObject True False et al)
			1	= non-indexable objects with inst vars (Point et al)
			2	= indexable objects with no inst vars (Array et al)
			3	= indexable objects with inst vars (MethodContext AdditionalMethodState et al)
			4	= weak indexable objects with inst vars (WeakArray et al)
			5	= weak non-indexable objects with inst vars (ephemerons) (Ephemeron)
			6	= unused
			7	= immediates (SmallInteger, Character)
			8	= unused
			9	= 64-bit indexable
		10-11	= 32-bit indexable (Bitmap)
		12-15	= 16-bit indexable
		16-23	= 8-bit indexable
		24-31	= compiled methods (CompiledMethod)"
	^(self format bitShift: -16) bitAnd: 16r1F
]

{ #category : #'as yet unclassified' }
Behavior >> isBehavior [
	"Answer true if I am a subclass of Behavior."

	^ true
]

{ #category : #'as yet unclassified' }
Behavior >> isBits [
	"Answer whether the receiver contains just bits (not pointers)."

	^ self instSpec >= 6
]

{ #category : #'as yet unclassified' }
Behavior >> isBytes [
	"Answer true if the receiver is byte-indexable. This is always false for non-indexable and pointer objects."

	^ self instSpec >= 8
]

{ #category : #'as yet unclassified' }
Behavior >> isCompact [
	^ self indexIfCompact ~= 0
]

{ #category : #'as yet unclassified' }
Behavior >> isPointers [
	"Answer true if the receiver contains object pointers (versus bytes or words)."

	^ self isBits not
]

{ #category : #'as yet unclassified' }
Behavior >> isVariable [
	"Answer true if the receiver has indexable fields."

	^ self instSpec >= 2
]

{ #category : #'as yet unclassified' }
Behavior >> lookupSelector: selector [
	"Look up the given selector in the methodDictionaries of every class in my superclass chain and answer the corresponding method if found. Answer nil if no method is found."

	| lookupClass mDict |
	lookupClass := self.
	[ lookupClass == nil ]
		whileFalse: [ mDict := lookupClass methodDict.
			(mDict includesKey: selector)
				ifTrue: [ ^ mDict at: selector ].
			lookupClass := lookupClass superclass ].
	^ nil
]

{ #category : #'as yet unclassified' }
Behavior >> methodDict [
	"Answer my method dictionary."

	^ methodDict
]

{ #category : #'as yet unclassified' }
Behavior >> methodDictionary: aMethodDictionary [
	"Set my method dictionary."

	methodDict := aMethodDictionary
]

{ #category : #'as yet unclassified' }
Behavior >> name [
	"Answer a String that names the receiver as well possible. Overridden by my subclasses."

	superclass
		ifNil: [ ^ 'a subclass of nil' ]
		ifNotNil: [ ^ 'a subclass of ' , superclass name ]
]

{ #category : #'as yet unclassified' }
Behavior >> new [
	^ self basicNew initialize
]

{ #category : #'as yet unclassified' }
Behavior >> new: desiredSize [
	^ (self basicNew: desiredSize) initialize
]

{ #category : #'as yet unclassified' }
Behavior >> printOn: aStream [
	aStream nextPutAll: self name
]

{ #category : #'as yet unclassified' }
Behavior >> selectorAtMethod: method setClass: classResultBlock [
	"Answer the message selector associated with the compiled method and evaluate the classResultBlock on the class in which that selector is defined."

	"Note: This method is here only to support the debugger."

	| sel |
	sel := self methodDict
		keyAtIdentityValue: method
		ifAbsent: [ superclass
				ifNil: [ classResultBlock value: self.
					^ #DoIt ].
			sel := superclass
				selectorAtMethod: method
				setClass: classResultBlock.
			sel == #DoIt
				ifTrue: [ classResultBlock value: self ].	"if selector is DoIt, set class to me"
			^ sel ].
	classResultBlock value: self.
	^ sel
]

{ #category : #'as yet unclassified' }
Behavior >> setCompactClassIndex: ccIndex [
	"If my compact class index is non-zero, then instances of this class will be compact, and their class will have an entry in Smalltalk compactClassesArray."

	(ccIndex > 0 and: [ ccIndex <= 31 ])
		ifFalse: [ ^ self error: 'compact class index must 1-31' ].
	self indexIfCompact = 0
		ifFalse: [ ^ self error: self name , ' is already compact!' ].
	format := format + (ccIndex bitShift: 11)
]

{ #category : #'as yet unclassified' }
Behavior >> setFormat: anInteger [
	"Warning! Risky operation. Should only be done when there are not instances of this class."

	format := anInteger
]

{ #category : #'as yet unclassified' }
Behavior >> sharedPools [
	^ nil
]

{ #category : #'as yet unclassified' }
Behavior >> someInstance [
	"Primitive. Answer the first instance in the enumeration of all instances of the receiver. Answer nil if there are none. Essential. See Object documentation whatIsAPrimitive."

	<primitive: 77>
	^ nil
]

{ #category : #'as yet unclassified' }
Behavior >> superclass [
	"Answer my superclass."

	^ superclass
]

{ #category : #'as yet unclassified' }
Behavior >> superclass: aBehaviorOrNil [
	"Set my superclass."

	superclass := aBehaviorOrNil
]
