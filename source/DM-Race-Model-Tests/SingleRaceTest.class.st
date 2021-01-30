"
A RaceTest is a test class for testing the behavior of Race
"
Class {
	#name : #SingleRaceTest,
	#superclass : #TestCase,
	#category : #'DM-Race-Model-Tests'
}

{ #category : #tests }
SingleRaceTest >> test01RaceTypeNameMustNotBeEmpty [

	self
		should: [ SingleRace ofTypeNamed: '' ]
		raise: InstanceCreationFailed
		withMessageText: 'A race must have a type name.'
]

{ #category : #tests }
SingleRaceTest >> test02UncategorizedRace [

	| race alienRaceTypeName armorloidRaceTypeName |

	alienRaceTypeName := 'Alien'.
	armorloidRaceTypeName := 'Armorloid'.

	race := SingleRace ofTypeNamed: alienRaceTypeName.

	self
		deny: race isGeneric;
		assert: ( race isOfTypeNamed: alienRaceTypeName );
		deny: ( race isOfTypeNamed: armorloidRaceTypeName )
]

{ #category : #tests }
SingleRaceTest >> test03RaceCategorizedByAnotherSingleRace [

	| gransectRaceTypeName gransectHazardRaceTypeName race subRace |

	gransectRaceTypeName := 'Gransect'.
	gransectHazardRaceTypeName := 'Gransect Hazard'.

	race := SingleRace ofTypeNamed: gransectRaceTypeName.
	subRace := SingleRace ofTypeNamed: gransectHazardRaceTypeName categorizedBy: race.

	self
		assert: ( subRace isOfTypeNamed: gransectHazardRaceTypeName );
		assert: ( subRace isOfTypeNamed: gransectRaceTypeName )
]

{ #category : #tests }
SingleRaceTest >> test04RaceCategorizedByAGenericRace [

	| dragonRaceTypeName angelDragonRaceTypeName genericRace subRace |

	dragonRaceTypeName := 'Dragon'.
	angelDragonRaceTypeName := 'Angel Dragon'.

	genericRace := GenericRace ofTypeNamed: dragonRaceTypeName.
	subRace := SingleRace ofTypeNamed: angelDragonRaceTypeName categorizedBy: genericRace.

	self
		assert: ( subRace isOfTypeNamed: angelDragonRaceTypeName );
		assert: ( subRace isOfTypeNamed: dragonRaceTypeName )
]

{ #category : #tests }
SingleRaceTest >> test05RaceCategorizedByTwoGenericRaces [

	| dragonRaceTypeName commandRaceTypeName commandDragonRaceTypeName dragonRace commandRace commandDragonRace |

	dragonRaceTypeName := 'Dragon'.
	commandRaceTypeName := 'Command'.
	commandDragonRaceTypeName := 'Command Dragon'.

	dragonRace := GenericRace ofTypeNamed: dragonRaceTypeName.
	commandRace := GenericRace ofTypeNamed: commandRaceTypeName.

	commandDragonRace := SingleRace
		ofTypeNamed: commandDragonRaceTypeName
		categorizedByAll: ( Array with: dragonRace with: commandRace ).

	self
		assert: ( commandDragonRace isOfTypeNamed: commandRaceTypeName );
		assert: ( commandDragonRace isOfTypeNamed: commandDragonRaceTypeName );
		assert: ( commandDragonRace isOfTypeNamed: dragonRaceTypeName )
]

{ #category : #tests }
SingleRaceTest >> test06RaceCategorizedByAGenericRaceAndASingleRace [

	| dragonRaceTypeName funkyKnightmareRaceTypeName funkyKnightmareDragonRaceTypeName dragonRace funkyKnightmareRace funkyKnightmareDragonRace |

	dragonRaceTypeName := 'Dragon'.
	funkyKnightmareRaceTypeName := 'Funky Knightmare'.
	funkyKnightmareDragonRaceTypeName := 'Funky Knightmare Dragon'.

	dragonRace := GenericRace ofTypeNamed: dragonRaceTypeName.
	funkyKnightmareRace := SingleRace ofTypeNamed: funkyKnightmareRaceTypeName.

	funkyKnightmareDragonRace := SingleRace
		ofTypeNamed: funkyKnightmareDragonRaceTypeName
		categorizedByAll: ( Array with: dragonRace with: funkyKnightmareRace ).

	self
		assert: ( funkyKnightmareDragonRace isOfTypeNamed: funkyKnightmareDragonRaceTypeName );
		assert: ( funkyKnightmareDragonRace isOfTypeNamed: funkyKnightmareRaceTypeName );
		assert: ( funkyKnightmareDragonRace isOfTypeNamed: dragonRaceTypeName )
]
