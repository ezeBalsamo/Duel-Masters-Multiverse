Class {
	#name : #Match,
	#superclass : #Object,
	#instVars : [
		'firstPlayer',
		'secondPlayer',
		'cardsInHandByPlayer',
		'manaChargedByPlayer',
		'shieldsByPlayer',
		'playersTurn',
		'canManaBeCharged',
		'canCardBeDrawn'
	],
	#category : #'DM-Match-Model'
}

{ #category : #'instance creation' }
Match class >> between: aPlayer and: anotherPlayer [

	^ self new initializeBetween: aPlayer and: anotherPlayer
]

{ #category : #'private - preconditions' }
Match >> assertCardHasNotBeenDrawnYet [

	[ IllegalPlay from: self currentPlayer because: 'Only one card can be drawn per turn.' ]
		unless: canCardBeDrawn
]

{ #category : #'private - preconditions' }
Match >> assertIsValidPlayer: aPotentialPlayer [

	^ [ self signalIsNotValidPlayer: aPotentialPlayer ]
		unless: ( playersTurn includes: aPotentialPlayer )
]

{ #category : #'private - preconditions' }
Match >> assertManaHasNotBeenChargedYet [

	[ IllegalPlay from: self currentPlayer because: 'Mana can only be charged once per turn.' ]
		unless: canManaBeCharged
]

{ #category : #accessing }
Match >> cardsInHandOf: aPotentialPlayer [

	^ cardsInHandByPlayer
		at: aPotentialPlayer
		ifAbsent: [ self signalIsNotValidPlayer: aPotentialPlayer ]
]

{ #category : #processing }
Match >> chargeManaOf: aPotentialPlayer with: aCard [

	self
		assertIsValidPlayer: aPotentialPlayer;
		ifIsNotTurnOf: aPotentialPlayer warnThat: 'You can''t charge mana on your opponent''s turn.';
		assertManaHasNotBeenChargedYet.

	( self manaChargedBy: aPotentialPlayer ) add: aCard.
	canManaBeCharged := false
]

{ #category : #'private - accessing' }
Match >> currentPlayer [

	^ playersTurn current
]

{ #category : #processing }
Match >> drawCardFor: aPotentialPlayer [

	self
		assertIsValidPlayer: aPotentialPlayer;
		ifIsNotTurnOf: aPotentialPlayer warnThat: 'You can''t draw a card on your opponent''s turn.';
		assertCardHasNotBeenDrawnYet.
	( self cardsInHandOf: aPotentialPlayer ) add: 'bla-bla'.
	canCardBeDrawn := false
]

{ #category : #'private - processing' }
Match >> endTurn [

	canManaBeCharged := true.
	canCardBeDrawn := true.
	playersTurn next
]

{ #category : #processing }
Match >> endTurnOf: aPotentialPlayer [

	self
		assertIsValidPlayer: aPotentialPlayer;
		ifIsNotTurnOf: aPotentialPlayer warnThat: 'You can''t end your opponent''s turn.';
		endTurn
]

{ #category : #'private - preconditions' }
Match >> ifIsNotTurnOf: aPlayer warnThat: anErrorDescription [

	[ IllegalPlay from: aPlayer because: anErrorDescription ] unless: ( self isTurnOf: aPlayer )
]

{ #category : #initialization }
Match >> initializeBetween: aFirstPlayer and: aSecondPlayer [

	playersTurn := CircularIterator cyclingOver: ( Array with: aFirstPlayer with: aSecondPlayer ).
	firstPlayer := aFirstPlayer.
	secondPlayer := aSecondPlayer.
	canManaBeCharged := true.
	canCardBeDrawn := true.

	self
		initializeCardsInHandByPlayer;
		initializeShieldsByPlayer;
		initializeManaChargedByPlayer
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
Match >> initializeManaChargedByPlayer [

	manaChargedByPlayer := Dictionary
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
Match >> manaChargedBy: aPotentialPlayer [

	^ manaChargedByPlayer
		at: aPotentialPlayer
		ifAbsent: [ self signalIsNotValidPlayer: aPotentialPlayer ]
]

{ #category : #accessing }
Match >> shieldsOf: aPotentialPlayer [

	^ shieldsByPlayer at: aPotentialPlayer ifAbsent: [ self signalIsNotValidPlayer: aPotentialPlayer ]
]

{ #category : #'private - signaling' }
Match >> signalIsNotValidPlayer: aNotValidPlayer [

	Error signal: ( '<1s> is not a valid player in this match.' expandMacrosWith: aNotValidPlayer )
]
