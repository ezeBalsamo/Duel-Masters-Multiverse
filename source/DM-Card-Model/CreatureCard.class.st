Class {
	#name : #CreatureCard,
	#superclass : #Object,
	#instVars : [
		'name',
		'race',
		'manaCost',
		'power',
		'manaNumberToProvide',
		'civilizations'
	],
	#category : #'DM-Card-Model'
}

{ #category : #'private - preconditions' }
CreatureCard class >> assertIsValidManaCost: aPotentialManaCost [

	AssertionCheckerBuilder new
		raising: InstanceCreationFailed;
		checking: [ :asserter | 
			asserter
				enforce: [ aPotentialManaCost amount isInteger ]
					because: 'A creature card''s mana cost must be an integer.';
				enforce: [ self isGreaterThanOne: aPotentialManaCost ]
					because: 'A creature card''s mana cost must be greater or equal than one.'
			];
		buildAndCheck
]

{ #category : #'private - preconditions' }
CreatureCard class >> assertIsValidManaNumber: aPotentialManaNumber [

	AssertionCheckerBuilder new
		raising: InstanceCreationFailed;
		checking: [ :asserter | 
			asserter
				enforce: [ aPotentialManaNumber amount isInteger ]
					because: 'A creature card''s mana number must be an integer.';
				enforce: [ aPotentialManaNumber positive ]
					because: 'A creature card''s mana number must be positive.'
			];
		buildAndCheck
]

{ #category : #'private - preconditions' }
CreatureCard class >> assertIsValidPower: aPotentialPower [

	AssertionChecker
		enforce: [ aPotentialPower amount isInteger ]
		because: 'A creature card''s power must be an integer.'
		raising: InstanceCreationFailed
]

{ #category : #'private - preconditions' }
CreatureCard class >> assertNotEmpty: aPotentialName [

	AssertionChecker
		enforce: [ aPotentialName notEmpty ]
		because: 'A creature card must have a name.'
		raising: InstanceCreationFailed
]

{ #category : #'private - preconditions' }
CreatureCard class >> assertThereAreCivilizationsIn: aPotentialCivilizationCollection [

	AssertionChecker
		enforce: [ aPotentialCivilizationCollection notEmpty ]
		because: 'A creature must have at least one civilization.'
		raising: InstanceCreationFailed
]

{ #category : #'private - testing' }
CreatureCard class >> isGreaterThanOne: aPotentialManaCost [

	| oneMana |

	oneMana := aPotentialManaCost unit with: 1.
	^ ( ArithmeticCondition toBeGreaterOrEqualThan: oneMana ) isSatisfiedBy: aPotentialManaCost
]

{ #category : #'instance creation' }
CreatureCard class >> named: aName from: aCivilization ofType: aRace costing: aManaCost providing: aManaNumber with: aPower [

	^ self
		named: aName
		fromAll: {aCivilization}
		ofType: aRace
		costing: aManaCost
		providing: aManaNumber
		with: aPower
]

{ #category : #'instance creation' }
CreatureCard class >> named: aName fromAll: aCivilizationCollection ofType: aRace costing: aManaCost providing: aManaNumber with: aPower [

	self
		assertNotEmpty: aName;
		assertThereAreCivilizationsIn: aCivilizationCollection;
		assertIsValidManaCost: aManaCost;
		assertIsValidManaNumber: aManaNumber;
		assertIsValidPower: aPower.

	^ self new
		initializeNamed: aName
		fromAll: aCivilizationCollection
		ofType: aRace
		costing: aManaCost
		providing: aManaNumber
		with: aPower
]

{ #category : #accessing }
CreatureCard >> civilizations [

	^ civilizations
]

{ #category : #testing }
CreatureCard >> costs: aPotentialManaNumber [

	^ manaCost = aPotentialManaNumber
]

{ #category : #testing }
CreatureCard >> hasPowerEquivalentTo: aPotentialPower [

	^ power = aPotentialPower
]

{ #category : #initialization }
CreatureCard >> initializeNamed: aName fromAll: aCivilizationCollection ofType: aRace costing: aManaCost providing: aManaNumber with: aPower [

	name := aName.
	civilizations := aCivilizationCollection.
	race := aRace.
	manaCost := aManaCost.
	manaNumberToProvide := aManaNumber.
	power := aPower
]

{ #category : #testing }
CreatureCard >> isFromTheCivilizationNamed: aPotentialCivilizationName [

	^ civilizations anySatisfy: [ :aCivilization | aCivilization isNamed: aPotentialCivilizationName ]
]

{ #category : #testing }
CreatureCard >> isFromTheRaceOfTypeNamed: aPotentialRaceTypeName [

	^ race isOfTypeNamed: aPotentialRaceTypeName
]

{ #category : #testing }
CreatureCard >> isNamed: aPotentialName [

	^ name = aPotentialName
]

{ #category : #accessing }
CreatureCard >> manaCost [

	^ manaCost
]

{ #category : #accessing }
CreatureCard >> manaNumberToProvide [

	^ manaNumberToProvide
]

{ #category : #accessing }
CreatureCard >> printOn: aStream [

	^ aStream nextPutAll: name
]

{ #category : #testing }
CreatureCard >> provides: aPotentialManaNumber [

	^ manaNumberToProvide = aPotentialManaNumber
]
