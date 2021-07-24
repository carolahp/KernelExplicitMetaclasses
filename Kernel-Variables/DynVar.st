Class {
	#name : #DynVar,
	#superclass : #Object,
	#metaclass : #Class,
	#instVars : [
		'name',
		'index'
	],
	#category : #'Kernel-Variables'
}
DynVar >> read [
	| context var |
	context := thisContext sender.
	[ context isNil ] whileFalse: [ 
		
		var := context method dynamicVariableNamed: name.
		(var isNil not) ifTrue: [ 
			^ context tempAt: var index ].
		context :=  context sender
	].
	^ nil
]
DynVar >> write: anObject [
	| context var |
	
	context := thisContext sender.
	[ context isNil ] whileFalse: [ 
		var := context method dynamicVariableNamed: name.
		(var isNil not) ifTrue: [ 
			^ context tempAt: var index put: anObject ].
		context :=  context sender
	].
	^ nil
]
DynVar >> index [
	^ index
]
DynVar >> name [
	^ name
]