Class {
	#name : #Class,
	#metaclass : #Metaclass,
	#superclass : #Behavior,
	#instVars : [
		'name',
		'instVarNames',
		'classVariables'
	],
	#category : #'Kernel-Classes'
}


{ #category : #'as yet unclassified' }
Class >> on: aCollection [
	"Answer an instance of me initializing it by sending on:"

	^ self basicNew on: aCollection
]

{ #category : #'as yet unclassified' }
Class >> cannotInstantiate [
	"This message is sent if you try to create new instances of classes with unique instances such as booleans or characters."

	self error: 'You cannot create new instances of ' , self name
]

{ #category : #'as yet unclassified' }
Class >> classSide [
	^ self class
]

{ #category : #'as yet unclassified' }
Class >> classVariables [
	"Answer the dictionary of class variables that I share with my sole instance, or nil if I have none."

	^ classVariables
]

{ #category : #'as yet unclassified' }
Class >> classVariables: aDictionary [
	"Answer the dictionary of class variables that I share with my sole instance, or nil if I have none."

	^ classVariables := aDictionary
]

{ #category : #'as yet unclassified' }
Class >> immediateSubclass: subclassName instanceVariableNames: someInstVarNames classVariableNames: classVarNames [
	^ (self
		newClassBuilderForSubclass: subclassName
		instanceVariableNames: someInstVarNames
		classVariableNames: classVarNames)
		beImmediate;
		build
]

{ #category : #'as yet unclassified' }
Class >> initFrom: aPharoClass methodDict: newMethodDict [
	"Fill in my instance variables from the given Class using the given MethodDictionary."

	superclass := Object.	"corrected later"
	methodDict := newMethodDict.
	format := aPharoClass format.
	name := (aPharoClass name copyFrom: 2 to: aPharoClass name size)
		asSymbol.	"omit leading M"
	instVarNames := aPharoClass instVarNames.
	classVariables := aPharoClass classPool.
	instVarNames size = 0
		ifTrue: [ instVarNames := nil ].
	classVariables size = 0
		ifTrue: [ classVariables := nil ]
]

{ #category : #'as yet unclassified' }
Class >> instVarNames [
	"Answer an Array of the receiver's instance variable names."

	instVarNames ifNil: [ ^ #() ].
	^ instVarNames
]

{ #category : #'as yet unclassified' }
Class >> instVarNames: anArray [
	instVarNames := anArray
]

{ #category : #'as yet unclassified' }
Class >> isMeta [
	^ false
]

{ #category : #'as yet unclassified' }
Class >> name [
	^ name
]

{ #category : #'as yet unclassified' }
Class >> name: aSymbol [
	name := aSymbol
]

{ #category : #'as yet unclassified' }
Class >> newClassBuilderForSubclass: subclassName instanceVariableNames: instVarNames classVariableNames: classVarNames [
	^ ClassBuilder new
		superclass: self;
		name: subclassName;
		instVarNames: instVarNames;
		classVariableNames: classVarNames;
		yourself
]

{ #category : #'as yet unclassified' }
Class >> subclass: subclassName instanceVariableNames: someInstVarNames classVariableNames: classVarNames [
	^ (self
		newClassBuilderForSubclass: subclassName
		instanceVariableNames: someInstVarNames
		classVariableNames: classVarNames)
		yourself;
		build
]

{ #category : #'as yet unclassified' }
Class >> theNonMetaClass [
	^ self
]

{ #category : #'as yet unclassified' }
Class >> variableByteSubclass: subclassName instanceVariableNames: someInstVarNames classVariableNames: classVarNames [
	^ (self
		newClassBuilderForSubclass: subclassName
		instanceVariableNames: someInstVarNames
		classVariableNames: classVarNames)
		beBytes;
		build
]

{ #category : #'as yet unclassified' }
Class >> variableSubclass: subclassName instanceVariableNames: someInstVarNames classVariableNames: classVarNames [
	^ (self
		newClassBuilderForSubclass: subclassName
		instanceVariableNames: someInstVarNames
		classVariableNames: classVarNames)
		beVariable;
		build
]

{ #category : #'as yet unclassified' }
Class >> variableWordSubclass: subclassName instanceVariableNames: someInstVarNames classVariableNames: classVarNames [
	^ (self
		newClassBuilderForSubclass: subclassName
		instanceVariableNames: someInstVarNames
		classVariableNames: classVarNames)
		beWords;
		build
]

{ #category : #'as yet unclassified' }
Class >> weakSubclass: subclassName instanceVariableNames: someInstVarNames classVariableNames: classVarNames [
	^ (self
		newClassBuilderForSubclass: subclassName
		instanceVariableNames: someInstVarNames
		classVariableNames: classVarNames)
		beWeak;
		build
]
