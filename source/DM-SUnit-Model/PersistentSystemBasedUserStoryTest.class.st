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

{ #category : #'private - running' }
PersistentSystemBasedUserStoryTest >> requiresRepositoryProviderModule [

	self requireInstallationOf: repositoryProviderModuleType
]

{ #category : #'private - running' }
PersistentSystemBasedUserStoryTest >> setUpRequirements [ 

	self requiresRepositoryProviderModule
]

{ #category : #'private - configuring' }
PersistentSystemBasedUserStoryTest >> useInMemoryRepositories [

	repositoryProviderModuleType := InMemoryRepositoryProviderModule
]
