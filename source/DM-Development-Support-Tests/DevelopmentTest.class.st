Class {
	#name : #DevelopmentTest,
	#superclass : #TestCase,
	#category : #'DM-Development-Support-Tests'
}

{ #category : #testing }
DevelopmentTest class >> isAbstract [

	^ self = DevelopmentTest
]

{ #category : #asserting }
DevelopmentTest >> assert: aBoolean description: aFailureExplanation [

	super
		assert: aBoolean
		description: [ self
				considerOpeningFailureLog;
				failureExplanationWithTestNameDueTo: aFailureExplanation
			]
]

{ #category : #'private - logging' }
DevelopmentTest >> considerOpeningFailureLog [

	<ignoreForCoverage>
	| failureLog |

	failureLog := self failureLog.
	( failureLog isInteractive and: [ failureLog dependents isEmpty ] ) then: [ failureLog open ]
]

{ #category : #'private - logging' }
DevelopmentTest >> failureExplanationWithTestNameDueTo: aFailureExplanation [

	<ignoreForCoverage>
	^ String
		streamContents: [ :aStream | 
			92 timesRepeat: [ aStream nextPutAll: '-' ].
			aStream
				cr;
				print: self;
				cr;
				nextPutAll: aFailureExplanation
			]
]

{ #category : #'private - logging' }
DevelopmentTest >> isLogging [

	"Overriding this method so failures are log on Trascript"

	<ignoreForCoverage>
	^ true
]

{ #category : #'private - logging' }
DevelopmentTest >> log: aFailureDescription on: aStream [

	<ignoreForCoverage>
	aStream
		nextPutAll: aFailureDescription;
		cr
]

{ #category : #'private - accessing' }
DevelopmentTest >> ownedClasses [

	^ self ownedPackages flatCollect: #definedClasses
]

{ #category : #'private - accessing' }
DevelopmentTest >> ownedPackages [

	^ RPackageOrganizer default packages select: [ :package | package name beginsWith: 'DM' ]
]

{ #category : #'private - logging' }
DevelopmentTest >> runLoggingFailuresOn: aBlockClosure [

	| failureDetails |

	failureDetails := String streamContents: aBlockClosure.

	self assert: failureDetails isEmpty description: failureDetails
]

{ #category : #'private - accessing' }
DevelopmentTest >> withAllOwnedClassesDo: aBlockClosure [

	self ownedClasses do: aBlockClosure
]
