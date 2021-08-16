Class {
	#name : #Point,
	#superclass : #Object,
	#role : 'Point',
	#instVars : [
		'x',
		'y'
	],
	#metaclass : #Class,
	#category : #'Kernel-VM'
}

Point >> x [
	"Answer the x coordinate."
	^ x
]

Point >> y [
	"Answer the x coordinate."
	^ y
]

Point >> x: xValue y: yValue [
	x := xValue.
	y := yValue
]