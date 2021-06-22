Class {
	#name : #SmalltalkImage,
	#superclass : #Object,
	#role : #SmalltalkImage,
	#instVars : [
		'globals',
		'specialObjectsArray'
	],
	#metaclass : #Class,
	#category : #'Kernel-System'
}

{ #category : #'as yet unclassified' }
SmalltalkImage >> at: aKey [
	"Answer the global associated with the key."

	^globals at: aKey
]

{ #category : #'as yet unclassified' }
SmalltalkImage >> globals [
	^ globals
]

{ #category : #'as yet unclassified' }
SmalltalkImage >> globals: aSystemDictionary [
	globals := aSystemDictionary
]

{ #category : #'as yet unclassified' }
SmalltalkImage >> specialObjectsArray [
	^ specialObjectsArray
]

{ #category : #'as yet unclassified' }
SmalltalkImage >> specialObjectsArray: anArray [
	specialObjectsArray := anArray
]
