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

	^ self mana with: 2
]

{ #category : #'private - accessing' }
CreatureCardTest >> defaultManaNumber [

	^ self mana with: 1
]

{ #category : #'private - accessing' }
CreatureCardTest >> defaultPower [

	^ self power with: 2000
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

{ #category : #'private - accessing' }
CreatureCardTest >> mana [

	^ BaseUnit named: 'mana'
]

{ #category : #'private - accessing' }
CreatureCardTest >> power [

	^ BaseUnit named: 'power'
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
CreatureCardTest >> test02CreatureCardManaCostMustBeAnInteger [

	self
		should: [ CreatureCard
				named: self defaultCardName
				from: self defaultCivilization
				ofType: self defaultRace
				costing: ( self mana with: 3.4 )
				providing: self defaultManaNumber
				with: self defaultPower
			]
		raise: InstanceCreationFailed
		withMessageText: 'A creature card''s mana cost must be an integer.'
]

{ #category : #tests }
CreatureCardTest >> test03CreatureCardManaCostMustBeGreaterOrEqualThanOne [

	self
		should: [ CreatureCard
				named: self defaultCardName
				from: self defaultCivilization
				ofType: self defaultRace
				costing: ( self mana with: -2 )
				providing: self defaultManaNumber
				with: self defaultPower
			]
		raise: InstanceCreationFailed
		withMessageText: 'A creature card''s mana cost must be greater or equal than one.'
]

{ #category : #tests }
CreatureCardTest >> test04CreatureCardManaNumberMustBeAnInteger [

	self
		should: [ CreatureCard
				named: self defaultCardName
				from: self defaultCivilization
				ofType: self defaultRace
				costing: self defaultManaCost
				providing: ( self mana with: 3.4 )
				with: self defaultPower
			]
		raise: InstanceCreationFailed
		withMessageText: 'A creature card''s mana number must be an integer.'
]

{ #category : #tests }
CreatureCardTest >> test05CreatureCardManaNumberMustBePositive [

	self
		should: [ CreatureCard
				named: self defaultCardName
				from: self defaultCivilization
				ofType: self defaultRace
				costing: self defaultManaCost
				providing: ( self mana with: -2 )
				with: self defaultPower
			]
		raise: InstanceCreationFailed
		withMessageText: 'A creature card''s mana number must be positive.'
]

{ #category : #tests }
CreatureCardTest >> test06CreatureCardPowerMustBeAnInteger [

	self
		should: [ CreatureCard
				named: self defaultCardName
				from: self defaultCivilization
				ofType: self defaultRace
				costing: self defaultManaCost
				providing: self defaultManaNumber
				with: ( self power with: 3.4 )
			]
		raise: InstanceCreationFailed
		withMessageText: 'A creature card''s power must be an integer.'
]

{ #category : #tests }
CreatureCardTest >> test07CreatureCardWithoutEffect [

	| creatureName twoManas oneMana twoThousandsPower creatureCard |

	creatureName := 'Immortal Baron, Vorg'.
	twoManas := self mana with: 2.
	oneMana := self mana with: 1.
	twoThousandsPower := self power with: 2000.

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
