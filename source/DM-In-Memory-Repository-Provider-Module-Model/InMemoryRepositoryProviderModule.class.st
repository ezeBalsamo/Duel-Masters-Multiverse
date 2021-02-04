Class {
	#name : #InMemoryRepositoryProviderModule,
	#superclass : #SystemModule,
	#instVars : [
		'rootSystem'
	],
	#category : #'DM-In-Memory-Repository-Provider-Module-Model'
}

{ #category : #'instance creation' }
InMemoryRepositoryProviderModule class >> toInstallOn: aCompositeSystem [

	^ self new initializeToInstallOn: aCompositeSystem
]

{ #category : #initialization }
InMemoryRepositoryProviderModule >> initializeToInstallOn: aCompositeSystem [

	rootSystem := aCompositeSystem
]

{ #category : #initialization }
InMemoryRepositoryProviderModule >> name [

	^ 'In Memory Repository Provider'
]

{ #category : #'private - accessing' }
InMemoryRepositoryProviderModule >> registerRepositoryProviderSystemForInstallationIn: systems [

	^ self register: [ RepositoryProviderSystem providingInMemoryRepositories ] in: systems
]

{ #category : #initialization }
InMemoryRepositoryProviderModule >> rootSystem [

	^ rootSystem
]

{ #category : #initialization }
InMemoryRepositoryProviderModule >> systemInterfacesToInstall [

	^ #(#RepositoryProviderSystem)
]
