Class {
	#name : #System,
	#role : #SmalltalkImage,
	#metaclass : #SystemMeta,
	#superclass : #Object,
	#instVars : [ 
		'globals',
		'specialObjectsArray' 
	],
	#category : #'Kernel-System'
}

{ #category : #'as yet unclassified' }
System >> globals [
	^ globals
]

{ #category : #'as yet unclassified' }
System >> globals: aSystemDictionary [
	globals := aSystemDictionary
]

{ #category : #'as yet unclassified' }
System >> specialObjectsArray [
	^ specialObjectsArray
]

{ #category : #'as yet unclassified' }
System >> specialObjectsArray: anArray [
	specialObjectsArray := anArray
]