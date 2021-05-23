Extension { #name : #ManifestSaganRDBMSKepler }

{ #category : #'*DM-Sagan-Extensions' }
ManifestSaganRDBMSKepler class >> initialize [

	self removeRepositoryProviderSystemInterface.
	
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

{ #category : #'*DM-Sagan-Extensions' }
ManifestSaganRDBMSKepler class >> removeRepositoryProviderSystemInterface [

	( Kepler bindingOf: #SystemInterfaces ) value removeBindingFor: #RepositoryProviderSystem
]
