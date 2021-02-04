Extension { #name : #RepositoryProviderSystem }

{ #category : #'*DM-Tools' }
RepositoryProviderSystem class >> providingInMemoryRepositories [

	^ self new
		register: InMemoryRepositoryProvider new as: 'Repository Provider';
		yourself
]

{ #category : #'*DM-Tools' }
RepositoryProviderSystem class >> providingRDBRepositoriesWithPooledSessionsLoginWith: aLogin [

	^ self new
		register: ( RDBMSRepositoryProvider using: aLogin ) as: 'Repository Provider';
		yourself
]

{ #category : #'*DM-Tools' }
RepositoryProviderSystem >> repositoryToStoreObjectsOfType: aBusinessObjectClass
	checkingConflictsAccordingTo: aCriteriaBasedConflictCheckingStrategy [


	^ self
		createRepositoryFor: 'Repository Provider'
		storingObjectsOfType: aBusinessObjectClass
		checkingConflictsAccordingTo: aCriteriaBasedConflictCheckingStrategy
]
