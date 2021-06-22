Class {
	#name : #Number,
	#superclass : #Magnitude,
	#metaclass : #NumberMeta,
	#category : #'Kernel-Numeric'
}

{ #category : #'as yet unclassified' }
Number >> * aNumber [
	"Answer the result of multiplying the receiver by aNumber."

	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
Number >> + aNumber [
	"Answer the sum of the receiver and aNumber."

	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
Number >> - aNumber [
	"Answer the difference between the receiver and aNumber."

	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
Number >> / aNumber [
	"Answer the result of dividing the receiver by aNumber."

	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
Number >> // aNumber [
	"Integer quotient defined by division with truncation toward negative 
	infinity. 9//4 = 2, -9//4 = -3. -0.9//0.4 = -3. \\ answers the remainder 
	from this division."

	^ (self / aNumber) floor
]

{ #category : #'as yet unclassified' }
Number >> \\ aNumber [
	"modulo. Remainder defined in terms of //. Answer a Number with the 
	same sign as aNumber. e.g. 9\\4 = 1, -9\\4 = 3, 9\\-4 = -3, 0.9\\0.4 = 0.1."

	^ self - (self // aNumber * aNumber)
]

{ #category : #'as yet unclassified' }
Number >> abs [
	"Answer a Number that is the absolute value (positive magnitude) of the 
	receiver."

	self < 0
		ifTrue: [ ^ self negated ]
		ifFalse: [ ^ self ]
]

{ #category : #'as yet unclassified' }
Number >> adaptToFloat: rcvr andSend: selector [
	"If I am involved in arithmetic with a Float, convert me to a Float."

	^ rcvr perform: selector with: self asFloat
]

{ #category : #'as yet unclassified' }
Number >> adaptToInteger: rcvr andSend: selector [
	"If I am involved in arithmetic with a Integer, convert us and evaluate exprBlock."

	^ self subclassResponsibility
]

{ #category : #'as yet unclassified' }
Number >> arcCos [
	"The receiver is the cosine of an angle. Answer the angle measured in 
	radians."

	^ self asFloat arcCos
]

{ #category : #'as yet unclassified' }
Number >> arcSin [
	"The receiver is the sine of an angle. Answer the angle measured in 
	radians."

	^ self asFloat arcSin
]

{ #category : #'as yet unclassified' }
Number >> arcTan [
	"The receiver is the tangent of an angle. Answer the angle measured in 
	radians."

	^ self asFloat arcTan
]

{ #category : #'as yet unclassified' }
Number >> asInteger [
	"Answer an Integer nearest the receiver toward zero."

	^ self truncated
]

{ #category : #'as yet unclassified' }
Number >> ceiling [
	"Answer the integer nearest the receiver toward positive infinity."

	self <= 0
		ifTrue: [ ^ self truncated ]
		ifFalse: [ ^ self negated floor negated ]
]

{ #category : #'as yet unclassified' }
Number >> cos [
	"The receiver represents an angle measured in radians. Answer its cosine."

	^ self asFloat cos
]

{ #category : #'as yet unclassified' }
Number >> degreesToRadians [
	"The receiver is assumed to represent degrees. Answer the conversion to 
	radians."

	^ self asFloat degreesToRadians
]

{ #category : #'as yet unclassified' }
Number >> exp [
	"Answer the exponential of the receiver as a floating point number."

	^ self asFloat exp
]

{ #category : #'as yet unclassified' }
Number >> floor [
	"Answer the integer nearest the receiver toward negative infinity."

	| truncation |
	truncation := self truncated.
	self >= 0
		ifTrue: [ ^ truncation ].
	self = truncation
		ifTrue: [ ^ truncation ]
		ifFalse: [ ^ truncation - 1 ]
]

{ #category : #'as yet unclassified' }
Number >> floorLog: radix [
	"Answer the floor of the log base radix of the receiver."

	^ self asFloat floorLog: radix
]

{ #category : #'as yet unclassified' }
Number >> isNumber [
	^ true
]

{ #category : #'as yet unclassified' }
Number >> ln [
	"Answer the natural log of the receiver."

	^ self asFloat ln
]

{ #category : #'as yet unclassified' }
Number >> log [
	"Answer the base-10 log of the receiver."

	^ self asFloat log
]

{ #category : #'as yet unclassified' }
Number >> log: aNumber [
	"Answer the log base aNumber of the receiver."

	^ self ln / aNumber ln
]

{ #category : #'as yet unclassified' }
Number >> negated [
	"Answer a Number that is the negation of the receiver."

	^ 0 - self
]

{ #category : #'as yet unclassified' }
Number >> negative [
	"Answer whether the receiver is mathematically negative."

	^ self < 0
]

{ #category : #'as yet unclassified' }
Number >> printOn: aStream [
	"Default print radix is 10"

	self printOn: aStream base: 10
]

{ #category : #'as yet unclassified' }
Number >> printStringBase: base [
	| stream |
	stream := WriteStream on: (String new: 100).
	self printOn: stream base: base.
	^ stream contents
]

{ #category : #'as yet unclassified' }
Number >> quo: aNumber [
	"Integer quotient defined by division with truncation toward zero. -9 quo: 
	4 = -2, -0.9 quo: 0.4 = -2. rem: answers the remainder from this division."

	^ (self / aNumber) truncated
]

{ #category : #'as yet unclassified' }
Number >> radiansToDegrees [
	"The receiver is assumed to represent radians. Answer the conversion to 
	degrees."

	^ self asFloat radiansToDegrees
]

{ #category : #'as yet unclassified' }
Number >> raisedTo: aNumber [
	"Answer the receiver raised to aNumber."

	aNumber isInteger
		ifTrue:
			[ ^ self raisedToInteger: aNumber ].
	"Do the special case of integer power"
	aNumber = 0
		ifTrue: [ ^ 1 ].	"Special case of exponent=0"
	aNumber = 1
		ifTrue: [ ^ self ].	"Special case of exponent=1"
	^ (aNumber * self ln) exp	"Otherwise raise it to the power using logarithms"
]

{ #category : #'as yet unclassified' }
Number >> raisedToInteger: anInteger [
	"Answer the receiver raised to the power anInteger where the argument 
	must be a kind of Integer. This is a special case of raisedTo:."

	anInteger isInteger
		ifFalse: [ ^ self error: 'raisedToInteger: only works for integral arguments' ].
	anInteger = 0
		ifTrue: [ ^ 1 ].
	anInteger = 1
		ifTrue: [ ^ self ].
	anInteger > 1
		ifTrue: [ ^ (self * self raisedToInteger: anInteger // 2)
				* (self raisedToInteger: anInteger \\ 2) ].
	^ (self raisedToInteger: anInteger negated) reciprocal
]

{ #category : #'as yet unclassified' }
Number >> reciprocal [
	"Answer 1 divided by the receiver. Create an error notification if the 
	receiver is 0."

	self = 0
		ifTrue: [ ^ self error: 'zero has no reciprocal' ]
		ifFalse: [ ^ 1 / self ]
]

{ #category : #'as yet unclassified' }
Number >> rem: aNumber [
	"Remainder defined in terms of quo:. Answer a Number with the same 
	sign as self. e.g. 9 rem: 4 = 1, -9 rem: 4 = -1. 0.9 rem: 0.4 = 0.1."

	^ self - ((self quo: aNumber) * aNumber)
]

{ #category : #'as yet unclassified' }
Number >> roundTo: aNumber [
	"Answer the integer that is a multiple of aNumber that is nearest the 
	receiver."

	^ (self / aNumber) rounded * aNumber
]

{ #category : #'as yet unclassified' }
Number >> roundUpTo: aNumber [
	"Answer the next multiple of aNumber toward infinity that is nearest the receiver."

	^ (self / aNumber) ceiling * aNumber
]

{ #category : #'as yet unclassified' }
Number >> rounded [
	"Answer the integer nearest the receiver."

	^ (self + (self sign / 2)) truncated
]

{ #category : #'as yet unclassified' }
Number >> sign [
	"Answer 1 if the receiver is greater than 0, -1 if less than 0, else 0."

	self > 0
		ifTrue: [ ^ 1 ].
	self < 0
		ifTrue: [ ^ -1 ].
	^ 0
]

{ #category : #'as yet unclassified' }
Number >> sin [
	"The receiver represents an angle measured in radians. Answer its sine."

	^ self asFloat sin
]

{ #category : #'as yet unclassified' }
Number >> sqrt [
	"Answer the square root of the receiver."

	^ self asFloat sqrt
]

{ #category : #'as yet unclassified' }
Number >> tan [
	"The receiver represents an angle measured in radians. Answer its 
	tangent."

	^ self asFloat tan
]

{ #category : #'as yet unclassified' }
Number >> to: stop [
	"Answer an Interval from the receiver up to the argument incrementing by 1."

	^ Interval from: self to: stop by: 1
]

{ #category : #'as yet unclassified' }
Number >> to: stop by: step [
	"Answer an Interval from the receiver up to stop incrementing by step."

	^ Interval from: self to: stop by: step
]

{ #category : #'as yet unclassified' }
Number >> to: stop by: step do: aBlock [
	"Normally compiled in-line, and therefore not overridable.
	Evaluate aBlock for each element of the interval (self to: stop by: step)."

	| nextValue |
	nextValue := self.
	step < 0
		ifTrue: [ [ stop <= nextValue ]
				whileTrue: [ aBlock value: nextValue.
					nextValue := nextValue + step ] ]
		ifFalse: [ [ stop >= nextValue ]
				whileTrue: [ aBlock value: nextValue.
					nextValue := nextValue + step ] ]
]

{ #category : #'as yet unclassified' }
Number >> to: stop do: aBlock [
	"Normally compiled in-line, and therefore not overridable.
	Evaluate aBlock for each element of the interval (self to: stop by: 1)."

	| nextValue |
	nextValue := self.
	[ nextValue <= stop ]
		whileTrue: [ aBlock value: nextValue.
			nextValue := nextValue + 1 ]
]

{ #category : #'as yet unclassified' }
Number >> truncateTo: aNumber [
	"Answer the next multiple of aNumber toward zero that is nearest the 
	receiver."

	^ (self quo: aNumber) * aNumber
]

{ #category : #'as yet unclassified' }
Number >> truncated [
	"Answer an integer nearest the receiver toward zero."

	^ self quo: 1
]
