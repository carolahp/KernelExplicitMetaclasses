Class {
	#name : #Slot,
	#superclass : #Object,
	#metaclass : #Class,
	#instVars : [
		'name',
		'owningClass',
		'definingClass'
	],
	#category : #'Application'
}
Slot >> read: anObject [
	"System log: thisContext method asString."
	"^ thisContext sender sender tempAt: 1"
]