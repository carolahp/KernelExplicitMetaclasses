Class {
	#name : #Class,
	#superclass : #Behavior,
	#metaclass : #Class,
	#category : #'Kernel-Classes'
}

{ #category : #'as yet unclassified' }
Class >> cannotInstantiate [
	"This message is sent if you try to create new instances of classes with unique instances such as booleans or characters."

	self error: 'You cannot create new instances of ' , self name
]

{ #category : #'as yet unclassified' }
Class >> entryPoint [ 
	Class start
]

{ #category : #'as yet unclassified' }
Class >> on: aCollection [
	"Answer an instance of me initializing it by sending on:"

	^ self basicNew on: aCollection
]

{ #category : #'as yet unclassified' }
Class >> start [ 
	System log: 'hello world'. 
        System quit.
]
