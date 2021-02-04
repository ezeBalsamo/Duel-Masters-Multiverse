Class {
	#name : #CivilizationManagementSystemUserStoryTest,
	#superclass : #PersistentSystemBasedUserStoryTest,
	#instVars : [
		'civilizationManagementSystem'
	],
	#category : #'DM-Civilization-Management-System-Model-Tests'
}

{ #category : #'private - querying' }
CivilizationManagementSystemUserStoryTest >> allSingleCivilizations [

	^ civilizationManagementSystem allCivilizations
]

{ #category : #running }
CivilizationManagementSystemUserStoryTest >> setUp [

	super setUp.
	civilizationManagementSystem := rootSystem >> #CivilizationManagementSystemInterface
]

{ #category : #'private - running' }
CivilizationManagementSystemUserStoryTest >> setUpRequirements [

	super setUpRequirements.
	self registerSubsystem: CivilizationManagementSystem new
]

{ #category : #tests }
CivilizationManagementSystemUserStoryTest >> test01StoringASingleCivilization [

	| fireCivilizationName singleCivilization |

	fireCivilizationName := 'Fire'.
	singleCivilization := SingleCivilization named: fireCivilizationName.

	self assert: self allSingleCivilizations isEmpty.

	civilizationManagementSystem storeCivilization: singleCivilization.

	civilizationManagementSystem
		withCivilizationNamed: fireCivilizationName
		do: [ :storedCivilization | self assert: singleCivilization equals: storedCivilization ]
		else: [ self fail ]
]

{ #category : #tests }
CivilizationManagementSystemUserStoryTest >> test02CantStoreASingleCivilizationWhenIsAlreadyStoreAnotherWithTheSameName [

	| fireCivilizationName singleCivilization anotherSingleCivilization |

	fireCivilizationName := 'Fire'.
	singleCivilization := SingleCivilization named: fireCivilizationName.
	anotherSingleCivilization := SingleCivilization named: fireCivilizationName.

	self assert: self allSingleCivilizations isEmpty.

	civilizationManagementSystem storeCivilization: singleCivilization.

	civilizationManagementSystem
		withCivilizationNamed: fireCivilizationName
		do: [ :storedCivilization | self assert: singleCivilization equals: storedCivilization ]
		else: [ self fail ].

	self
		should: [ civilizationManagementSystem storeCivilization: anotherSingleCivilization ]
		raise: ConflictingObjectFound
		withMessageText: ( 'Something is in conflict with <1p>' expandMacrosWith: anotherSingleCivilization )
]

{ #category : #tests }
CivilizationManagementSystemUserStoryTest >> test03UpdatingASingleCivilization [

	| badSpelledFireCivilizationName properlySpelledFireCivilizationName singleCivilization updatedSingleCivilization |

	badSpelledFireCivilizationName := 'Firee'.
	properlySpelledFireCivilizationName := 'Fire'.
	singleCivilization := SingleCivilization named: badSpelledFireCivilizationName.
	updatedSingleCivilization := SingleCivilization named: properlySpelledFireCivilizationName.

	self assert: self allSingleCivilizations isEmpty.

	civilizationManagementSystem storeCivilization: singleCivilization.
	civilizationManagementSystem updateCivilization: singleCivilization with: updatedSingleCivilization.

	self
		withTheOnlyOneIn: self allSingleCivilizations
		do: [ :storedCivilization | self assert: updatedSingleCivilization equals: updatedSingleCivilization ]
]
