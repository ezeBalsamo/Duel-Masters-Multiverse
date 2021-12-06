Class {
	#name : #CreatureSummonAssertion,
	#superclass : #Object,
	#instVars : [
		'match'
	],
	#category : #'DM-Match-Model'
}

{ #category : #'instance creation' }
CreatureSummonAssertion class >> workingWith: aMatch [

	^ self new initializeWorkingWith: aMatch
]

{ #category : #'private - asserting' }
CreatureSummonAssertion >> assert: aCard belongsToManaOf: aPlayer [

	match
		signalIllegalPlayFrom: aPlayer
		because: [ 'You can''t tap <1p> because it isn''t in your mana zone.' expandMacrosWith: aCard ]
		unless: ( match does: aCard belongToManaOf: aPlayer )
]

{ #category : #'private - asserting' }
CreatureSummonAssertion >> assert: aCard belongsToUntappedManaOf: aPlayer [

	match
		signalIllegalPlayFrom: aPlayer
		because: [ 'You can''t tap <1p> because it is already tapped.' expandMacrosWith: aCard ]
		unless: ( match does: aCard belongToUntappedManaOf: aPlayer )
]

{ #category : #'private - asserting' }
CreatureSummonAssertion >> assertCardsIn: aCardCollection belongToUntappedManaOf: aPlayer [

	match
		signalIllegalPlayFrom: aPlayer
		because: 'You can''t Summon a creature without tapping mana.'
		unless: aCardCollection notEmpty.

	aCardCollection
		do: [ :aCard | 
			self
				assert: aCard belongsToManaOf: aPlayer;
				assert: aCard belongsToUntappedManaOf: aPlayer
			]
]

{ #category : #'private - asserting' }
CreatureSummonAssertion >> assertCivilizationOf: aCreatureCard isIncludedInCivilizationsOfAll: aCardCollection from: aPlayer [

	| creatureCivilizations |

	creatureCivilizations := aCreatureCard civilizations.

	match
		signalIllegalPlayFrom: aPlayer
		because: [ 'You don''t have <1s> mana to summon <2p>.'
				expandMacrosWith: ( ( CollectionFormatter separatingWith: ', ' andLastWith: ' and ' ) format: creatureCivilizations )
				with: aCreatureCard
			]
		unless: ( ( self civilizationsIn: aCardCollection ) includesAll: creatureCivilizations )
]

{ #category : #'private - preconditions' }
CreatureSummonAssertion >> assertIsTurnOf: aPlayer [

	match ifIsNotTurnOf: aPlayer warnThat: 'You can''t summon creatures on your opponent''s turn.'
]

{ #category : #'private - asserting' }
CreatureSummonAssertion >> assertManaCostOf: aCreatureCard isLessThanOrEqualToThatOfAll: aCardCollection from: aPlayer [

	match
		signalIllegalPlayFrom: aPlayer
		because: [ 'You have to tap cards whose sum of mana number equals the mana cost of <1p>.'
				expandMacrosWith: aCreatureCard
			]
		unless: aCreatureCard manaCost = ( self manaNumberToProvideByAll: aCardCollection )
]

{ #category : #'private - accessing' }
CreatureSummonAssertion >> civilizationsIn: aCardCollection [

	^ aCardCollection flatCollect: #civilizations as: Set
]

{ #category : #initialization }
CreatureSummonAssertion >> initializeWorkingWith: aMatch [

	match := aMatch
]

{ #category : #'private - accessing' }
CreatureSummonAssertion >> manaNumberToProvideByAll: aCardCollection [

	^ aCardCollection
		inject: self zeroMana
		into: [ :totalNumberOfMana :aCard | totalNumberOfMana + aCard manaNumberToProvide ]
]

{ #category : #validating }
CreatureSummonAssertion >> validateSummoningOf: aCreatureCard from: aPlayer tappingAll: aCardCollection [

	self
		assertIsTurnOf: aPlayer;
		assertCardsIn: aCardCollection belongToUntappedManaOf: aPlayer;
		assertManaCostOf: aCreatureCard isLessThanOrEqualToThatOfAll: aCardCollection from: aPlayer;
		assertCivilizationOf: aCreatureCard isIncludedInCivilizationsOfAll: aCardCollection from: aPlayer
]

{ #category : #'private - accessing' }
CreatureSummonAssertion >> zeroMana [

	^ DMUnits mana nullMeasure
]
