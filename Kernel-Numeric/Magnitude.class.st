Class {
	#name : #Magnitude,
	#superclass : #Object,
	#metaclass : #Class,
	#category : #'Kernel-Numeric'
}

{ #category : #'as yet unclassified' }
Magnitude >> < aMagnitude [
	"Answer whether the receiver is less than the argument."

	^ self subclassResponsibility
]

{ #category : #'as yet unclassified' }
Magnitude >> <= aMagnitude [
	"Answer whether the receiver is less than or equal to the argument."

	^ (self > aMagnitude) not
]

{ #category : #'as yet unclassified' }
Magnitude >> = aMagnitude [
	"Compare the receiver with the argument and answer with true if the 
	receiver is equal to the argument. Otherwise answer false."

	^ self subclassResponsibility
]

{ #category : #'as yet unclassified' }
Magnitude >> > aMagnitude [
	"Answer whether the receiver is greater than the argument."

	^ aMagnitude < self
]

{ #category : #'as yet unclassified' }
Magnitude >> >= aMagnitude [
	"Answer whether the receiver is greater than or equal to the argument."

	^ (self < aMagnitude) not
]

{ #category : #'as yet unclassified' }
Magnitude >> between: min and: max [
	"Answer whether the receiver is less than or equal to the argument, max, 
	and greater than or equal to the argument, min."

	^ self >= min and: [ self <= max ]
]

{ #category : #'as yet unclassified' }
Magnitude >> hash [
	"Hash must be redefined whenever = is redefined."

	^ self subclassResponsibility
]

{ #category : #'as yet unclassified' }
Magnitude >> max: aMagnitude [
	"Answer the receiver or the argument, whichever has the greater 
	magnitude."

	self > aMagnitude
		ifTrue: [ ^ self ]
		ifFalse: [ ^ aMagnitude ]
]

{ #category : #'as yet unclassified' }
Magnitude >> min: aMagnitude [
	"Answer the receiver or the argument, whichever has the lesser 
	magnitude."

	self < aMagnitude
		ifTrue: [ ^ self ]
		ifFalse: [ ^ aMagnitude ]
]
