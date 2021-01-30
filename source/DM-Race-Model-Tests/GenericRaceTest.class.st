"
A GenericRaceTest is a test class for testing the behavior of GenericRace
"
Class {
	#name : #GenericRaceTest,
	#superclass : #TestCase,
	#category : #'DM-Race-Model-Tests'
}

{ #category : #tests }
GenericRaceTest >> test01RaceTypeNameMustNotBeEmpty [

	self
		should: [ GenericRace ofTypeNamed: '' ]
		raise: InstanceCreationFailed
		withMessageText: 'A race must have a type name.'
]

{ #category : #tests }
GenericRaceTest >> test02UncategorizedGenericRace [

	| dragonRaceTypeName genericRace |

	dragonRaceTypeName := 'Dragon'.

	genericRace := GenericRace ofTypeNamed: dragonRaceTypeName.

	self
		assert: genericRace isGeneric;
		assert: ( genericRace isOfTypeNamed: dragonRaceTypeName )
]

{ #category : #tests }
GenericRaceTest >> test03GenericRaceCategorizedByASingleRace [

	| knightRaceTypeName knightmareRaceTypeName race genericRace |

	knightRaceTypeName := 'Knight'.
	knightmareRaceTypeName := 'Knightmare'.

	race := SingleRace ofTypeNamed: knightRaceTypeName.
	genericRace := GenericRace ofTypeNamed: knightmareRaceTypeName categorizedBy: race.

	self
		assert: ( genericRace isOfTypeNamed: knightmareRaceTypeName );
		assert: ( genericRace isOfTypeNamed: knightRaceTypeName )
]

{ #category : #tests }
GenericRaceTest >> test04GenericRaceCategorizedByAnotherGenericRace [

	| commandRaceTypeName commandDragonRaceTypeName race genericRace |

	commandRaceTypeName := 'Command'.
	commandDragonRaceTypeName := 'Command Dragon'.

	race := GenericRace ofTypeNamed: commandRaceTypeName.
	genericRace := GenericRace ofTypeNamed: commandDragonRaceTypeName categorizedBy: race.

	self
		assert: ( genericRace isOfTypeNamed: commandDragonRaceTypeName );
		assert: ( genericRace isOfTypeNamed: commandRaceTypeName )
]
