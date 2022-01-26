Class {
	#name : #UndefinedObject,
	#superclass : #Object,
	#role : 'UndefinedObject',
	#metaclass : #Class,
	#category : #'Kernel-Objects'
}

{ #category : #'as yet unclassified' }
UndefinedObject >> basicCopy [
	"There is the only one instance of me, so answer myself."

	^ self
]

{ #category : #'as yet unclassified' }
UndefinedObject >> entryPoint [
System log: 'hello world'. 
        System quit.
]

{ #category : #'as yet unclassified' }
UndefinedObject >> ifNil: aBlock [
	"A convenient test, in conjunction with Object ifNil:"

	^ aBlock value
]

{ #category : #'as yet unclassified' }
UndefinedObject >> ifNil: nilBlock ifNotNil: ifNotNilBlock [
	"Evaluate the block for nil because I'm == nil"

	^ nilBlock value
]

{ #category : #'as yet unclassified' }
UndefinedObject >> ifNotNil: aBlock [
	"A convenient test, in conjunction with Object ifNotNil:"

	^ self
]

{ #category : #'as yet unclassified' }
UndefinedObject >> isNil [
	"Answer true if the receiver is nil."

	^ true
]

{ #category : #'as yet unclassified' }
UndefinedObject >> printOn: aStream [
	aStream nextPutAll: 'nil'
]
