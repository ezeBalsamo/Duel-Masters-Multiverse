Class {
	#name : #CivilizationManagementSystem,
	#superclass : #SubsystemImplementation,
	#instVars : [
		'singleCivilizations'
	],
	#category : #'DM-Civilization-Management-System-Model'
}

{ #category : #querying }
CivilizationManagementSystem >> allCivilizations [

	^ singleCivilizations findAll
]

{ #category : #installing }
CivilizationManagementSystem >> dependencies [

	^ #()
]

{ #category : #installing }
CivilizationManagementSystem >> implementedInterfaces [

	^ #(#CivilizationManagementSystemInterface)
]

{ #category : #accessing }
CivilizationManagementSystem >> name [

	^'Civilization Management System'
]

{ #category : #management }
CivilizationManagementSystem >> purgeCivilization: aSingleCivilization [

	singleCivilizations purge: aSingleCivilization 
]

{ #category : #installing }
CivilizationManagementSystem >> resolveDependencies [

	| repositoryProviderSystem |

	super resolveDependencies.
	repositoryProviderSystem := self parent >> #RepositoryProviderSystem.
	singleCivilizations := repositoryProviderSystem
		repositoryToStoreObjectsOfType: SingleCivilization
		checkingConflictsAccordingTo:
			( CriteriaBasedConflictCheckingStrategy
				accordingTo:
					[ :objectInRepository :criteria :objectInMemory | objectInMemory hasSameNameThan: objectInRepository ] )
]

{ #category : #management }
CivilizationManagementSystem >> storeCivilization: aSingleCivilization [

	singleCivilizations store: aSingleCivilization
]

{ #category : #management }
CivilizationManagementSystem >> updateCivilization: aSingleCivilization with: anUpdatedSingleCivilization [

	singleCivilizations update: aSingleCivilization with: anUpdatedSingleCivilization
]

{ #category : #querying }
CivilizationManagementSystem >> withCivilizationNamed: aCivilizationName do: aFoundBlock else: aNotFoundBlock [

	^ singleCivilizations
		withOneMatching: [ :civilization | civilization isNamed: aCivilizationName ]
		do: aFoundBlock
		else: aNotFoundBlock
]
