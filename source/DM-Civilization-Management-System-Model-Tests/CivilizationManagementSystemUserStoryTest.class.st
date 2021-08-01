Class {
	#name : #CivilizationManagementSystemUserStoryTest,
	#superclass : #PersistentSystemBasedUserStoryTest,
	#instVars : [
		'civilizationManagementSystem'
	],
	#category : #'DM-Civilization-Management-System-Model-Tests'
}

{ #category : #'private - querying' }
CivilizationManagementSystemUserStoryTest >> allCivilizations [

	^ civilizationManagementSystem allCivilizations
]

{ #category : #'private - system accessing' }
CivilizationManagementSystemUserStoryTest >> civilizationManagementSystem [

	^ rootSystem >> #CivilizationManagementSystemInterface
]

{ #category : #'private - accessing' }
CivilizationManagementSystemUserStoryTest >> fireCivilization [

	^ Civilization named: self fireCivilizationName
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
	civilizationManagementSystem := self civilizationManagementSystem
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

	self assert: self allCivilizations isEmpty.

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

	self assert: self allCivilizations isEmpty.

	self
		store: fireCivilization;
		store: waterCivilization.

	self assert: self allCivilizations size equals: 2.

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

	self assert: self allCivilizations isEmpty.

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

	self assert: self allCivilizations isEmpty.

	self store: civilizationToUpdate.
	self update: civilizationToUpdate with: updatedCivilization.

	self
		withTheOnlyOneIn: self allCivilizations
		do: [ :storedCivilization | 
			self
				assert: storedCivilization equals: civilizationToUpdate;
				assert: ( storedCivilization hasSameNameThan: updatedCivilization )
			]
]

{ #category : #tests }
CivilizationManagementSystemUserStoryTest >> test05CantUpdateANotManagedCivilization [

	| fireCivilization waterCivilization |

	fireCivilization := self fireCivilization.
	waterCivilization := self waterCivilization.

	self assert: self allCivilizations isEmpty.

	self
		should: [ self update: fireCivilization with: waterCivilization ]
		raise: ObjectNotFound
		withMessageText: ( '<1p> was not found.' expandMacrosWith: fireCivilization ).

	self assert: self allCivilizations isEmpty
]

{ #category : #tests }
CivilizationManagementSystemUserStoryTest >> test06CantUpdateACivilizationWhenAlreadyExistsAnotherOneWithTheSameName [

	| fireCivilization waterCivilization anotherWaterCivilization |

	fireCivilization := self fireCivilization.
	waterCivilization := self waterCivilization.

	self assert: self allCivilizations isEmpty.

	self
		store: fireCivilization;
		store: waterCivilization.

	anotherWaterCivilization := self waterCivilization.

	self
		should: [ self update: fireCivilization with: anotherWaterCivilization ]
		raise: ConflictingObjectFound
		withMessageText: ( 'Something is in conflict with <1p>' expandMacrosWith: anotherWaterCivilization ).

	self
		assert: self allCivilizations size equals: 2;
		withCivilizationNamed: self fireCivilizationName
			do: [ :storedCivilization | self assert: storedCivilization equals: fireCivilization ];
		withCivilizationNamed: self waterCivilizationName
			do: [ :storedCivilization | self assert: storedCivilization equals: waterCivilization ]
]

{ #category : #tests }
CivilizationManagementSystemUserStoryTest >> test07PurgingACivilization [

	| fireCivilization |

	fireCivilization := self fireCivilization.

	self assert: self allCivilizations isEmpty.

	self store: fireCivilization.

	self
		withTheOnlyOneIn: self allCivilizations
		do: [ :storedCivilization | self purge: storedCivilization ].

	self assert: self allCivilizations isEmpty
]

{ #category : #tests }
CivilizationManagementSystemUserStoryTest >> test08CantPurgeANotManagedCivilization [

	| fireCivilization |

	fireCivilization := self fireCivilization.

	self assert: self allCivilizations isEmpty.

	self
		should: [ self purge: fireCivilization ]
		raise: ObjectNotFound
		withMessageText: ( '<1p> was not found.' expandMacrosWith: fireCivilization ).

	self assert: self allCivilizations isEmpty
]

{ #category : #'private - support' }
CivilizationManagementSystemUserStoryTest >> update: aCivilization with: anUpdatedCivilization [

	civilizationManagementSystem updateCivilization: aCivilization with: anUpdatedCivilization
]

{ #category : #'private - accessing' }
CivilizationManagementSystemUserStoryTest >> waterCivilization [

	^ Civilization named: self waterCivilizationName
]

{ #category : #'private - accessing' }
CivilizationManagementSystemUserStoryTest >> waterCivilizationName [

	^ 'Water'
]

{ #category : #'private - querying' }
CivilizationManagementSystemUserStoryTest >> withCivilizationNamed: aCivilizationName do: aBlock [

	civilizationManagementSystem
		withCivilizationNamed: aCivilizationName
		do: aBlock
		else: [ self fail ]
]
