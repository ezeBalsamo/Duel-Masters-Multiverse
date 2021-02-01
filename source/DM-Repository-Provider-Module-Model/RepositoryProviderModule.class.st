Class {
	#name : #RepositoryProviderModule,
	#superclass : #SystemModule,
	#instVars : [
		'rootSystem'
	],
	#category : #'DM-Repository-Provider-Module-Model'
}

{ #category : #'instance creation' }
RepositoryProviderModule class >> toInstallOn: aCompositeSystem [

	^ self new initializeToInstallOn: aCompositeSystem
]

{ #category : #initialization }
RepositoryProviderModule >> initializeToInstallOn: aCompositeSystem [

	rootSystem := aCompositeSystem
]

{ #category : #private }
RepositoryProviderModule >> name [

	^ 'Repository Provider'
]

{ #category : #'private - accessing' }
RepositoryProviderModule >> registerRepositoryProviderSystemForInstallationIn: systems [

	^ self register: [ RepositoryProviderSystem new ] in: systems
]

{ #category : #private }
RepositoryProviderModule >> rootSystem [

	^ rootSystem
]

{ #category : #private }
RepositoryProviderModule >> systemInterfacesToInstall [

	^ #(#RepositoryProviderSystem)
]
