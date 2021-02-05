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

{ #category : #'private - accessing' }
CivilizationManagementSystemUserStoryTest >> fireCivilization [

	^ SingleCivilization named: self fireCivilizationName
]

{ #category : #'private - accessing' }
CivilizationManagementSystemUserStoryTest >> fireCivilizationName [

	^ 'Fire'
]

{ #category : #'private - support' }
CivilizationManagementSystemUserStoryTest >> purge: aSingleCivilization [

	civilizationManagementSystem purgeCivilization: aSingleCivilization
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

{ #category : #'private - support' }
CivilizationManagementSystemUserStoryTest >> store: aCivilization [

	civilizationManagementSystem storeCivilization: aCivilization
]

{ #category : #tests }
CivilizationManagementSystemUserStoryTest >> test01StoringACivilization [

	| fireCivilization |

	fireCivilization := self fireCivilization.

	self assert: self allSingleCivilizations isEmpty.

	self store: fireCivilization.

	self
		withCivilizationNamed: self fireCivilizationName
		do: [ :storedCivilization | self assert: fireCivilization equals: storedCivilization ]
]

{ #category : #tests }
CivilizationManagementSystemUserStoryTest >> test02StoringManyCivilizations [

	| fireCivilization waterCivilization |

	fireCivilization := self fireCivilization.
	waterCivilization := self waterCivilization.

	self assert: self allSingleCivilizations isEmpty.

	self
		store: fireCivilization;
		store: waterCivilization.

	self assert: self allSingleCivilizations size equals: 2.

	self
		withCivilizationNamed: self fireCivilizationName
		do: [ :storedCivilization | self assert: fireCivilization equals: storedCivilization ].

	self
		withCivilizationNamed: self waterCivilizationName
		do: [ :storedCivilization | self assert: waterCivilization equals: storedCivilization ]
]

{ #category : #tests }
CivilizationManagementSystemUserStoryTest >> test03CantStoreACivilizationWhenIsAlreadyStoreAnotherWithTheSameName [

	| fireCivilization anotherFireCivilization |

	fireCivilization := self fireCivilization.
	anotherFireCivilization := self fireCivilization.

	self assert: self allSingleCivilizations isEmpty.

	self store: fireCivilization.

	self
		withCivilizationNamed: self fireCivilizationName
		do: [ :storedCivilization | self assert: fireCivilization equals: storedCivilization ].

	self
		should: [ self store: anotherFireCivilization ]
		raise: ConflictingObjectFound
		withMessageText: ( 'Something is in conflict with <1p>' expandMacrosWith: anotherFireCivilization )
]

{ #category : #tests }
CivilizationManagementSystemUserStoryTest >> test04UpdatingACivilization [

	| civilizationToUpdate updatedCivilization |

	civilizationToUpdate := self fireCivilization.
	updatedCivilization := self waterCivilization.

	self assert: self allSingleCivilizations isEmpty.

	self store: civilizationToUpdate.
	self update: civilizationToUpdate with: updatedCivilization.

	self
		withTheOnlyOneIn: self allSingleCivilizations
		do: [ :storedCivilization | 
			self
				assert: storedCivilization equals: civilizationToUpdate;
				assert: ( storedCivilization hasSameNameThan: updatedCivilization );
				assert: ( storedCivilization hasSameNameThan: civilizationToUpdate )
			]
]

{ #category : #tests }
CivilizationManagementSystemUserStoryTest >> test05CantUpdateACivilizationWhenAlreadyExistsAnotherOneWithTheSameName [

	| fireCivilization waterCivilization anotherWaterCivilization |

	fireCivilization := self fireCivilization.
	waterCivilization := self waterCivilization.

	self
		store: fireCivilization;
		store: waterCivilization.

	anotherWaterCivilization := self waterCivilization.

	self
		should: [ self update: fireCivilization with: anotherWaterCivilization ]
		raise: ConflictingObjectFound
		withMessageText: ( 'Something is in conflict with <1p>' expandMacrosWith: anotherWaterCivilization )
]

{ #category : #tests }
CivilizationManagementSystemUserStoryTest >> test06PurgingACivilization [

	| fireCivilization |

	fireCivilization := self fireCivilization.

	self assert: self allSingleCivilizations isEmpty.

	self store: fireCivilization.

	self
		withTheOnlyOneIn: self allSingleCivilizations
		do: [ :storedCivilization | self purge: storedCivilization ].

	self assert: self allSingleCivilizations isEmpty
]

{ #category : #tests }
CivilizationManagementSystemUserStoryTest >> test07CantPurgeANotManagedCivilization [

	| fireCivilization |

	fireCivilization := self fireCivilization.

	self assert: self allSingleCivilizations isEmpty.

	self
		should: [ self purge: fireCivilization ]
		raise: ObjectNotFound
		withMessageText: ( '<1p> was not found.' expandMacrosWith: fireCivilization ).

	self assert: self allSingleCivilizations isEmpty
]

{ #category : #'private - support' }
CivilizationManagementSystemUserStoryTest >> update: aCivilization with: anUpdatedCivilization [

	civilizationManagementSystem updateCivilization: aCivilization with: anUpdatedCivilization
]

{ #category : #'private - accessing' }
CivilizationManagementSystemUserStoryTest >> waterCivilization [

	^ SingleCivilization named: self waterCivilizationName
]

{ #category : #'private - accessing' }
CivilizationManagementSystemUserStoryTest >> waterCivilizationName [

	^ 'Water'
]

{ #category : #'private - support' }
CivilizationManagementSystemUserStoryTest >> withCivilizationNamed: aCivilizationName do: aBlock [

	civilizationManagementSystem
		withCivilizationNamed: aCivilizationName
		do: aBlock
		else: [ self fail ]
]
