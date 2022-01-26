Class {
	#name : #FloatMeta,
	#superclass : #NumberMeta,
	#metaclass : #Class,
	#category : #'Kernel-Numeric'
}

{ #category : #'as yet unclassified' }
FloatMeta >> pi [
	"Answer the constant, Pi."

	^ self Pi
]

{ #category : #'as yet unclassified' }
FloatMeta >> readFrom: aStream [
	"Answer a new Float as described on the stream, aStream."

	^ (Number readFrom: aStream) asFloat
]
