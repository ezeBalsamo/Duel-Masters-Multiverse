Class {
	#name : #CivilizationManagementSystemUserStoryTest,
	#superclass : #PersistentSystemBasedUserStoryTest,
	#instVars : [
		'civilizationManagementSystem'
	],
	#category : #'DM-Civilization-Management-System-Model-Tests'
}

{ #category : #'private - system accessing' }
CivilizationManagementSystemUserStoryTest >> civilizationManagementSystem [

	^ rootSystem >> #CivilizationManagementSystemInterface
]

{ #category : #'private - querying' }
CivilizationManagementSystemUserStoryTest >> civilizations [

	^ civilizationManagementSystem civilizations
]

{ #category : #'private - accessing' }
CivilizationManagementSystemUserStoryTest >> darknessCivilization [

	^ Civilization named: self darknessCivilizationName
]

{ #category : #'private - accessing' }
CivilizationManagementSystemUserStoryTest >> darknessCivilizationName [

	^ 'Darkness'
]

{ #category : #'private - accessing' }
CivilizationManagementSystemUserStoryTest >> fireCivilization [

	^ Civilization named: self fireCivilizationName
]

{ #category : #'private - accessing' }
CivilizationManagementSystemUserStoryTest >> fireCivilizationName [

	^ 'Fire'
]

{ #category : #'private - accessing' }
CivilizationManagementSystemUserStoryTest >> lightCivilization [

	^ Civilization named: self lightCivilizationName
]

{ #category : #'private - accessing' }
CivilizationManagementSystemUserStoryTest >> lightCivilizationName [

	^ 'Light'
]

{ #category : #'private - accessing' }
CivilizationManagementSystemUserStoryTest >> natureCivilization [

	^ Civilization named: self natureCivilizationName
]

{ #category : #'private - accessing' }
CivilizationManagementSystemUserStoryTest >> natureCivilizationName [

	^ 'Nature'
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

	self
		assert: self civilizations isEmpty;
		store: fireCivilization;
		assertTheOnlyOneIn: self civilizations is: fireCivilization
]

{ #category : #tests }
CivilizationManagementSystemUserStoryTest >> test02StoringManyCivilizations [

	| fireCivilization waterCivilization |

	fireCivilization := self fireCivilization.
	waterCivilization := self waterCivilization.

	self
		assert: self civilizations isEmpty;
		store: fireCivilization;
		store: waterCivilization.


	self
		assert: self civilizations size equals: 2;
		withCivilizationNamed: self fireCivilizationName
			do: [ :storedCivilization | self assert: fireCivilization equals: storedCivilization ];
		withCivilizationNamed: self waterCivilizationName
			do: [ :storedCivilization | self assert: waterCivilization equals: storedCivilization ]
]

{ #category : #tests }
CivilizationManagementSystemUserStoryTest >> test03CantStoreACivilizationWhenIsAlreadyStoreAnotherWithTheSameName [

	| fireCivilization anotherFireCivilization |

	fireCivilization := self fireCivilization.
	anotherFireCivilization := self fireCivilization.

	self
		assert: self civilizations isEmpty;
		store: fireCivilization;
		assertTheOnlyOneIn: self civilizations is: fireCivilization.

	self
		should: [ self store: anotherFireCivilization ]
		raise: ConflictingObjectFound
		withMessageText: ( 'Something is in conflict with <1p>' expandMacrosWith: anotherFireCivilization ).

	self assertTheOnlyOneIn: self civilizations is: fireCivilization
]

{ #category : #tests }
CivilizationManagementSystemUserStoryTest >> test04UpdatingACivilization [

	| civilizationToUpdate updatedCivilization |

	civilizationToUpdate := self fireCivilization.
	updatedCivilization := self waterCivilization.

	self assert: self civilizations isEmpty.

	self
		store: civilizationToUpdate;
		update: civilizationToUpdate with: updatedCivilization.

	self
		withTheOnlyOneIn: self civilizations
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

	self assert: self civilizations isEmpty.

	self
		should: [ self update: fireCivilization with: waterCivilization ]
		raise: ObjectNotFound
		withMessageText: ( '<1p> was not found.' expandMacrosWith: fireCivilization ).

	self assert: self civilizations isEmpty
]

{ #category : #tests }
CivilizationManagementSystemUserStoryTest >> test06CantUpdateACivilizationWhenAlreadyExistsAnotherOneWithTheSameName [

	| fireCivilization waterCivilization anotherWaterCivilization |

	fireCivilization := self fireCivilization.
	waterCivilization := self waterCivilization.

	self
		assert: self civilizations isEmpty;
		store: fireCivilization;
		store: waterCivilization.
		
	self
		assert: self civilizations size equals: 2;
		withCivilizationNamed: self fireCivilizationName
			do: [ :storedCivilization | self assert: storedCivilization equals: fireCivilization ];
		withCivilizationNamed: self waterCivilizationName
			do: [ :storedCivilization | self assert: storedCivilization equals: waterCivilization ].

	anotherWaterCivilization := self waterCivilization.

	self
		should: [ self update: fireCivilization with: anotherWaterCivilization ]
		raise: ConflictingObjectFound
		withMessageText: ( 'Something is in conflict with <1p>' expandMacrosWith: anotherWaterCivilization ).

	self
		assert: self civilizations size equals: 2;
		withCivilizationNamed: self fireCivilizationName
			do: [ :storedCivilization | self assert: storedCivilization equals: fireCivilization ];
		withCivilizationNamed: self waterCivilizationName
			do: [ :storedCivilization | self assert: storedCivilization equals: waterCivilization ]
]

{ #category : #tests }
CivilizationManagementSystemUserStoryTest >> test07PurgingACivilization [

	| fireCivilization |

	fireCivilization := self fireCivilization.

	self
		assert: self civilizations isEmpty;
		store: fireCivilization.

	self
		withTheOnlyOneIn: self civilizations
		do: [ :storedCivilization | self purge: storedCivilization ].

	self assert: self civilizations isEmpty
]

{ #category : #tests }
CivilizationManagementSystemUserStoryTest >> test08CantPurgeANotManagedCivilization [

	| fireCivilization |

	fireCivilization := self fireCivilization.

	self assert: self civilizations isEmpty.

	self
		should: [ self purge: fireCivilization ]
		raise: ObjectNotFound
		withMessageText: ( '<1p> was not found.' expandMacrosWith: fireCivilization ).

	self assert: self civilizations isEmpty
]

{ #category : #tests }
CivilizationManagementSystemUserStoryTest >> test09QueryingEachCivilization [

	| civilizations |

	civilizations := Array
		with: self fireCivilization
		with: self waterCivilization
		with: self natureCivilization
		with: self lightCivilization
		with: self darknessCivilization.

	self assert: self civilizations isEmpty.
	civilizations do: [ :aCivilization | self store: aCivilization ].

	self
		assertCollection: self civilizations hasSameElements: civilizations;
		assert: ( self civilizationManagementSystem fireCivilization isNamed: self fireCivilizationName );
		assert: ( self civilizationManagementSystem waterCivilization isNamed: self waterCivilizationName );
		assert: ( self civilizationManagementSystem natureCivilization isNamed: self natureCivilizationName );
		assert: ( self civilizationManagementSystem lightCivilization isNamed: self lightCivilizationName );
		assert: ( self civilizationManagementSystem darknessCivilization isNamed: self darknessCivilizationName )
]

{ #category : #tests }
CivilizationManagementSystemUserStoryTest >> test10CantQueryCivilizationWhenNotPreviouslyStored [

	self
		assert: self civilizations isEmpty;
		should: [ self civilizationManagementSystem civilizationNamed: self fireCivilizationName ]
			raise: ObjectNotFound
			withMessageText: 'There is no civilization named Fire.'
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
