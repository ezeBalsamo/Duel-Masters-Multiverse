"
A CreatureCardTest is a test class for testing the behavior of CreatureCard
"
Class {
	#name : #CreatureCardTest,
	#superclass : #TestCase,
	#category : #'DM-Card-Model-Tests'
}

{ #category : #'private - accessing' }
CreatureCardTest >> defaultCardName [

	^ 'Immortal Baron, Vorg'
]

{ #category : #'private - accessing' }
CreatureCardTest >> defaultCivilization [

	^ self fireCivilization
]

{ #category : #'private - accessing' }
CreatureCardTest >> defaultManaCost [

	^ DMUnits mana with: 2
]

{ #category : #'private - accessing' }
CreatureCardTest >> defaultManaNumber [

	^ DMUnits mana with: 1
]

{ #category : #'private - accessing' }
CreatureCardTest >> defaultPower [

	^ DMUnits power with: 2000
]

{ #category : #'private - accessing' }
CreatureCardTest >> defaultRace [

	^ self human
]

{ #category : #'private - accessing' }
CreatureCardTest >> fireCivilization [

	^ Civilization named: self fireCivilizationName
]

{ #category : #'private - accessing' }
CreatureCardTest >> fireCivilizationName [

	^ 'Fire'
]

{ #category : #'private - accessing' }
CreatureCardTest >> human [

	^ SingleRace ofTypeNamed: self humanRaceTypeName
]

{ #category : #'private - accessing' }
CreatureCardTest >> humanRaceTypeName [

	^ 'Human'
]

{ #category : #tests }
CreatureCardTest >> test01CreatureCardNameMustNotBeEmpty [

	self
		should: [ CreatureCard
				named: ''
				from: self defaultCivilization
				ofType: self defaultRace
				costing: self defaultManaCost
				providing: self defaultManaNumber
				with: self defaultPower
			]
		raise: InstanceCreationFailed
		withMessageText: 'A creature card must have a name.'
]

{ #category : #tests }
CreatureCardTest >> test02CreatureCardCivilizationsMustNotBeEmpty [

	self
		should: [ CreatureCard
				named: self defaultCardName
				fromAll: #()
				ofType: self defaultRace
				costing: self defaultManaCost
				providing: self defaultManaNumber
				with: self defaultPower
			]
		raise: InstanceCreationFailed
		withMessageText: 'A creature card must have at least one civilization.'
]

{ #category : #tests }
CreatureCardTest >> test03CreatureCardManaCostMustBeAnInteger [

	self
		should: [ CreatureCard
				named: self defaultCardName
				from: self defaultCivilization
				ofType: self defaultRace
				costing: ( DMUnits mana with: 3.4 )
				providing: self defaultManaNumber
				with: self defaultPower
			]
		raise: InstanceCreationFailed
		withMessageText: 'A creature card''s mana cost must be an integer.'
]

{ #category : #tests }
CreatureCardTest >> test04CreatureCardManaCostMustBeGreaterOrEqualThanOne [

	self
		should: [ CreatureCard
				named: self defaultCardName
				from: self defaultCivilization
				ofType: self defaultRace
				costing: ( DMUnits mana with: -2 )
				providing: self defaultManaNumber
				with: self defaultPower
			]
		raise: InstanceCreationFailed
		withMessageText: 'A creature card''s mana cost must be greater or equal than one.'
]

{ #category : #tests }
CreatureCardTest >> test05CreatureCardManaNumberMustBeAnInteger [

	self
		should: [ CreatureCard
				named: self defaultCardName
				from: self defaultCivilization
				ofType: self defaultRace
				costing: self defaultManaCost
				providing: ( DMUnits mana with: 3.4 )
				with: self defaultPower
			]
		raise: InstanceCreationFailed
		withMessageText: 'A creature card''s mana number must be an integer.'
]

{ #category : #tests }
CreatureCardTest >> test06CreatureCardManaNumberMustBePositive [

	self
		should: [ CreatureCard
				named: self defaultCardName
				from: self defaultCivilization
				ofType: self defaultRace
				costing: self defaultManaCost
				providing: ( DMUnits mana with: -2 )
				with: self defaultPower
			]
		raise: InstanceCreationFailed
		withMessageText: 'A creature card''s mana number must be positive.'
]

{ #category : #tests }
CreatureCardTest >> test07CreatureCardPowerMustBeAnInteger [

	self
		should: [ CreatureCard
				named: self defaultCardName
				from: self defaultCivilization
				ofType: self defaultRace
				costing: self defaultManaCost
				providing: self defaultManaNumber
				with: ( DMUnits power with: 3.4 )
			]
		raise: InstanceCreationFailed
		withMessageText: 'A creature card''s power must be an integer.'
]

{ #category : #tests }
CreatureCardTest >> test08CreatureCardWithoutEffect [

	| creatureName twoManas oneMana twoThousandsPower creatureCard |

	creatureName := 'Immortal Baron, Vorg'.
	twoManas := DMUnits mana with: 2.
	oneMana := DMUnits mana with: 1.
	twoThousandsPower := DMUnits power with: 2000.

	creatureCard := CreatureCard
		named: creatureName
		from: self fireCivilization
		ofType: self human
		costing: twoManas
		providing: oneMana
		with: twoThousandsPower.

	self
		assert: ( creatureCard isNamed: creatureName );
		assert: ( creatureCard isFromTheCivilizationNamed: self fireCivilizationName );
		assert: ( creatureCard isFromTheRaceOfTypeNamed: self humanRaceTypeName );
		assert: ( creatureCard costs: twoManas );
		assert: ( creatureCard provides: oneMana );
		assert: ( creatureCard hasPowerEquivalentTo: twoThousandsPower )
]

{ #category : #tests }
CreatureCardTest >> test09MultipleCivilizationCreatureCard [

	| creatureCard |

	creatureCard := CreatureCard
		named: self defaultCardName
		fromAll: ( Array with: self fireCivilization with: self waterCivilization )
		ofType: self defaultRace
		costing: self defaultManaCost
		providing: self defaultManaNumber
		with: self defaultPower.

	self
		assert: ( creatureCard isFromTheCivilizationNamed: self fireCivilizationName );
		assert: ( creatureCard isFromTheCivilizationNamed: self waterCivilizationName )
]

{ #category : #'private - accessing' }
CreatureCardTest >> waterCivilization [

	^ Civilization named: self waterCivilizationName
]

{ #category : #'private - accessing' }
CreatureCardTest >> waterCivilizationName [

	^ 'Water'
]
