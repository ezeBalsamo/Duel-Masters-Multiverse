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
		'graveyardByPlayer',
		'summonedCreaturesByPlayer',
		'tappedCreaturesByPlayer',
		'status',
		'creaturesHavingSummoningSickness'
	],
	#category : #'DM-Match-Model'
}

{ #category : #'instance creation' }
Match class >> between: aPlayer and: anotherPlayer [

	^ self new initializeBetween: aPlayer and: anotherPlayer
]

{ #category : #'private - preconditions' }
Match >> assert: aPlayer canAttack: aCreatureCard of: anOpponentPlayer [

	self
		signalIllegalPlayFrom: aPlayer
			because: [ '<1p> it''s not summoned.' expandMacrosWith: aCreatureCard ]
			unless: ( self summonedCreatures includes: aCreatureCard );
		signalIllegalPlayFrom: aPlayer
			because:
				[ 'You can''t attack <1p> because it''s on your side of the field.' expandMacrosWith: aCreatureCard ]
			unless: ( ( self summonedCreaturesOf: aPlayer ) includes: aCreatureCard ) not;
		signalIllegalPlayFrom: aPlayer
			because: [ 'You can''t attack <1p> because it''s untapped.' expandMacrosWith: aCreatureCard ]
			unless: ( ( self tappedCreaturesOf: anOpponentPlayer ) includes: aCreatureCard )
]

{ #category : #'private - preconditions' }
Match >> assert: aPlayer canAttackWith: aCreatureCard [

	self
		signalIllegalPlayFrom: aPlayer
			because: [ '<1p> it''s not summoned.' expandMacrosWith: aCreatureCard ]
			unless: ( self summonedCreatures includes: aCreatureCard );
		signalIllegalPlayFrom: aPlayer
			because: [ 'You can''t attack with <1p> because it''s not on your side of the field.'
				expandMacrosWith: aCreatureCard
			]
			unless: ( ( self summonedCreaturesOf: aPlayer ) includes: aCreatureCard );
		assertDoesNotHaveSummoningSickness: aCreatureCard of: aPlayer;
		assertIsUntapped: aCreatureCard of: aPlayer
]

{ #category : #'private - preconditions' }
Match >> assertCardHasNotBeenDrawnYet [

	self
		signalIllegalPlayFrom: self currentPlayer
		because: 'Only one card can be drawn per turn.'
		unless: canCardBeDrawn
]

{ #category : #'private - preconditions' }
Match >> assertDoesNotHaveSummoningSickness: aCreatureCard of: aPlayer [

	self
		signalIllegalPlayFrom: aPlayer
		because: [ 'You can''t attack with <1p> because it has summoning sickness.' expandMacrosWith: aCreatureCard ]
		unless: ( creaturesHavingSummoningSickness includes: aCreatureCard ) not
]

{ #category : #'private - preconditions' }
Match >> assertIsNotFirstTurn [

	self
		signalIllegalPlayFrom: self currentPlayer
		because: 'You can''t draw card in your first turn.'
		unless: hasFirstTurnEnded
]

{ #category : #'private - preconditions' }
Match >> assertIsUntapped: aCreatureCard of: aPlayer [

	self
		signalIllegalPlayFrom: aPlayer
		because: [ 'You can''t attack with <1p> because is tapped.' expandMacrosWith: aCreatureCard ]
		unless: ( ( self tappedCreaturesOf: aPlayer ) includes: aCreatureCard ) not
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

	| opponentPlayer |

	self
		ifIsNotTurnOf: aPlayer warnThat: 'You can''t attack on your opponent''s turn.';
		assert: aPlayer canAttackWith: aCreatureCard.

	opponentPlayer := self opponentOf: aPlayer.
	self assert: aPlayer canAttack: anOpponentCreatureCard of: opponentPlayer.

	( self tappedCreaturesOf: aPlayer ) add: aCreatureCard.

	( BattleResolver workingWith: self )
		resolveBattleBetween: aCreatureCard
		of: aPlayer
		and: anOpponentCreatureCard
		of: opponentPlayer
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
Match >> creaturesHavingSummoningSickness [

	^ creaturesHavingSummoningSickness
]

{ #category : #'private - accessing' }
Match >> currentPlayer [

	^ playersTurn current
]

{ #category : #'private - processing' }
Match >> destroy: aCreatureCard of: aDuelist [

	( self summonedCreaturesOf: aDuelist ) remove: aCreatureCard.
	( self graveyardOf: aDuelist ) add: aCreatureCard
]

{ #category : #processing }
Match >> directAttackFrom: aCreatureCard of: aPlayer [

	| opponentPlayer brokenShield |

	self
		ifIsNotTurnOf: aPlayer warnThat: 'You can''t attack on your opponent''s turn.';
		assert: aPlayer canAttackWith: aCreatureCard.

	( self tappedCreaturesOf: aPlayer ) add: aCreatureCard.

	opponentPlayer := self opponentOf: aPlayer.
	( self shieldsOf: opponentPlayer )
		ifEmpty: [ status := GameEnded wonBy: aPlayer ]
		ifNotEmpty: [ :opponentShields | 
			brokenShield := opponentShields anyOne.
			opponentShields remove: brokenShield.
			( self handOf: opponentPlayer ) add: brokenShield
			]
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

	( self handOf: aPlayer ) add: aPlayer drawCard.
	canCardBeDrawn := false.

	aPlayer isDeckEmpty then: [ status := GameEnded wonBy: ( self opponentOf: aPlayer ) ]
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
	( self tappedCreaturesOf: self currentPlayer ) removeAll.
	creaturesHavingSummoningSickness removeAll
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

{ #category : #accessing }
Match >> hasEnded [

	^ status hasEnded
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
	status := GameInProgress new.

	self
		initializeShieldsByPlayer;
		initializeHandByPlayer;
		initializeManaByPlayer;
		initializeCreaturesSummonedByPlayer;
		initializeGraveyardByPlayer
]

{ #category : #initialization }
Match >> initializeCreaturesSummonedByPlayer [

	summonedCreaturesByPlayer := Dictionary
		with: firstPlayer -> OrderedCollection new
		with: secondPlayer -> OrderedCollection new.

	tappedCreaturesByPlayer := Dictionary
		with: firstPlayer -> OrderedCollection new
		with: secondPlayer -> OrderedCollection new.

	creaturesHavingSummoningSickness := OrderedCollection new
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
		with: firstPlayer -> firstPlayer drawFiveCards
		with: secondPlayer -> secondPlayer drawFiveCards
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
		with: firstPlayer -> firstPlayer drawFiveCards
		with: secondPlayer -> secondPlayer drawFiveCards
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
Match >> numberOfCardsInHandOf: aPlayer [

	^ ( self handOf: aPlayer ) size
]

{ #category : #'private - accessing' }
Match >> opponentOf: aPlayer [

	^ aPlayer = firstPlayer then: [ secondPlayer ] otherwise: [ firstPlayer ]
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
	creaturesHavingSummoningSickness add: aCreatureCard
]

{ #category : #'private - accessing' }
Match >> summonedCreatures [

	^ summonedCreaturesByPlayer values flattened
]

{ #category : #accessing }
Match >> summonedCreaturesOf: aPlayer [

	^ summonedCreaturesByPlayer at: aPlayer
]

{ #category : #accessing }
Match >> tappedCreaturesOf: aPotentialPlayer [

	^ tappedCreaturesByPlayer
		at: aPotentialPlayer
		ifAbsent: [ self signalIsNotValidPlayer: aPotentialPlayer ]
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

{ #category : #accessing }
Match >> winner [

	^ status winner
]