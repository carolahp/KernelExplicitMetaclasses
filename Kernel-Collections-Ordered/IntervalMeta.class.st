Class {
	#name : #IntervalMeta,
	#superclass : #Class,
	#metaclass : #Class,
	#category : #'Kernel-Collections-Ordered'
}

{ #category : #'as yet unclassified' }
IntervalMeta >> from: startInteger to: stopInteger [
	"Answer an instance of me, starting at startNumber, ending at stopNumber, and with an interval increment of 1."

	^ self basicNew setFrom: startInteger to: stopInteger by: 1
]

{ #category : #'as yet unclassified' }
IntervalMeta >> from: startInteger to: stopInteger by: stepInteger [
	"Answer an instance of me, starting at startNumber, ending at stopNumber, and with an interval increment of stepNumber."

	^ self basicNew setFrom: startInteger to: stopInteger by: stepInteger
]
