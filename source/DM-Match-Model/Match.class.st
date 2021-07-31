Class {
	#name : #Match,
	#superclass : #Object,
	#instVars : [
		'firstPlayer',
		'secondPlayer',
		'cardsInHandByPlayer',
		'shieldsByPlayer',
		'playersTurn',
		'canManaBeCharged',
		'canCardBeDrawn',
		'creaturesSummonedByPlayer',
		'manaByPlayer',
		'tappedManaByPlayer',
		'hasFirstTurnEnded'
	],
	#category : #'DM-Match-Model'
}

{ #category : #'instance creation' }
Match class >> between: aPlayer and: anotherPlayer [

	^ self new initializeBetween: aPlayer and: anotherPlayer
]

{ #category : #'private - preconditions' }
Match >> assert: aCard belongsToManaOf: aPotentialPlayer [

	self
		signalIllegalPlayFrom: aPotentialPlayer
		because: 'You can''t tap March because it isn''t in your mana zone.'
		unless: ( ( self manaOf: aPotentialPlayer ) includes: aCard )
]

{ #category : #'private - preconditions' }
Match >> assertCardHasNotBeenDrawnYet [

	self
		signalIllegalPlayFrom: self currentPlayer
		because: 'Only one card can be drawn per turn.'
		unless: canCardBeDrawn
]

{ #category : #'private - preconditions' }
Match >> assertCivilizationOf: aCreatureCard isIncludedInCivilizationsOfManaOf: aPotentialPlayer [

	self
		signalIllegalPlayFrom: aPotentialPlayer
		because:
			( 'You don''t have mana from <1p> to summon <2p>.'
				expandMacrosWith: aCreatureCard civilization
				with: aCreatureCard )
		unless: ( ( self civilizationsOfManaOf: aPotentialPlayer ) includes: aCreatureCard civilization )
]

{ #category : #'private - preconditions' }
Match >> assertIsNotFirstTurn [

	self
		signalIllegalPlayFrom: self currentPlayer
		because: 'You can''t draw card in your first turn.'
		unless: hasFirstTurnEnded
]

{ #category : #'private - preconditions' }
Match >> assertIsUntapped: aCard of: aPotentialPlayer [

	self
		signalIllegalPlayFrom: aPotentialPlayer
		because: 'You can''t tap March because it is already tapped.'
		unless: ( ( self untappedManaOf: aPotentialPlayer ) includes: aCard )
]

{ #category : #'private - preconditions' }
Match >> assertIsValidPlayer: aPotentialPlayer [

	^ [ self signalIsNotValidPlayer: aPotentialPlayer ]
		unless: ( playersTurn includes: aPotentialPlayer )
]

{ #category : #'private - preconditions' }
Match >> assertManaCostOf: aCreatureCard isLowerOrEqualThanNumberOfManaOf: aPotentialPlayer [

	self
		signalIllegalPlayFrom: aPotentialPlayer
		because: ( 'You don''t have enough mana to summon <1p>.' expandMacrosWith: aCreatureCard )
		unless: aCreatureCard manaCost <= ( self numberOfManaOf: aPotentialPlayer )
]

{ #category : #'private - preconditions' }
Match >> assertManaHasNotBeenChargedYet [

	self
		signalIllegalPlayFrom: self currentPlayer
		because: 'Mana can only be charged once per turn.'
		unless: canManaBeCharged
]

{ #category : #testing }
Match >> canBeSummoned: aCreatureCard of: aPotentialPlayer [

	^ aCreatureCard manaCost <= ( self numberOfUntappedManaOf: aPotentialPlayer )
		and: [ ( self civilizationsOfUntappedManaOf: aPotentialPlayer ) includes: aCreatureCard civilization ]
]

{ #category : #'private - accessing' }
Match >> cardsInHandOf: aPotentialPlayer [

	^ cardsInHandByPlayer
		at: aPotentialPlayer
		ifAbsent: [ self signalIsNotValidPlayer: aPotentialPlayer ]
]

{ #category : #accessing }
Match >> cardsInHandOf: aPotentialPlayer requestedBy: aPetitioner [

	^ self
		signalIllegalPlayFrom: aPetitioner
			because: 'You can''t see the cards in your opponent''s hand.'
			unless: aPotentialPlayer = aPetitioner;
		cardsInHandOf: aPotentialPlayer
]

{ #category : #processing }
Match >> chargeManaOf: aPotentialPlayer with: aCard [

	self
		ifIsNotTurnOf: aPotentialPlayer warnThat: 'You can''t charge mana on your opponent''s turn.';
		assertManaHasNotBeenChargedYet.

	( self manaOf: aPotentialPlayer ) add: aCard.
	canManaBeCharged := false
]

{ #category : #'private - accessing' }
Match >> civilizationsIn: aCardCollection [

	^ aCardCollection collect: [ :aCard | aCard civilization ] as: Set
]

{ #category : #'private - accessing' }
Match >> civilizationsOfManaOf: aPotentialPlayer [

	^ self civilizationsIn: ( self manaOf: aPotentialPlayer )
]

{ #category : #'private - accessing' }
Match >> civilizationsOfUntappedManaOf: aPotentialPlayer [

	^ self civilizationsIn: ( self untappedManaOf: aPotentialPlayer )
]

{ #category : #accessing }
Match >> creaturesSummonedOf: aPlayer [

	^ creaturesSummonedByPlayer at: aPlayer
]

{ #category : #'private - accessing' }
Match >> currentPlayer [

	^ playersTurn current
]

{ #category : #processing }
Match >> drawCardFor: aPotentialPlayer [

	self
		ifIsNotTurnOf: aPotentialPlayer warnThat: 'You can''t draw a card on your opponent''s turn.';
		assertIsNotFirstTurn;
		assertCardHasNotBeenDrawnYet.

	( self cardsInHandOf: aPotentialPlayer ) add: 'bla-bla'.
	canCardBeDrawn := false
]

{ #category : #processing }
Match >> endTurnOf: aPotentialPlayer [

	self ifIsNotTurnOf: aPotentialPlayer warnThat: 'You can''t end your opponent''s turn.'.

	canManaBeCharged := true.
	canCardBeDrawn := true.
	hasFirstTurnEnded
		ifFalse: [ hasFirstTurnEnded := true ].
	playersTurn next
]

{ #category : #'private - preconditions' }
Match >> ifIsNotTurnOf: aPotentialPlayer warnThat: anErrorDescription [

	self
		signalIllegalPlayFrom: aPotentialPlayer
		because: anErrorDescription
		unless: ( self isTurnOf: aPotentialPlayer )
]

{ #category : #initialization }
Match >> initializeBetween: aFirstPlayer and: aSecondPlayer [

	playersTurn := CircularIterator cyclingOver: ( Array with: aFirstPlayer with: aSecondPlayer ).
	firstPlayer := aFirstPlayer.
	secondPlayer := aSecondPlayer.
	canManaBeCharged := true.
	canCardBeDrawn := false.
	hasFirstTurnEnded := false.

	self
		initializeCardsInHandByPlayer;
		initializeShieldsByPlayer;
		initializeManaByPlayer;
		initializeCreaturesSummonedByPlayer
]

{ #category : #initialization }
Match >> initializeCardsInHandByPlayer [

	cardsInHandByPlayer := Dictionary
		with:
			firstPlayer
				->
					( OrderedCollection
						with: 'bla'
						with: 'ble'
						with: 'bli'
						with: 'blo'
						with: 'blu' )
		with:
			secondPlayer
				->
					( OrderedCollection
						with: 'blah'
						with: 'bleh'
						with: 'blih'
						with: 'bloh'
						with: 'bluh' )
]

{ #category : #initialization }
Match >> initializeCreaturesSummonedByPlayer [

	creaturesSummonedByPlayer := Dictionary
		with: firstPlayer -> OrderedCollection new
		with: secondPlayer -> OrderedCollection new
]

{ #category : #initialization }
Match >> initializeManaByPlayer [

	manaByPlayer := Dictionary
		with: firstPlayer -> OrderedCollection new
		with: secondPlayer -> OrderedCollection new.

	tappedManaByPlayer := Dictionary
		with: firstPlayer -> OrderedCollection new
		with: secondPlayer -> OrderedCollection new
]

{ #category : #initialization }
Match >> initializeShieldsByPlayer [

	shieldsByPlayer := Dictionary
		with:
			firstPlayer
				->
					( OrderedCollection
						with: 'bla'
						with: 'ble'
						with: 'bli'
						with: 'blo'
						with: 'blu' )
		with:
			secondPlayer
				->
					( OrderedCollection
						with: 'blah'
						with: 'bleh'
						with: 'blih'
						with: 'bloh'
						with: 'bluh' )
]

{ #category : #testing }
Match >> isTurnOf: aPotentialPlayer [

	self assertIsValidPlayer: aPotentialPlayer.
	^ self currentPlayer = aPotentialPlayer
]

{ #category : #'private - accessing' }
Match >> mana [

	^ BaseUnit named: 'mana'
]

{ #category : #'private - accessing' }
Match >> manaNumberToProvideIn: aCardCollection [

	^ aCardCollection
		inject: self zeroMana
		into: [ :totalNumberOfMana :aCard | totalNumberOfMana + aCard manaNumberToProvide ]
]

{ #category : #accessing }
Match >> manaOf: aPotentialPlayer [

	^ manaByPlayer
		at: aPotentialPlayer
		ifAbsent: [ self signalIsNotValidPlayer: aPotentialPlayer ]
]

{ #category : #'private - accessing' }
Match >> numberOfManaOf: aPotentialPlayer [

	^ self manaNumberToProvideIn: ( self manaOf: aPotentialPlayer )
]

{ #category : #'private - accessing' }
Match >> numberOfUntappedManaOf: aPotentialPlayer [

	^ self manaNumberToProvideIn: ( self untappedManaOf: aPotentialPlayer )
]

{ #category : #accessing }
Match >> shieldsOf: aPotentialPlayer [

	^ shieldsByPlayer at: aPotentialPlayer ifAbsent: [ self signalIsNotValidPlayer: aPotentialPlayer ]
]

{ #category : #'private - preconditions' }
Match >> signalIllegalPlayFrom: aPotentialPlayer because: anErrorDescription unless: aConditionToBeSatisfied [

	[ IllegalPlay from: aPotentialPlayer because: anErrorDescription ] unless: aConditionToBeSatisfied
]

{ #category : #'private - signaling' }
Match >> signalIsNotValidPlayer: aNotValidPlayer [

	Error signal: ( '<1s> is not a valid player in this match.' expandMacrosWith: aNotValidPlayer )
]

{ #category : #processing }
Match >> summon: aCreatureCard of: aPotentialPlayer tappingAll: aCardCollection [

	aCardCollection
		do: [ :aCard | self validate: aCard canBeUsedForSummoningCreatureOf: aPotentialPlayer ].
	self validateCanBeSummoned: aCreatureCard of: aPotentialPlayer.

	( self creaturesSummonedOf: aPotentialPlayer ) add: aCreatureCard.
	( self tappedManaOf: aPotentialPlayer ) addAll: aCardCollection
]

{ #category : #accessing }
Match >> tappedManaOf: aPotentialPlayer [

	^ tappedManaByPlayer
		at: aPotentialPlayer
		ifAbsent: [ self signalIsNotValidPlayer: aPotentialPlayer ]
]

{ #category : #'private - accessing' }
Match >> untappedManaOf: aPotentialPlayer [

	^ ( self manaOf: aPotentialPlayer ) difference: ( self tappedManaOf: aPotentialPlayer )
]

{ #category : #'private - preconditions' }
Match >> validate: aCard canBeUsedForSummoningCreatureOf: aPotentialPlayer [

	self
		assert: aCard belongsToManaOf: aPotentialPlayer;
		assertIsUntapped: aCard of: aPotentialPlayer
]

{ #category : #'private - preconditions' }
Match >> validateCanBeSummoned: aCreatureCard of: aPotentialPlayer [

	self
		assertManaCostOf: aCreatureCard isLowerOrEqualThanNumberOfManaOf: aPotentialPlayer;
		assertCivilizationOf: aCreatureCard isIncludedInCivilizationsOfManaOf: aPotentialPlayer
]

{ #category : #'private - accessing' }
Match >> zeroMana [

	^ self mana nullMeasure
]
