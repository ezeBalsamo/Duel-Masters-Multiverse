Class {
	#name : #PersistentSystemBasedUserStoryTest,
	#superclass : #SystemBasedUserStoryTest,
	#instVars : [
		'repositoryProviderModuleType'
	],
	#category : #'DM-SUnit-Model'
}

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
