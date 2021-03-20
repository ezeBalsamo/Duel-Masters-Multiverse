Class {
	#name : #PersistentSystemBasedUserStoryTest,
	#superclass : #SystemBasedUserStoryTest,
	#instVars : [
		'repositoryProviderModuleType'
	],
	#category : #'DM-Repository-Provider-System-Model-Tests'
}

{ #category : #building }
PersistentSystemBasedUserStoryTest class >> buildRDBSuiteForCI [

	^ self suite allTests
		inject: self emptySuite
		into: [ :suite :testCase | suite addTest: testCase useRelationalDatabaseRepositories ]
]

{ #category : #testing }
PersistentSystemBasedUserStoryTest class >> isAbstract [

	^ self = PersistentSystemBasedUserStoryTest
]

{ #category : #initialization }
PersistentSystemBasedUserStoryTest >> initialize [

	super initialize.
	self useInMemoryRepositories
]

{ #category : #testing }
PersistentSystemBasedUserStoryTest >> isUsingRelationalDatabaseRepositories [

	^ repositoryProviderModuleType = RDBRepositoryProviderModule
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

	self repositoryProviderSystem destroyRepositories.
	super tearDown
]

{ #category : #'private - configuring' }
PersistentSystemBasedUserStoryTest >> useInMemoryRepositories [

	repositoryProviderModuleType := InMemoryRepositoryProviderModule
]

{ #category : #'private - configuring' }
PersistentSystemBasedUserStoryTest >> useRelationalDatabaseRepositories [

	repositoryProviderModuleType := RDBRepositoryProviderModule
]
