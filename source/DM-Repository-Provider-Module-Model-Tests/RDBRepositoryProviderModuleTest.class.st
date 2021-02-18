"
A RDBRepositoryProviderModuleTest is a test class for testing the behavior of RDBRepositoryProviderModule
"
Class {
	#name : #RDBRepositoryProviderModuleTest,
	#superclass : #ModuleTest,
	#category : #'DM-Repository-Provider-Module-Model-Tests'
}

{ #category : #'private - accessing' }
RDBRepositoryProviderModuleTest >> moduleClass [

	^ RDBRepositoryProviderModule
]

{ #category : #'private - accessing' }
RDBRepositoryProviderModuleTest >> moduleName [

	^ 'RDB Repository Provider'
]

{ #category : #'private - accessing' }
RDBRepositoryProviderModuleTest >> systemInterfacesToInstall [

	^ #(#RepositoryProviderSystem)
]
