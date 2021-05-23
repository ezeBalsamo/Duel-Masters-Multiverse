Extension { #name : #ManifestSaganRDBMSKepler }

{ #category : #'*DM-Sagan-Extensions' }
ManifestSaganRDBMSKepler class >> initialize [

	Kepler
		registerInterfaceAt: #RepositoryProviderSystem 
		named: 'Repository Provider System Interface'
		declaring: #(
			createRepositoryFor:storingObjectsOfType:checkingConflictsAccordingTo:
			repositoryToStoreObjectsOfType:checkingConflictsAccordingTo:
			register:as:		
			prepareForInitialPersistence
			destroyRepositories)
]
