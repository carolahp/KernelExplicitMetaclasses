Class {
	#name : #Metaclass,
	#metaclass : #Metaclass,
	#superclass : #Behavior,
	#instVars : [
		'soleInstance'
	],
	#category : #'Kernel-Classes'
}

{ #category : #'as yet unclassified' }
Metaclass >> initMethodDict: newMethodDict [
	"Initialize myself with the given method dictionary. Create but do not initialize my soleInstance."

	superclass := Class.
	methodDict := newMethodDict.
	format := Class format.	"all metaclasses have the same format as PClass"
	soleInstance := self basicNew
]

{ #category : #'as yet unclassified' }
Metaclass >> isMeta [
	^ true
]

{ #category : #'as yet unclassified' }
Metaclass >> name [
	"Answer my name, either 'Metaclass' or the name of my class followed by ' class'."

	soleInstance
		ifNil: [ ^ 'Metaclass' ]
		ifNotNil: [ ^ soleInstance name , ' class' ]
]

{ #category : #'as yet unclassified' }
Metaclass >> new [
	"Each metaclass should have exactly one instance."

	self cannotInstantiate
]

{ #category : #'as yet unclassified' }
Metaclass >> soleInstance: aClass [
	soleInstance := aClass
]

{ #category : #'as yet unclassified' }
Metaclass >> theNonMetaClass [
	"Answer my only instance."

	^ soleInstance
]
