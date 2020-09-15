Class {
	#name : #SmalltalkImage,
	#role : #SmalltalkImage,
	#superclass : #Object,
	#instVars : [ 
		'globals',
		'specialObjectsArray' 
	],
	#category : #'Kernel-System'
}

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

SmalltalkImage >> at: aKey [
	"Answer the global associated with the key."

	^globals at: aKey
]