Class {
	#name : #DynamicTest,
	#superclass : #Object,
	#metaclass : #Class,
	#category : #'Kernel-Variables'
}

{ #category : #'as yet unclassified' }
DynamicTest >> test [
	|  out holahola |
	holahola := 'hola'.
	System log: 'TEMP AT 1:', (thisContext tempAt:1) asString.
	System log: 'TEMP AT 2:', (thisContext tempAt:2) asString.
	out := DynamicTest2 new.
	System log: 'TEMP AT 1:', (thisContext tempAt:1) asString.
	System log: 'TEMP AT 2:', (thisContext tempAt:2) asString.
	"out readHolaFromOutside.
		System log: 'TEMP AT 1:', (thisContext tempAt:1) asString.
		System log: 'TEMP AT 2:', (thisContext tempAt:2) asString."
	
	out writeHolaFromOutside.
	System log: 'TEMP AT 1:', (thisContext tempAt:1) asString.
	System log: 'TEMP AT 2:', (thisContext tempAt:2) asString.
	System log: holahola asString.
	System log: 'TEMP AT 1:', (thisContext tempAt:1) asString.
	System log: 'TEMP AT 2:', (thisContext tempAt:2) asString.

	System log: holahola asString.
	System log: 'TEMP AT 1:', (thisContext tempAt:1) asString.
	System log: 'TEMP AT 2:', (thisContext tempAt:2) asString.
	self readHolahola.
	System log: 'TEMP AT 1:', (thisContext tempAt:1) asString.
	System log: 'TEMP AT 2:', (thisContext tempAt:2) asString.
	System log: holahola asString.
	System log: 'TEMP AT 1:', (thisContext tempAt:1) asString.
	System log: 'TEMP AT 2:', (thisContext tempAt:2) asString.
	self writeHolahola.

	System log: 'TEMP AT 2:', (thisContext tempAt:2) asString.
	System log: holahola asString.

]

DynamicTest >> readHolahola [
	System log: 'leyendo desde misma instancia ', holahola asString
]

DynamicTest >> writeHolahola [
	holahola := 'chao'.
	
]