Class {
	#name : #CivilizationManagementSystem,
	#superclass : #SubsystemImplementation,
	#instVars : [
		'civilizations'
	],
	#category : #'DM-Civilization-Management-System-Model'
}

{ #category : #querying }
CivilizationManagementSystem >> allCivilizations [

	^ civilizations findAll
]

{ #category : #'private - querying' }
CivilizationManagementSystem >> civilizationNamed: aCivilizationName [

	^ self
		withCivilizationNamed: aCivilizationName
		do: #yourself
		else: [ Error signal: ( 'There is no civilization named <1s>.' expandMacrosWith: aCivilizationName ) ]
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
		repositoryToStoreObjectsOfType: SingleCivilization
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
CivilizationManagementSystem >> withCivilizationNamed: aCivilizationName do: aFoundBlock else: aNotFoundBlock [

	^ civilizations
		withOneMatching: [ :civilization | civilization name = aCivilizationName ]
		do: aFoundBlock
		else: aNotFoundBlock
]
