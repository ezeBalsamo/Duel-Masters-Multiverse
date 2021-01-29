Class {
	#name : #SuitableClassFinder,
	#superclass : #Object,
	#instVars : [
		'classes',
		'testingMessage',
		'ifNoneDoBlock',
		'ifMultipleDoBlock'
	],
	#category : #'DM-Tools'
}

{ #category : #'private - accessing' }
SuitableClassFinder class >> createCanHandleMessageFor: anObject [

	^ Message selector: #canHandle: argument: anObject
]

{ #category : #'private - accessing' }
SuitableClassFinder class >> createCanHandleMessageFor: anObject with: anotherObject [

	^ Message selector: #canHandle:with: arguments: ( Array with: anObject with: anotherObject )
]

{ #category : #'private - accessing' }
SuitableClassFinder class >> defaultIfMultipleBlock [

	^ [ :potentialClasses :suitableClassFinder | 
	ProgrammingError
		signal:
			( #'Multiple classes can handle <1s>. They are <2s>.'
				expandMacrosWith: ( self format: suitableClassFinder arguments )
				with: ( self format: potentialClasses ) )
	]
]

{ #category : #'private - accessing' }
SuitableClassFinder class >> defaultIfNoneBlock [

	^ [ :suitableClassFinder | 
	ProgrammingError
		signal:
			( #'No class is suitable for handling <1s>. Classes selected for analysis were <2s>.'
				expandMacrosWith: ( self format: suitableClassFinder arguments )
				with: ( self format: suitableClassFinder classes ) )
	]
]

{ #category : #'direct subclass finding' }
SuitableClassFinder class >> findDirectSubclassOf: anAbstractClass accordingTo: aTestingMessage ifMultiple: anIfMultipleBlock ifNone: anIfNoneDoBlock [

	^ self
		findIn: anAbstractClass subclasses
		accordingTo: aTestingMessage
		ifMultiple: anIfMultipleBlock
		ifNone: anIfNoneDoBlock
]

{ #category : #'direct subclass finding' }
SuitableClassFinder class >> findDirectSubclassOf: anAbstractClass suitableFor: anObject [

	^ self findDirectSubclassOf: anAbstractClass suitableFor: anObject ifNone: self defaultIfNoneBlock
]

{ #category : #'direct subclass finding' }
SuitableClassFinder class >> findDirectSubclassOf: anAbstractClass suitableFor: anObject ifMultiple: anIfMultipleBlock ifNone: anIfNoneDoBlock [

	^ self
		findDirectSubclassOf: anAbstractClass
		accordingTo: ( self createCanHandleMessageFor: anObject )
		ifMultiple: anIfMultipleBlock
		ifNone: anIfNoneDoBlock
]

{ #category : #'direct subclass finding' }
SuitableClassFinder class >> findDirectSubclassOf: anAbstractClass suitableFor: anObject ifNone: anIfNoneDoBlock [

	^ self
		findDirectSubclassOf: anAbstractClass
		suitableFor: anObject
		ifMultiple: self defaultIfMultipleBlock
		ifNone: anIfNoneDoBlock
]

{ #category : #'direct subclass finding' }
SuitableClassFinder class >> findDirectSubclassOf: anAbstractClass suitableFor: anObject with: anotherObject [

	^ self
		findDirectSubclassOf: anAbstractClass
		suitableFor: anObject
		with: anotherObject
		ifNone: self defaultIfNoneBlock
]

{ #category : #'direct subclass finding' }
SuitableClassFinder class >> findDirectSubclassOf: anAbstractClass suitableFor: anObject with: anotherObject ifMultiple: anIfMultipleBlock ifNone: anIfNoneDoBlock [

	^ self
		findDirectSubclassOf: anAbstractClass
		accordingTo: ( self createCanHandleMessageFor: anObject with: anotherObject )
		ifMultiple: anIfMultipleBlock
		ifNone: anIfNoneDoBlock
]

{ #category : #'direct subclass finding' }
SuitableClassFinder class >> findDirectSubclassOf: anAbstractClass suitableFor: anObject with: anotherObject ifNone: anIfNoneDoBlock [

	^ self
		findDirectSubclassOf: anAbstractClass
		suitableFor: anObject
		with: anotherObject
		ifMultiple: self defaultIfMultipleBlock
		ifNone: anIfNoneDoBlock
]

{ #category : #'instance creation' }
SuitableClassFinder class >> findIn: aClassCollection accordingTo: aTestingMessage ifMultiple: anIfMultipleDoBlock ifNone: anIfNoneDoBlock [

	^ self new
		initializeFindIn: aClassCollection
		accordingTo: aTestingMessage
		ifMultiple: anIfMultipleDoBlock
		ifNone: anIfNoneDoBlock
]

{ #category : #'collection finding' }
SuitableClassFinder class >> findIn: aClassCollection suitableFor: anObject [

	^ self findIn: aClassCollection suitableFor: anObject ifNone: self defaultIfNoneBlock
]

{ #category : #'collection finding' }
SuitableClassFinder class >> findIn: aClassCollection suitableFor: anObject ifMultiple: anIfMultipleBlock ifNone: anIfNoneDoBlock [

	^ self
		findIn: aClassCollection
		accordingTo: ( self createCanHandleMessageFor: anObject )
		ifMultiple: anIfMultipleBlock
		ifNone: anIfNoneDoBlock
]

{ #category : #'collection finding' }
SuitableClassFinder class >> findIn: aClassCollection suitableFor: anObject ifNone: anIfNoneDoBlock [

	^ self
		findIn: aClassCollection
		suitableFor: anObject
		ifMultiple: self defaultIfMultipleBlock
		ifNone: anIfNoneDoBlock
]

{ #category : #'collection finding' }
SuitableClassFinder class >> findIn: aClassCollection suitableFor: anObject with: anotherObject [

	^ self
		findIn: aClassCollection
		suitableFor: anObject
		with: anotherObject
		ifNone: self defaultIfNoneBlock
]

{ #category : #'collection finding' }
SuitableClassFinder class >> findIn: aClassCollection suitableFor: anObject with: anotherObject ifMultiple: anIfMultipleBlock ifNone: anIfNoneDoBlock [

	^ self
		findIn: aClassCollection
		accordingTo: ( self createCanHandleMessageFor: anObject with: anotherObject )
		ifMultiple: anIfMultipleBlock
		ifNone: anIfNoneDoBlock
]

{ #category : #'collection finding' }
SuitableClassFinder class >> findIn: aClassCollection suitableFor: anObject with: anotherObject ifNone: anIfNoneDoBlock [

	^ self
		findIn: aClassCollection
		suitableFor: anObject
		with: anotherObject
		ifMultiple: self defaultIfMultipleBlock
		ifNone: anIfNoneDoBlock
]

{ #category : #'subclass finding' }
SuitableClassFinder class >> findSubclassOf: anAbstractClass accordingTo: aTestingMessage ifMultiple: anIfMultipleBlock ifNone: anIfNoneDoBlock [

	^ self
		findIn: anAbstractClass allLeafSubclasses
		accordingTo: aTestingMessage
		ifMultiple: anIfMultipleBlock
		ifNone: anIfNoneDoBlock
]

{ #category : #'subclass finding' }
SuitableClassFinder class >> findSubclassOf: anAbstractClass suitableFor: anObject [

	^ self findSubclassOf: anAbstractClass suitableFor: anObject ifNone: self defaultIfNoneBlock
]

{ #category : #'subclass finding' }
SuitableClassFinder class >> findSubclassOf: anAbstractClass suitableFor: anObject ifMultiple: anIfMultipleBlock ifNone: anIfNoneDoBlock [

	^ self
		findSubclassOf: anAbstractClass
		accordingTo: ( self createCanHandleMessageFor: anObject )
		ifMultiple: anIfMultipleBlock
		ifNone: anIfNoneDoBlock
]

{ #category : #'subclass finding' }
SuitableClassFinder class >> findSubclassOf: anAbstractClass suitableFor: anObject ifNone: anIfNoneDoBlock [

	^ self
		findSubclassOf: anAbstractClass
		suitableFor: anObject
		ifMultiple: self defaultIfMultipleBlock
		ifNone: anIfNoneDoBlock
]

{ #category : #'subclass finding' }
SuitableClassFinder class >> findSubclassOf: anAbstractClass suitableFor: anObject with: anotherObject [

	^ self
		findSubclassOf: anAbstractClass
		suitableFor: anObject
		with: anotherObject
		ifNone: self defaultIfNoneBlock
]

{ #category : #'subclass finding' }
SuitableClassFinder class >> findSubclassOf: anAbstractClass suitableFor: anObject with: anotherObject ifMultiple: anIfMultipleBlock ifNone: anIfNoneDoBlock [

	^ self
		findSubclassOf: anAbstractClass
		accordingTo: ( self createCanHandleMessageFor: anObject with: anotherObject )
		ifMultiple: anIfMultipleBlock
		ifNone: anIfNoneDoBlock
]

{ #category : #'subclass finding' }
SuitableClassFinder class >> findSubclassOf: anAbstractClass suitableFor: anObject with: anotherObject ifNone: anIfNoneDoBlock [

	^ self
		findSubclassOf: anAbstractClass
		suitableFor: anObject
		with: anotherObject
		ifMultiple: self defaultIfMultipleBlock
		ifNone: anIfNoneDoBlock
]

{ #category : #'private - accessing' }
SuitableClassFinder class >> format: aCollection [

	^ ( CollectionFormatter separatingWith: ', ' andLastWith: ' and ' ) format: aCollection
]

{ #category : #accessing }
SuitableClassFinder >> arguments [

	^ testingMessage arguments
]

{ #category : #accessing }
SuitableClassFinder >> classes [

	^ classes
]

{ #category : #initialization }
SuitableClassFinder >> initializeFindIn: aClassCollection accordingTo: aTestingMessage ifMultiple: anIfMultipleDoBlock ifNone: anIfNoneDoBlock [

	classes := aClassCollection.
	testingMessage := aTestingMessage.
	ifNoneDoBlock := anIfNoneDoBlock.
	ifMultipleDoBlock := anIfMultipleDoBlock
]

{ #category : #evaluating }
SuitableClassFinder >> value [

	| suitableClasses |

	suitableClasses := classes select: [ :aClass | testingMessage sendTo: aClass ].
	^ suitableClasses size = 1
		ifTrue: [ suitableClasses anyOne ]
		ifFalse: [ suitableClasses
				ifEmpty: [ ifNoneDoBlock cull: self ]
				ifNotEmpty: [ ifMultipleDoBlock value: suitableClasses value: self ]
			]
]
