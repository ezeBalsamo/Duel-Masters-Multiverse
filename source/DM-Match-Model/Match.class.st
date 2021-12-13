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
		'turnContext'
	],
	#category : #'DM-Match-Model'
}

{ #category : #'instance creation' }
Match class >> between: aPlayer and: anotherPlayer [

	^ self new initializeBetween: aPlayer and: anotherPlayer
]

{ #category : #'private - preconditions' }
Match >> assert: aPlayer canAttack: anOpponentCreatureCard of: anOpponentPlayer [

	| errorDescriptionTemplate |

	errorDescriptionTemplate := [ :reason | 
	                            'You can''t attack <1p> because <2s>' expandMacrosWith:
		                            anOpponentCreatureCard
		                            with: reason ].

	self
		signalIllegalPlayFrom: aPlayer
		because: [ errorDescriptionTemplate value: 'it''s not summoned.' ]
		unless: ( self summonedCreatures includes: anOpponentCreatureCard );
		signalIllegalPlayFrom: aPlayer
		because: [ errorDescriptionTemplate value: 'it''s yours.' ]
		unless: ( ( self summonedCreaturesOf: aPlayer ) includes: anOpponentCreatureCard ) not;
		signalIllegalPlayFrom: aPlayer
		because: [ errorDescriptionTemplate value: 'it''s untapped.' ]
		unless: ( ( self tappedCreaturesOf: anOpponentPlayer ) includes: anOpponentCreatureCard )
]

{ #category : #'private - preconditions' }
Match >> assert: aPlayer canAttackWith: aCreatureCard [

	| errorDescriptionTemplate |

	errorDescriptionTemplate := [ :reason | 
	                            'You can''t attack with <1p> because <2s>' expandMacrosWith:
		                            aCreatureCard
		                            with: reason ].

	self
		signalIllegalPlayFrom: aPlayer
		because: [ errorDescriptionTemplate value: 'it''s not summoned.' ]
		unless: ( self summonedCreatures includes: aCreatureCard );
		signalIllegalPlayFrom: aPlayer
		because: [ errorDescriptionTemplate value: 'it''s not yours.' ]
		unless: ( ( self summonedCreaturesOf: aPlayer ) includes: aCreatureCard );
		signalIllegalPlayFrom: aPlayer
		because: [ errorDescriptionTemplate value: 'it has summoning sickness.' ]
		unless: ( turnContext hasSummoningSickness: aCreatureCard ) not;
		assertIsUntapped: aCreatureCard of: aPlayer
]

{ #category : #'private - asserting' }
Match >> assertCardCanBeDrawn [

	self signalIllegalPlayFrom: self currentPlayer
		because: 'Only one card can be drawn per turn.'
		unless: self canCardBeDrawn
]

{ #category : #'private - asserting' }
Match >> assertIsAllowedInCurrentStep: aRequest [

	| currentStep |

	currentStep := turnContext currentStep.

	self signalIllegalPlayFrom: self currentPlayer
		because:
		( 'You can''t <1s> in the <2p>.' expandMacrosWith: aRequest actionDescription with: currentStep )
		unless: ( currentStep allowsActionDescribedAs: aRequest actionDescription )
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

{ #category : #'private - asserting' }
Match >> assertManaCanBeCharged [

	self signalIllegalPlayFrom: self currentPlayer
		because: 'Mana can only be charged once per turn.'
		unless: turnContext canManaBeCharged
]

{ #category : #'private - asserting' }
Match >> assertThatIsItsTurn: aPlayer inOrderToExecute: aRequest [

	self signalIllegalPlayFrom: aPlayer
		because:
		( 'You can''t <1s> on your opponent''s turn.' expandMacrosWith: aRequest actionDescription )
		unless: self currentPlayer = aPlayer
]

{ #category : #processing }
Match >> attack: anOpponentCreatureCard with: aCreatureCard [

	| turnPlayer opponentPlayer |

	turnPlayer := self currentPlayer.
	self assert: turnPlayer canAttackWith: aCreatureCard.
	opponentPlayer := self opponentOf: turnPlayer.
	self assert: turnPlayer canAttack: anOpponentCreatureCard of: opponentPlayer
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

{ #category : #testing }
Match >> canCardBeDrawn [

	^ canCardBeDrawn
]

{ #category : #processing }
Match >> changeCurrentStepTo: aTurnStep [

	turnContext changeCurrentStepTo: aTurnStep
]

{ #category : #processing }
Match >> chargeManaWith: aCard [

	self assertManaCanBeCharged.

	( self manaOf: self currentPlayer ) add: aCard.
	turnContext manaHasBeenCharged
]

{ #category : #accessing }
Match >> creaturesThatHaveSummoningSickness [

	^ turnContext creaturesThatHaveSummoningSickness
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
Match >> directAttackFrom: aCreatureCard [

	| turnPlayer opponentPlayer |

	self assert: self currentPlayer canAttackWith: aCreatureCard.

	turnPlayer := self currentPlayer.

	( self tappedCreaturesOf: turnPlayer ) add: aCreatureCard.

	opponentPlayer := self opponentOf: turnPlayer.
	( self shieldsOf: opponentPlayer ) ifEmpty: [ status := GameEnded wonBy: turnPlayer ]
		ifNotEmpty: [ :opponentShields | 
			| brokenShield |

			brokenShield := opponentShields anyOne.
			opponentShields remove: brokenShield.
			( self handOf: opponentPlayer ) add: brokenShield
			]
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
Match >> drawCard [

	| turnPlayer |

	self assertCardCanBeDrawn.

	turnPlayer := self currentPlayer.

	( self handOf: turnPlayer ) add: turnPlayer drawCard.
	canCardBeDrawn := false.

	turnPlayer isDeckEmpty then: [ status := GameEnded wonBy: ( self opponentOf: turnPlayer ) ]
]

{ #category : #processing }
Match >> endTurnOf: aPlayer [

	self ifIsNotTurnOf: aPlayer warnThat: 'You can''t end your opponent''s turn.'.

	canCardBeDrawn := true.
	playersTurn next.
	turnContext endTurn.

	( self tappedManaOf: self currentPlayer ) removeAll.
	( self tappedCreaturesOf: self currentPlayer ) removeAll
]

{ #category : #executing }
Match >> execute: aRequest requestedBy: aPlayer [

	self
		assertThatIsItsTurn: aPlayer inOrderToExecute: aRequest;
		assertIsAllowedInCurrentStep: aRequest.

	aRequest executeOn: self
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
	canCardBeDrawn := false.
	status := GameInProgress new.
	turnContext := TurnContext within: self.

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
		with: secondPlayer -> OrderedCollection new
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
Match >> summon: aCreatureCard tappingAll: aCardCollection [

	| turnPlayer |

	turnPlayer := self currentPlayer.

	( CreatureSummonAssertion workingWith: self ) validateSummoningOf: aCreatureCard
		tappingAll: aCardCollection.

	( self tappedManaOf: turnPlayer ) addAll: aCardCollection.
	( self summonedCreaturesOf: turnPlayer ) add: aCreatureCard.
	turnContext creatureWasSummoned: aCreatureCard
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
