Class {
	#name : #PackageIntegrityTest,
	#superclass : #TestCase,
	#instVars : [
		'baselinePackages',
		'dependencyNamesByPackageName',
		'baselineDependencies',
		'knownPharoPackageNames'
	],
	#category : #'DM-Development-Tests'
}

{ #category : #accessing }
PackageIntegrityTest class >> defaultTimeLimit [

	^ 1 minute
]

{ #category : #'private - accessing' }
PackageIntegrityTest >> allDefinedDependenciesFrom: anInternalDependencyNamesCollection [

	| allDefinedDependencies dependenciesAnalyzed dependenciesToAnalyze |

	allDefinedDependencies := Set new.
	dependenciesAnalyzed := Set new.
	dependenciesToAnalyze := anInternalDependencyNamesCollection.


	[ dependenciesAnalyzed := dependenciesToAnalyze
		flatCollect: [ :anInternalDependencyName | self baselineDefinedDependenciesOf: anInternalDependencyName ].
	dependenciesToAnalyze := dependenciesAnalyzed
		select: [ :aPackageName | self isInternalDependency: aPackageName ].
	allDefinedDependencies
		addAll: ( dependenciesAnalyzed reject: [ :aPackageName | self isInternalDependency: aPackageName ] ).
	dependenciesToAnalyze isNotEmpty
	] whileTrue.

	^ allDefinedDependencies
]

{ #category : #'private - evaluating' }
PackageIntegrityTest >> analyzeMissingMethodsWithPotentialMatchWith: aDAMessageSendAnalyzer recordingFailuresOn: aStream [

	aDAMessageSendAnalyzer missingMethodsWithPotentialMatch
		keysAndValuesDo: [ :selector :packageNamesImplementingIt | 
			| ownedPackageNames |

			ownedPackageNames := packageNamesImplementingIt
				select: [ :anImplementorPackageName | self isInternalDependency: anImplementorPackageName ].

			ownedPackageNames
				ifNotEmpty: [ self
						logOn: aStream
						that: selector
						from: aDAMessageSendAnalyzer packageName
						isMissingMethodPotentiallyImplementedBy: ownedPackageNames
					]
			]
]

{ #category : #asserting }
PackageIntegrityTest >> assert: aBoolean description: aFailureExplanation [

	super
		assert: aBoolean
		description: [ self
				considerOpeningFailureLog;
				failureExplanationWithTestNameDueTo: aFailureExplanation
			]
]

{ #category : #'private - accessing' }
PackageIntegrityTest >> assertIsNotOwnProject: aRepositoryName [

	| ownedRepositoryName |

	ownedRepositoryName := MetacelloScriptEngine baseNameOf: self ownBaselineName.
	^ ownedRepositoryName = aRepositoryName
]

{ #category : #'private - accessing' }
PackageIntegrityTest >> baselineDefinedDependenciesOf: aPackageName [

	^ baselinePackages
		detect: [ :aPackageRepresentation | self is: aPackageRepresentation named: aPackageName ]
		ifFound: [ :aPackageRepresentation | self requirementNamesOf: aPackageRepresentation ]
		ifNone: [ self fail ]
]

{ #category : #'private - accessing' }
PackageIntegrityTest >> baselineDependencyNameFrom: aBaselineDependencyNameCollection loadingRepositoryNamed: aRepositoryName [

	^ aBaselineDependencyNameCollection
		detect: [ :aBaselineDependencyName | aBaselineDependencyName = aRepositoryName ]
		ifNone: [ self
				baselineDependencyNameFrom: aBaselineDependencyNameCollection
				requiringRepositoryNamed: aRepositoryName
			]
]

{ #category : #'private - accessing' }
PackageIntegrityTest >> baselineDependencyNameFrom: aBaselineDependencyNameCollection requiringRepositoryNamed: aRepositoryName [

	self assertIsNotOwnProject: aRepositoryName.

	^ Metacello registrations
		detect: [ :aMetacelloProjectRegistration | aMetacelloProjectRegistration baseName = aRepositoryName ]
		ifFound: [ :aMetacelloProjectRegistration | 
			| loaderRepositoryName |

			loaderRepositoryName := MetacelloScriptEngine
				baseNameOf: aMetacelloProjectRegistration baselineProjectSpec project version spec projectLabel.

			self
				baselineDependencyNameFrom: aBaselineDependencyNameCollection
				loadingRepositoryNamed: loaderRepositoryName
			]
		ifNone: [ self
				fail:
					( 'No baseline defined dependencies requires repository named <1s>.'
						expandMacrosWith: aRepositoryName )
			]
]

{ #category : #'private - accessing' }
PackageIntegrityTest >> baselineNameOf: aDependencyRepresentation [

	^ aDependencyRepresentation at: #baselineName
]

{ #category : #'private - evaluating' }
PackageIntegrityTest >> calculateAndCacheExternalDependencyNameLoadingPackageNamed: aPackageName fromRepositoryNamed: aRepositoryName [

	| dependencyName |

	dependencyName := self externalDependencyNameLoadingRepositoryNamed: aRepositoryName.
	dependencyNamesByPackageName at: aPackageName put: dependencyName.
	^ dependencyName
]

{ #category : #'private - evaluating' }
PackageIntegrityTest >> calculateExternalDependencyNameLoadingPackageNamed: aPackageName [

	^ IceRepository registry
		detect: [ :anIceLibgitRepository | anIceLibgitRepository includesPackageNamed: aPackageName ]
		ifFound: [ :anIceLibgitRepository | 
			self
				calculateAndCacheExternalDependencyNameLoadingPackageNamed: aPackageName
				fromRepositoryNamed: anIceLibgitRepository name
			]
		ifNone: [ aPackageName ]
]

{ #category : #'private - accessing' }
PackageIntegrityTest >> calculatePackageRelationGraph [

	^ ( DAPackageRelationGraph onPackagesNamed: self ownedPackageNames ) build
]

{ #category : #'private - evaluating' }
PackageIntegrityTest >> compareBaselineDependenciesOf: aPackageName
	withThoseCalculatedWith: relationGraph
	recordingFailuresOn: aStream [


	| defined current missing extra |

	defined := self baselineDefinedDependenciesOf: aPackageName.
	current := self currentDependenciesOf: aPackageName basedOn: relationGraph.

	extra := defined difference: current.
	missing := current difference: defined.

	extra isNotEmpty
		ifTrue: [ self log: extra asExtraDependenciesOf: aPackageName on: aStream ].

	missing isNotEmpty
		ifTrue: [ self log: missing asMissingDependenciesOf: aPackageName on: aStream ]
]

{ #category : #'private - logging' }
PackageIntegrityTest >> considerOpeningFailureLog [

	<ignoreForCoverage>
	| failureLog |

	failureLog := self failureLog.
	( failureLog isInteractive and: [ failureLog dependents isEmpty ] ) then: [ failureLog open ]
]

{ #category : #'private - accessing' }
PackageIntegrityTest >> currentDependenciesOf: aPackageName basedOn: aDAPackageRelationGraph [

	| calculatedDependencyNames internalDependencyNames externalDependencyNames |

	calculatedDependencyNames := self
		dependencyNamesOf: aPackageName
		calculatedWith: aDAPackageRelationGraph.

	internalDependencyNames := self internalDependencyNamesFrom: calculatedDependencyNames.

	externalDependencyNames := self
		externalDependencyNamesFrom: calculatedDependencyNames
		notRequiredBy: internalDependencyNames.

	^ OrderedCollection new
		addAll: internalDependencyNames;
		addAll: externalDependencyNames;
		yourself
]

{ #category : #'private - accessing' }
PackageIntegrityTest >> dependencyNamesOf: aPackageName calculatedWith: aDAPackageRelationGraph [

	^ ( aDAPackageRelationGraph dependenciesFrom: aPackageName )
		collect: [ :dependency | dependency target packageName ]
]

{ #category : #'private - accessing' }
PackageIntegrityTest >> externalDependencyNameLoadingPackageNamed: aPackageName [

	^ dependencyNamesByPackageName
		at: aPackageName
		ifAbsent: [ self calculateExternalDependencyNameLoadingPackageNamed: aPackageName ]
]

{ #category : #'private - accessing' }
PackageIntegrityTest >> externalDependencyNameLoadingRepositoryNamed: aRepositoryName [

	| baselineDependencyNames |

	baselineDependencyNames := baselineDependencies
		collect: [ :aDependencyRepresentation | self baselineNameOf: aDependencyRepresentation ].

	^ self baselineDependencyNameFrom: baselineDependencyNames loadingRepositoryNamed: aRepositoryName
]

{ #category : #'private - accessing' }
PackageIntegrityTest >> externalDependencyNamesFrom: calculatedDependencyNames
	notRequiredBy: anInternalDependencyNamesCollection [


	| externalDependencyNames |

	externalDependencyNames := ( calculatedDependencyNames
		select: [ :aDependencyName | self isExternalDependency: aDependencyName ]
		thenCollect: [ :aDependencyName | self externalDependencyNameLoadingPackageNamed: aDependencyName ] )
		asSet.

	^ externalDependencyNames
		reject: [ :aDependencyName | self is: aDependencyName requiredBy: anInternalDependencyNamesCollection ]
]

{ #category : #'private - logging' }
PackageIntegrityTest >> failureExplanationWithTestNameDueTo: aFailureExplanation [

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
PackageIntegrityTest >> format: aCollection [

	<ignoreForCoverage>
	^ ( CollectionFormatter separatingWith: ', ' andLastWith: ' and ' ) format: aCollection
]

{ #category : #'private - accessing' }
PackageIntegrityTest >> internalDependencyNamesFrom: calculatedDependencyNames [

	^ calculatedDependencyNames
		select: [ :aDependencyName | self isInternalDependency: aDependencyName ]
]

{ #category : #'private - testing' }
PackageIntegrityTest >> is: aPackageRepresentation named: aPackageName [

	^ ( self packageNameOf: aPackageRepresentation ) = aPackageName
]

{ #category : #'private - testing' }
PackageIntegrityTest >> is: anExternalDependencyName requiredBy: anInternalDependencyNamesCollection [

	^ ( self allDefinedDependenciesFrom: anInternalDependencyNamesCollection )
		includes: anExternalDependencyName
]

{ #category : #'private - testing' }
PackageIntegrityTest >> isExternalDependency: aDependencyName [

	^ ( self isFromPharo: aDependencyName ) not
		and: [ ( self isInternalDependency: aDependencyName ) not
				and: [ aDependencyName ~= BaselineOfDuelMasters name ]
			]
]

{ #category : #'private - testing' }
PackageIntegrityTest >> isFromPharo: aPackageName [

	^ knownPharoPackageNames includes: aPackageName
]

{ #category : #'private - testing' }
PackageIntegrityTest >> isInternalDependency: aPackageName [

	^ aPackageName beginsWith: 'DM'
]

{ #category : #'private - logging' }
PackageIntegrityTest >> isLogging [

	"Overriding this method so failures are log on Trascript"

	<ignoreForCoverage>
	^ true
]

{ #category : #'private - testing' }
PackageIntegrityTest >> isMainRepository: anIceLibgitRepository [

	^ anIceLibgitRepository name = 'Duel-Masters-Multiverse'
]

{ #category : #'private - logging' }
PackageIntegrityTest >> log: anExtraDependencyNameCollection asExtraDependenciesOf: aPackageName on: aStream [

	<ignoreForCoverage>
	self
		log: anExtraDependencyNameCollection
		dueTo: ( '<1s> has the extra following dependencies: ' expandMacrosWith: aPackageName )
		on: aStream
]

{ #category : #'private - logging' }
PackageIntegrityTest >> log: aMissingDependencyNameCollection asMissingDependenciesOf: aPackageName on: aStream [

	<ignoreForCoverage>
	self
		log: aMissingDependencyNameCollection
		dueTo: ( '<1s> is missing the following dependencies: ' expandMacrosWith: aPackageName )
		on: aStream
]

{ #category : #'private - logging' }
PackageIntegrityTest >> log: aDependencyNameCollection dueTo: anExplanation on: aStream [

	| dependencies |

	aStream nextPutAll: anExplanation.
	dependencies := self format: aDependencyNameCollection.
	aStream
		nextPutAll: dependencies;
		cr
]

{ #category : #'private - logging' }
PackageIntegrityTest >> logOn: aStream that: aSelector from: aPackageName isMissingMethodPotentiallyImplementedBy: anOwnedPackageNameCollection [

	<ignoreForCoverage>
	aStream
		nextPutAll:
			( '<1s> from <2s> is a missing method potentially implemented by this own packages: <3s>.'
				expandMacrosWith: aSelector
				with: aPackageName
				with: ( self format: anOwnedPackageNameCollection ) );
		cr
]

{ #category : #'private - accessing' }
PackageIntegrityTest >> ownBaselineName [

	^ BaselineOfDuelMasters name
]

{ #category : #'private - accessing' }
PackageIntegrityTest >> ownedPackageNames [

	^ RPackageOrganizer default packages
		select: [ :package | package name beginsWith: 'DM' ]
		thenCollect: #name
]

{ #category : #'private - accessing' }
PackageIntegrityTest >> packageNameOf: aPackageRepresentation [

	^ aPackageRepresentation at: #packageName
]

{ #category : #running }
PackageIntegrityTest >> pharoCollectionPackageNamesUsed [

	^ OrderedCollection
		with: 'Collections-Sequenceable'
		with: 'Collections-Strings'
		with: 'Collections-Abstract'
		with: 'Collections-Unordered'
]

{ #category : #running }
PackageIntegrityTest >> pharoPackageOrganizerPackageNamesUsed [

	^ OrderedCollection
		with: 'RPackage-Core'
		with: 'Tool-DependencyAnalyser'
		with: 'Tool-DependencyAnalyser-UI'
		with: 'Tool-DependencyAnalyser-Tests'
]

{ #category : #running }
PackageIntegrityTest >> pharoTranscriptPackageNamesUsed [

	^ OrderedCollection with: 'Transcript-Core' with: 'Transcript-NonInteractive'
]

{ #category : #running }
PackageIntegrityTest >> pharoVersioningPackageNamesUsed [

	^ OrderedCollection with: 'Metacello-Base' with: 'Metacello-Core' with: 'Iceberg'
]

{ #category : #'private - accessing' }
PackageIntegrityTest >> requirementNamesOf: aPackageRepresentation [

	^ aPackageRepresentation at: #requirementNames
]

{ #category : #'private - logging' }
PackageIntegrityTest >> runLoggingFailuresOn: aBlockClosure [

	| failureDetails |

	failureDetails := String streamContents: aBlockClosure.

	self assert: failureDetails isEmpty description: failureDetails
]

{ #category : #running }
PackageIntegrityTest >> setUp [

	| baseline |

	super setUp.
	self setUpKnownPharoPackageNames.
	baseline := BaselineOfDuelMasters new.
	baselinePackages := baseline packages.
	baselineDependencies := baseline dependencies.
	dependencyNamesByPackageName := Dictionary new
]

{ #category : #running }
PackageIntegrityTest >> setUpKnownPharoPackageNames [

	knownPharoPackageNames := OrderedCollection new
		add: 'Kernel';
		add: 'SUnit-Core';
		addAll: self pharoTranscriptPackageNamesUsed;
		addAll: self pharoCollectionPackageNamesUsed;
		addAll: self pharoPackageOrganizerPackageNamesUsed;
		addAll: self pharoVersioningPackageNamesUsed;
		yourself
]

{ #category : #tests }
PackageIntegrityTest >> test01AllOwnedPackagesAreDeclaredInBaseline [

	| baselinePackageNames |

	baselinePackageNames := baselinePackages
		collect: [ :aPackageRepresentation | self packageNameOf: aPackageRepresentation ].
	self assertCollection: baselinePackageNames hasSameElements: self ownedPackageNames
]

{ #category : #tests }
PackageIntegrityTest >> test02AllOwnedPackagesAreIncludedInRepository [

	| repositoryPackageNames ownedPackageNamesWithBaselinePackageName |

	repositoryPackageNames := IceRepository registry
		detect: [ :anIceLibgitRepository | self isMainRepository: anIceLibgitRepository ]
		ifFound: [ :anIceLibgitRepository | anIceLibgitRepository loadedPackages collect: #packageName ]
		ifNone: [ self skip: 'Skipped since it''s beign run in CI.' ].

	ownedPackageNamesWithBaselinePackageName := self ownedPackageNames copyWith: self ownBaselineName.

	self
		assertCollection: repositoryPackageNames
		hasSameElements: ownedPackageNamesWithBaselinePackageName
]

{ #category : #tests }
PackageIntegrityTest >> test03PackageRequirements [

	self
		runLoggingFailuresOn: [ :aStream | 
			| relationGraph |

			relationGraph := self calculatePackageRelationGraph.

			self
				withOwnedPackageNamesDo: [ :aPackageName | 
					self
						compareBaselineDependenciesOf: aPackageName
						withThoseCalculatedWith: relationGraph
						recordingFailuresOn: aStream
					]
			]
]

{ #category : #tests }
PackageIntegrityTest >> test04NoOwnedPackageHasMissingMethodsThatSendsMessagesPotentiallyImplementedByAnOwnedPackage [

	self
		runLoggingFailuresOn: [ :aStream | 
			self
				withOwnedPackageNamesDo: [ :aPackageName | 
					| messageSendAnalyzer |

					messageSendAnalyzer := DAMessageSendAnalyzer on: aPackageName.
					self
						analyzeMissingMethodsWithPotentialMatchWith: messageSendAnalyzer
						recordingFailuresOn: aStream
					]
			]
]

{ #category : #'private - accessing' }
PackageIntegrityTest >> withOwnedPackageNamesDo: aBlockClosure [

	self ownedPackageNames do: aBlockClosure
]
