"
An InMemoryRepositoryProviderModuleTest is a test class for testing the behavior of InMemoryRepositoryProviderModule
"
Class {
	#name : #InMemoryRepositoryProviderModuleTest,
	#superclass : #ModuleTest,
	#category : #'DM-Repository-Provider-Module-Model-Tests'
}

{ #category : #'private - accessing' }
InMemoryRepositoryProviderModuleTest >> moduleClass [

	^ InMemoryRepositoryProviderModule
]

{ #category : #'private - accessing' }
InMemoryRepositoryProviderModuleTest >> moduleName [

	^ 'In Memory Repository Provider'
]

{ #category : #'private - accessing' }
InMemoryRepositoryProviderModuleTest >> systemInterfacesToInstall [

	^ #(#RepositoryProviderSystem)
]
