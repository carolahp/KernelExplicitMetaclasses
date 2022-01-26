Class {
	#name : #Message,
	#superclass : #Object,
	#role : 'Message',
	#instVars : [
		'selector',
		'arguments',
		'lookupClass'
	],
	#metaclass : #Class,
	#category : #'Kernel-Methods'
}

{ #category : #'as yet unclassified' }
Message >> arguments [
	"Answer the message arguments array."

	^ arguments
]

{ #category : #'as yet unclassified' }
Message >> lookupClass [
	"Answer the message lookupClass."

	^ lookupClass
]

{ #category : #'as yet unclassified' }
Message >> printOn: aStream [
	"Refer to the comment in Object|printOn:."
	super printOn: aStream.
	aStream
		nextPutAll: ' lookupClass: ' , lookupClass printString;
		nextPutAll: ' selector: ' , selector printString;
		nextPutAll: ' args: ' , arguments printString
]

{ #category : #'as yet unclassified' }
Message >> selector [
	"Answer the message selector."

	^ selector
]

{ #category : #'as yet unclassified' }
Message >> sentTo: anObject [
	"Answer the result of sending this message to the given object."

	lookupClass == nil
		ifTrue: [ ^ anObject perform: selector withArguments: arguments ]
		ifFalse: [ ^ anObject
				perform: selector
				withArguments: arguments
				inSuperclass: lookupClass ]
]
