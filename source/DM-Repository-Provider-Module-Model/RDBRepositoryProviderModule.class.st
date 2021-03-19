Class {
	#name : #RDBRepositoryProviderModule,
	#superclass : #SystemModule,
	#instVars : [
		'rootSystem'
	],
	#category : #'DM-Repository-Provider-Module-Model'
}

{ #category : #'instance creation' }
RDBRepositoryProviderModule class >> toInstallOn: aCompositeSystem [

	^ self new initializeToInstallOn: aCompositeSystem
]

{ #category : #initialization }
RDBRepositoryProviderModule >> initializeToInstallOn: aCompositeSystem [

	rootSystem := aCompositeSystem
]

{ #category : #'private - accessing' }
RDBRepositoryProviderModule >> login [

	^ PostgreSQLLogin
		toDatabaseNamed: 'test'
		hostedIn: 'localhost'
		onPort: 5432
		authenticatedAs: 'postgres'
		with: 'secret'
]

{ #category : #private }
RDBRepositoryProviderModule >> name [

	^ 'RDB Repository Provider'
]

{ #category : #'private - accessing' }
RDBRepositoryProviderModule >> registerRepositoryProviderSystemForInstallationIn: systems [

	^ self
		register: [ RepositoryProviderSystem providingRDBRepositoriesWithPooledSessionsLoginWith: self login ]
		in: systems
]

{ #category : #private }
RDBRepositoryProviderModule >> rootSystem [

	^ rootSystem
]

{ #category : #private }
RDBRepositoryProviderModule >> systemInterfacesToInstall [

	^ #(#RepositoryProviderSystem)
]
