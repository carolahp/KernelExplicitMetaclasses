Class {
	#name : #FloatMeta,
	#superclass : #NumberMeta,
	#instVars : [
		'E',
		'Epsilon',
		'Halfpi',
		'Infinity',
		'Ln10',
		'Ln2',
		'MaxVal',
		'MaxValLn',
		'MinValLogBase2',
		'NaN',
		'NegativeInfinity',
		'NegativeZero',
		'Pi',
		'RadiansPerDegree',
		'Sqrt2',
		'Twopi'
	],
	#category : #'Kernel-Numeric'
}

{ #category : #'as yet unclassified' }
FloatMeta >> initialize [
	"Float initialize"

	Pi := 3.14159265358979323846264338327950288.
	Halfpi := Pi / 2.0.
	Twopi := Pi * 2.0.
	RadiansPerDegree := Pi / 180.0.
	Ln2 := 0.69314718055994530941723212145817657.
	Ln10 := 10.0 ln.
	Sqrt2 := 1.41421356237309504880168872420969808.
	E := 2.718281828459045235360287471353.
	Epsilon := 0.000000000001.	"Defines precision of mathematical functions"
	MaxVal := 1.7976931348623157e308.
	MaxValLn := 709.782712893384.
	MinValLogBase2 := -1074.
	Infinity := MaxVal * MaxVal.
	NegativeInfinity := 0.0 - Infinity.
	NaN := Infinity - Infinity.
	NegativeZero := 1.0 / Infinity negated
]

{ #category : #'as yet unclassified' }
FloatMeta >> pi [
	"Answer the constant, Pi."

	^ Pi
]

{ #category : #'as yet unclassified' }
FloatMeta >> readFrom: aStream [
	"Answer a new Float as described on the stream, aStream."

	^ (Number readFrom: aStream) asFloat
]