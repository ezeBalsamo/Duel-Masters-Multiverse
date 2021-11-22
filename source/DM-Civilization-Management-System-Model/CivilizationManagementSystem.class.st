Class {
	#name : #CivilizationManagementSystem,
	#superclass : #SubsystemImplementation,
	#instVars : [
		'civilizations'
	],
	#category : #'DM-Civilization-Management-System-Model'
}

{ #category : #'private - querying' }
CivilizationManagementSystem >> civilizationNamed: aCivilizationName [

	^ self
		withCivilizationNamed: aCivilizationName
		do: #yourself
		else: [ ObjectNotFound
				signal: ( 'There is no civilization named <1s>.' expandMacrosWith: aCivilizationName )
			]
]

{ #category : #querying }
CivilizationManagementSystem >> civilizations [

	^ civilizations findAll
]

{ #category : #querying }
CivilizationManagementSystem >> darknessCivilization [

	^ self civilizationNamed: 'Darkness'
]

{ #category : #installing }
CivilizationManagementSystem >> dependencies [

	^ #()
]

{ #category : #querying }
CivilizationManagementSystem >> fireCivilization [

	^ self civilizationNamed: 'Fire'
]

{ #category : #installing }
CivilizationManagementSystem >> implementedInterfaces [

	^ #(#CivilizationManagementSystemInterface)
]

{ #category : #querying }
CivilizationManagementSystem >> lightCivilization [

	^ self civilizationNamed: 'Light'
]

{ #category : #accessing }
CivilizationManagementSystem >> name [

	^'Civilization Management System'
]

{ #category : #querying }
CivilizationManagementSystem >> natureCivilization [

	^ self civilizationNamed: 'Nature'
]

{ #category : #management }
CivilizationManagementSystem >> purgeCivilization: aSingleCivilization [

	civilizations purge: aSingleCivilization 
]

{ #category : #installing }
CivilizationManagementSystem >> resolveDependencies [

	| repositoryProviderSystem |

	super resolveDependencies.
	repositoryProviderSystem := self parent >> #RepositoryProviderSystem.
	civilizations := repositoryProviderSystem
		repositoryToStoreObjectsOfType: Civilization
		checkingConflictsAccordingTo: ( CriteriaBasedConflictCheckingStrategy forSingleAspectMatching: #name ).

	CivilizationMappingConfiguration new applyTo: civilizations
]

{ #category : #management }
CivilizationManagementSystem >> storeCivilization: aSingleCivilization [

	civilizations store: aSingleCivilization
]

{ #category : #management }
CivilizationManagementSystem >> updateCivilization: aSingleCivilization with: anUpdatedSingleCivilization [

	civilizations update: aSingleCivilization with: anUpdatedSingleCivilization
]

{ #category : #querying }
CivilizationManagementSystem >> waterCivilization [

	^ self civilizationNamed: 'Water'
]

{ #category : #querying }
CivilizationManagementSystem >> withCivilizationNamed: aCivilizationName do: aFoundBlock else: aNotFoundBlock [

	^ civilizations
		withOneMatching: [ :civilization | civilization name = aCivilizationName ]
		do: aFoundBlock
		else: aNotFoundBlock
]
