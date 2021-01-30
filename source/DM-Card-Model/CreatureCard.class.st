Class {
	#name : #CreatureCard,
	#superclass : #Object,
	#instVars : [
		'name',
		'civilization',
		'race',
		'manaCost',
		'power',
		'manaNumberToProvide'
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

	^ AssertionCheckerBuilder new
		raising: InstanceCreationFailed;
		checking: [ :checker | 
			checker
				enforce: [ aPotentialPower amount isInteger ]
				because: 'A creature card''s power must be an integer.'
			];
		buildAndCheck
]

{ #category : #'private - preconditions' }
CreatureCard class >> assertNotEmpty: aPotentialName [

	AssertionChecker
		enforce: [ aPotentialName notEmpty ]
		because: 'A creature card must have a name.'
		raising: InstanceCreationFailed
]

{ #category : #'private - testing' }
CreatureCard class >> isGreaterThanOne: aPotentialManaCost [

	| oneMana |

	oneMana := aPotentialManaCost unit with: 1.
	^ ( ArithmeticCondition toBeGreaterOrEqualThan: oneMana ) isSatisfiedBy: aPotentialManaCost
]

{ #category : #'instance creation' }
CreatureCard class >> named: aName from: aCivilization and: aRace costing: aManaCost providing: aManaNumber with: aPower [

	self
		assertNotEmpty: aName;
		assertIsValidManaCost: aManaCost;
		assertIsValidManaNumber: aManaNumber;
		assertIsValidPower: aPower.

	^ self new
		initializeNamed: aName
		from: aCivilization
		and: aRace
		costing: aManaCost
		providing: aManaNumber
		with: aPower
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
CreatureCard >> initializeNamed: aName from: aCivilization and: aRace costing: aManaCost providing: aManaNumber with: aPower [

	name := aName.
	civilization := aCivilization.
	race := aRace.
	manaCost := aManaCost.
	manaNumberToProvide := aManaNumber.
	power := aPower
]

{ #category : #testing }
CreatureCard >> isFromTheCivilizationNamed: aPotentialCivilizationName [

	^ civilization isNamed: aPotentialCivilizationName
]

{ #category : #testing }
CreatureCard >> isFromTheRaceOfTypeNamed: aPotentialRaceTypeName [

	^ race isOfTypeNamed: aPotentialRaceTypeName
]

{ #category : #testing }
CreatureCard >> isNamed: aPotentialName [

	^ name = aPotentialName
]

{ #category : #testing }
CreatureCard >> provides: aPotentialManaNumber [

	^ manaNumberToProvide = aPotentialManaNumber
]
