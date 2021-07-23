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
	| context indx |
	
	"System log: 'leyendo DynVar'."
	context := thisContext.
	[ context isNil ] whileFalse: [ 
		indx := context method indexOfLiteralBinding: #dynvar .
		indx ifNotNil: [ 
			"System log: 'DynVar found in ', context asString, ' at index ', indx asString."
			^ context tempAt: indx ].
		context :=  context sender
	].
	^ nil
]
DynVar >> write: anObject [
	| context indx |
	
	"System log: 'escribiendo DynVar'."
	context := thisContext.
	[ context isNil ] whileFalse: [ 
		indx := context method indexOfLiteralBinding: #dynvar .
		indx ifNotNil: [ 
			"System log: 'DynVar found in ', context asString, ' at index ', indx asString."
			^ context tempAt: indx put: anObject ].
		context :=  context sender
	].
	^ nil
]
DynVar >> index [
	^ index
]