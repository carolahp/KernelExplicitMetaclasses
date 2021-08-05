Class {
	#name : #ProcessorScheduler,
	#superclass : #Object,
	#role : 'ProcessorScheduler',
	#instVars : [
		'suspendedProcessLists',
		'activeProcess'
	],
	#metaclass : #Class,
	#category : #'Kernel-Processes'
}

{ #category : #'as yet unclassified' }
ProcessorScheduler >> activeProcess [
	"Answer the currently running Process."

	^ activeProcess
]

{ #category : #'as yet unclassified' }
ProcessorScheduler >> errorHandler [
	System log: 'I am the error handler. I will save and quit'.
	System snapshotAndQuit
]

{ #category : #'as yet unclassified' }
ProcessorScheduler >> highestPriority [
	"Answer the number of priority levels currently available for use."

	^ suspendedProcessLists size
]

{ #category : #'as yet unclassified' }
ProcessorScheduler >> idleProcess [
	"A default background process that simply loops forever. It runs only when no higher priority processes are available, perhaps because they are waiting on a semaphore or timer."

	[ true ] whileTrue: [  ]
	"do nothing"
]

{ #category : #'as yet unclassified' }
ProcessorScheduler >> initProcessLists [
	"Create process lists for prioriy levels 1 through 5."

	suspendedProcessLists := (1 to: 5)
		collect: [ :i | ProcessList new ]
]

{ #category : #'as yet unclassified' }
ProcessorScheduler >> installIdleProcess [
	"Install an idle process of the lowest possible priority that is always runnable."

	"Details: The virtual machine requires that there is always some runnable process that can be scheduled; this background process ensures that this is the case."

	| idleList idleProc |
	"terminate any old idle processes"
	idleList := suspendedProcessLists at: 1.
	[ idleList isEmpty ] whileFalse: [ idleList first terminate ].
	idleProc := Process new for: [ self idleProcess ] priority: 1.
	(suspendedProcessLists at: idleProc priority) addLast: idleProc
]

{ #category : #'as yet unclassified' }
ProcessorScheduler >> installStartProcess [
	"Install the startup process as the active process. This process will run when Pharo Candle is started."

	activeProcess := Process new
		for: [ System start ] asContext
		priority: 3
]

{ #category : #'as yet unclassified' }
ProcessorScheduler >> printOn: aStream [
	aStream nextPutAll: 'a ProcessorScheduler!'
]

{ #category : #'as yet unclassified' }
ProcessorScheduler >> remove: aProcess ifAbsent: aBlock [
	"Remove the given process from the list on which it is waiting. If the process is not on the queue for it's priority, evaluate the given block. Always answer the process."

	(suspendedProcessLists at: aProcess priority)
		remove: aProcess
		ifAbsent: aBlock.
	^ aProcess
]
