"
A RepositoryProviderModuleTest is a test class for testing the behavior of RepositoryProviderModule
"
Class {
	#name : #RepositoryProviderModuleTest,
	#superclass : #ModuleTest,
	#category : #'DM-Repository-Provider-Module-Model-Tests'
}

{ #category : #'private - accessing' }
RepositoryProviderModuleTest >> moduleClass [

	^ RepositoryProviderModule
]

{ #category : #'private - accessing' }
RepositoryProviderModuleTest >> moduleName [

	^ 'Repository Provider'
]

{ #category : #'private - accessing' }
RepositoryProviderModuleTest >> systemInterfacesToInstall [

	^ #(#RepositoryProviderSystem)
]
