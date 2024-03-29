Class {
	#name : #Collection,
	#superclass : #Object,
	#metaclass : #CollectionMeta,
	#category : #'Kernel-Collections-Abstract'
}

{ #category : #'as yet unclassified' }
Collection >> add: newObject [
	"Include newObject as one of my elements. Answer newObject. ArrayedCollections cannot respond to this message."

	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
Collection >> asArray [
	"Answer an Array whose elements are the elements of this collection. The order in which elements are added depends on the order in which this collection enumerates its elements. In the case of unordered collections, the ordering is not necessarily the same for multiple requests for the conversion."

	| result i |
	result := Array new: self size.
	i := 0.
	self do: [ :each | result at: (i := i + 1) put: each ].
	^ result
]

{ #category : #'as yet unclassified' }
Collection >> asByteArray [
	"Answer a ByteArray containing my elements."

	| result i |
	result := ByteArray new: self size.
	i := 0.
	self do: [ :each | result at: (i := i + 1) put: each ].
	^ result
]

{ #category : #'as yet unclassified' }
Collection >> asSet [
	"Answer a Set whose elements are the unique elements of the receiver."

	| aSet |
	aSet := Set new: self size.
	self do: [ :each | aSet add: each ].
	^ aSet
]

{ #category : #'as yet unclassified' }
Collection >> average [
	"Calculate the average of a collection, return a CollectionIsEmpty exception if the collection is empty. Look averageIfEmpty: aBlock"
	
	^ self sum / self size
]

{ #category : #'as yet unclassified' }
Collection >> collect: aBlock [
	"Evaluate aBlock with each of the receiver's elements as the argument. 
	Collect the resulting values into a collection like the receiver. Answer 
	the new collection."

	| newCollection |
	newCollection := self species new.
	self do: [ :each | newCollection add: (aBlock value: each) ].
	^ newCollection
]

{ #category : #'as yet unclassified' }
Collection >> detect: aBlock ifNone: exceptionBlock [
	"Evaluate aBlock with each of the receiver's elements as the argument. 
	Answer the first element for which aBlock evaluates to true. If none 
	evaluate to true, then evaluate the argument, exceptionBlock."

	self
		do: [ :each | 
			(aBlock value: each)
				ifTrue: [ ^ each ] ].
	^ exceptionBlock value
]

{ #category : #'as yet unclassified' }
Collection >> do: aBlock [
	"Evaluate aBlock with each of the receiver's elements as the argument."

	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
Collection >> emptyCheck [
	self isEmpty
		ifTrue: [ self errorEmptyCollection ]
]

{ #category : #'as yet unclassified' }
Collection >> errorEmptyCollection [
	self error: 'this collection is empty'
]

{ #category : #'as yet unclassified' }
Collection >> errorNotFound [
	self error: 'Object is not in the collection.'
]

{ #category : #'as yet unclassified' }
Collection >> includes: anObject [
	"Answer whether anObject is one of the receiver's elements."

	self
		do: [ :each | 
			anObject = each
				ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #'as yet unclassified' }
Collection >> isEmpty [
	"Answer whether the receiver contains any elements."

	^ self size = 0
]

{ #category : #'as yet unclassified' }
Collection >> printOn: aStream [
	"Refer to the comment in Object|printOn:."

	aStream nextPutAll: self class name , ' ('.
	self
		do: [ :element | 
			element printOn: aStream.
			aStream space ].
	aStream nextPut: $)
]

{ #category : #'as yet unclassified' }
Collection >> remove: oldObject [
	"Remove oldObject as one of the receiver's elements. Answer oldObject 
	unless no element is equal to oldObject, in which case, create an error 
	notification."

	^ self remove: oldObject ifAbsent: [ self errorNotFound ]
]

{ #category : #'as yet unclassified' }
Collection >> remove: oldObject ifAbsent: anExceptionBlock [
	"Remove oldObject as one of the receiver's elements. If several of the 
	elements are equal to oldObject, only one is removed. If no element is 
	equal to oldObject, answer the result of evaluating anExceptionBlock. 
	Otherwise, answer the argument, oldObject. SequenceableCollections 
	cannot respond to this message."

	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
Collection >> select: aBlock [
	"Evaluate aBlock with each of the receiver's elements as the argument. 
	Collect into a new collection like the receiver, only those elements for 
	which aBlock evaluates to true. Answer the new collection."

	| newCollection |
	newCollection := self species new.
	self
		do: [ :each | 
			(aBlock value: each)
				ifTrue: [ newCollection add: each ] ].
	^ newCollection
]

{ #category : #'as yet unclassified' }
Collection >> size [
	"Answer how many elements the receiver contains."

	| count |
	count := 0.
	self do: [ :each | count := count + 1 ].
	^ count
]

{ #category : #'as yet unclassified' }
Collection >> sum [
	"Answer the sum of the elements of this collection. If the collection is empty, answer zero."

	"Details: Use an arbitrary element of the collection as the initial value so this method will work for collections of any kind of object that understands + and -."

	| total seed |
	total := seed := self detect: [ :x | true ] ifNone: [ ^ 0 ].
	self do: [ :el | total := total + el ].
	^ total - seed	"subtract the seed value from the total"
]

Collection >> anySatisfy: aBlock [
	self do: [:each | (aBlock value: each) ifTrue: [^ true]].
	^ false
]

Collection >> noneSatisfy: aBlock [
	self do: [:item | (aBlock value: item) ifTrue: [^ false]].
	^ true
]

Collection >> anyOne [
	self emptyCheck.
	self do: [:each | ^ each]
]