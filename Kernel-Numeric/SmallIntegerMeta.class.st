Class {
	#name : #SmallIntegerMeta,
	#superclass : #IntegerMeta,
	#metaclass : #Class,
	#category : #'Kernel-Numeric'
}

{ #category : #'as yet unclassified' }
SmallIntegerMeta >> maxVal [
	"Answer the maximum value for a SmallInteger."

	^ 16r3FFFFFFF
]

{ #category : #'as yet unclassified' }
SmallIntegerMeta >> minVal [
	"Answer the minimum value for a SmallInteger."

	^ -16r40000000
]

{ #category : #'as yet unclassified' }
SmallIntegerMeta >> new [
	"SmallIntegers are created as constants or by performing arithmetic."

	self cannotInstantiate
]
