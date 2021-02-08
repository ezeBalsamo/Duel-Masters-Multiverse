Class {
	#name : #PersistentSystemBasedUserStoryTest,
	#superclass : #SystemBasedUserStoryTest,
	#instVars : [
		'repositoryProviderModuleType'
	],
	#category : #'DM-SUnit-Model'
}

{ #category : #'private - building' }
PersistentSystemBasedUserStoryTest class >> buildRDBSuiteForCI [

	| suite |

	suite := self buildSuiteForCI.
	suite allTests do: #useRelationalDatabaseRepositories.
	^ suite
]

{ #category : #'private - building' }
PersistentSystemBasedUserStoryTest class >> buildSuiteForCI [

	| suite |

	suite := self suiteClass named: self name asString.
	self allSubclasses
		do: [ :testClass | 
			testClass isAbstract
				ifFalse: [ suite addTest: testClass buildSuiteFromSelectors ]
			].
	^ suite
]

{ #category : #'instance creation' }
PersistentSystemBasedUserStoryTest class >> suite [

	"This method is implemented to run a RDB Test Suite, both from Pharo System Browser and from SmalltalkCI.- ebalsamo"

	^ self buildRDBSuiteForCI
]

{ #category : #initialization }
PersistentSystemBasedUserStoryTest >> initialize [

	super initialize.
	self useInMemoryRepositories
]

{ #category : #'private - configuring' }
PersistentSystemBasedUserStoryTest >> prepareForInitialPersistence [

	self repositoryProviderSystem prepareForInitialPersistence
]

{ #category : #'private - system accessing' }
PersistentSystemBasedUserStoryTest >> repositoryProviderSystem [

	^ rootSystem >> #RepositoryProviderSystem
]

{ #category : #'private - running' }
PersistentSystemBasedUserStoryTest >> requiresRepositoryProviderModule [

	self requireInstallationOf: repositoryProviderModuleType
]

{ #category : #running }
PersistentSystemBasedUserStoryTest >> setUp [

	super setUp.
	self prepareForInitialPersistence
]

{ #category : #'private - running' }
PersistentSystemBasedUserStoryTest >> setUpRequirements [ 

	self requiresRepositoryProviderModule
]

{ #category : #running }
PersistentSystemBasedUserStoryTest >> tearDown [

	super tearDown.
	self repositoryProviderSystem destroyRepositories
]

{ #category : #'private - configuring' }
PersistentSystemBasedUserStoryTest >> useInMemoryRepositories [

	repositoryProviderModuleType := InMemoryRepositoryProviderModule
]

{ #category : #'private - configuring' }
PersistentSystemBasedUserStoryTest >> useRelationalDatabaseRepositories [

	repositoryProviderModuleType := RDBRepositoryProviderModule
]
