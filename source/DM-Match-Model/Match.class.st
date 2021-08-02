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
		'manaByPlayer',
		'tappedManaByPlayer',
		'hasFirstTurnEnded',
		'creaturesHavingSummonedSickness',
		'graveyardByPlayer',
		'summonedCreaturesByPlayer'
	],
	#category : #'DM-Match-Model'
}

{ #category : #'instance creation' }
Match class >> between: aPlayer and: anotherPlayer [

	^ self new initializeBetween: aPlayer and: anotherPlayer
]

{ #category : #'private - preconditions' }
Match >> assert: aCreatureCard isSummonedCreatureOf: aPlayer [

	self
		signalIllegalPlayFrom: aPlayer
		because: [ 'You can''t attack with <1p> because it''s not summoned.' expandMacrosWith: aCreatureCard ]
		unless: ( ( self summonedCreaturesOf: aPlayer ) includes: aCreatureCard )
]

{ #category : #'private - preconditions' }
Match >> assertCardHasNotBeenDrawnYet [

	self
		signalIllegalPlayFrom: self currentPlayer
		because: 'Only one card can be drawn per turn.'
		unless: canCardBeDrawn
]

{ #category : #'private - preconditions' }
Match >> assertIsNotFirstTurn [

	self
		signalIllegalPlayFrom: self currentPlayer
		because: 'You can''t draw card in your first turn.'
		unless: hasFirstTurnEnded
]

{ #category : #'private - preconditions' }
Match >> assertIsValidPlayer: aPotentialPlayer [

	^ [ self signalIsNotValidPlayer: aPotentialPlayer ]
		unless: ( playersTurn includes: aPotentialPlayer )
]

{ #category : #'private - preconditions' }
Match >> assertManaHasNotBeenChargedYet [

	self
		signalIllegalPlayFrom: self currentPlayer
		because: 'Mana can only be charged once per turn.'
		unless: canManaBeCharged
]

{ #category : #processing }
Match >> attackFrom: aCreatureCard of: aPlayer to: anOpponentCreatureCard [

	self assert: aCreatureCard isSummonedCreatureOf: aPlayer
]

{ #category : #processing }
Match >> chargeManaOf: aPlayer with: aCard [

	self
		ifIsNotTurnOf: aPlayer warnThat: 'You can''t charge mana on your opponent''s turn.';
		assertManaHasNotBeenChargedYet.

	( self manaOf: aPlayer ) add: aCard.
	canManaBeCharged := false
]

{ #category : #accessing }
Match >> creaturesHavingSummonedSickness [

	^ creaturesHavingSummonedSickness
]

{ #category : #'private - accessing' }
Match >> currentPlayer [

	^ playersTurn current
]

{ #category : #processing }
Match >> directAttackFrom: aCreatureCard of: aPlayer [

	self assert: aCreatureCard isSummonedCreatureOf: aPlayer
]

{ #category : #testing }
Match >> does: aCard belongToManaOf: aPlayer [

	^ ( self manaOf: aPlayer ) includes: aCard
]

{ #category : #testing }
Match >> does: aCard belongToUntappedManaOf: aPlayer [

	^ ( self untappedManaOf: aPlayer ) includes: aCard
]

{ #category : #processing }
Match >> drawCardFor: aPlayer [

	self
		ifIsNotTurnOf: aPlayer warnThat: 'You can''t draw a card on your opponent''s turn.';
		assertIsNotFirstTurn;
		assertCardHasNotBeenDrawnYet.

	( self handOf: aPlayer ) add: 'bla-bla'.
	canCardBeDrawn := false
]

{ #category : #processing }
Match >> endTurnOf: aPlayer [

	self ifIsNotTurnOf: aPlayer warnThat: 'You can''t end your opponent''s turn.'.

	canManaBeCharged := true.
	canCardBeDrawn := true.
	hasFirstTurnEnded
		ifFalse: [ hasFirstTurnEnded := true ].
	playersTurn next.

	( self tappedManaOf: self currentPlayer ) removeAll.
	creaturesHavingSummonedSickness removeAll
]

{ #category : #accessing }
Match >> graveyardOf: aPlayer [

	^ graveyardByPlayer at: aPlayer
]

{ #category : #'private - accessing' }
Match >> handOf: aPotentialPlayer [

	^ cardsInHandByPlayer
		at: aPotentialPlayer
		ifAbsent: [ self signalIsNotValidPlayer: aPotentialPlayer ]
]

{ #category : #accessing }
Match >> handOf: aPotentialPlayer requestedBy: aPetitioner [

	^ self
		signalIllegalPlayFrom: aPetitioner
			because: 'You can''t see the cards in your opponent''s hand.'
			unless: aPotentialPlayer = aPetitioner;
		handOf: aPotentialPlayer
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
		initializeHandByPlayer;
		initializeShieldsByPlayer;
		initializeManaByPlayer;
		initializeCreaturesSummonedByPlayer;
		initializeGraveyardByPlayer
]

{ #category : #initialization }
Match >> initializeCreaturesSummonedByPlayer [

	summonedCreaturesByPlayer := Dictionary
		with: firstPlayer -> OrderedCollection new
		with: secondPlayer -> OrderedCollection new.

	creaturesHavingSummonedSickness := OrderedCollection new
]

{ #category : #initialization }
Match >> initializeGraveyardByPlayer [

	graveyardByPlayer := Dictionary
		with: firstPlayer -> OrderedCollection new
		with: secondPlayer -> OrderedCollection new
]

{ #category : #initialization }
Match >> initializeHandByPlayer [

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

{ #category : #accessing }
Match >> manaOf: aPotentialPlayer [

	^ manaByPlayer
		at: aPotentialPlayer
		ifAbsent: [ self signalIsNotValidPlayer: aPotentialPlayer ]
]

{ #category : #accessing }
Match >> shieldsOf: aPotentialPlayer [

	^ shieldsByPlayer at: aPotentialPlayer ifAbsent: [ self signalIsNotValidPlayer: aPotentialPlayer ]
]

{ #category : #'private - signaling' }
Match >> signalIllegalPlayFrom: aPotentialPlayer because: anErrorDescriptionOrBlock unless: aConditionToBeSatisfied [

	[ IllegalPlay from: aPotentialPlayer because: anErrorDescriptionOrBlock value ]
		unless: aConditionToBeSatisfied
]

{ #category : #'private - signaling' }
Match >> signalIsNotValidPlayer: aNotValidPlayer [

	Error signal: ( '<1s> is not a valid player in this match.' expandMacrosWith: aNotValidPlayer )
]

{ #category : #processing }
Match >> summon: aCreatureCard of: aPlayer tappingAll: aCardCollection [

	( CreatureSummonAssertion workingWith: self )
		validateSummoningOf: aCreatureCard
		from: aPlayer
		tappingAll: aCardCollection.

	( self tappedManaOf: aPlayer ) addAll: aCardCollection.
	( self summonedCreaturesOf: aPlayer ) add: aCreatureCard.
	creaturesHavingSummonedSickness add: aCreatureCard
]

{ #category : #accessing }
Match >> summonedCreaturesOf: aPlayer [

	^ summonedCreaturesByPlayer at: aPlayer
]

{ #category : #accessing }
Match >> tappedManaOf: aPotentialPlayer [

	^ tappedManaByPlayer
		at: aPotentialPlayer
		ifAbsent: [ self signalIsNotValidPlayer: aPotentialPlayer ]
]

{ #category : #'private - accessing' }
Match >> untappedManaOf: aPlayer [

	^ ( self manaOf: aPlayer ) difference: ( self tappedManaOf: aPlayer )
]
