Class {
	#name : #DynamicTest2,
	#superclass : #Object,
	#metaclass : #Class,
	#category : #'Kernel-Variables'
}


DynamicTest2 >> readHolaFromOutside [
	^ System log: 'Leyendo desde DynamicTest2: ', holahola asString
]

DynamicTest2 >> writeHolaFromOutside [
	holahola := 12
]