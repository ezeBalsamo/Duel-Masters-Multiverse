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

{ #category : #'private - asserting' }
Match >> assertCanAttackWith: aCreatureCard [

	| turnPlayer errorDescriptionTemplate |
	
	turnPlayer := self currentPlayer.

	errorDescriptionTemplate := [ :reason | 
	                            'You can''t attack with <1p> because <2s>' expandMacrosWith:
		                            aCreatureCard
		                            with: reason ].

	self
		signalIllegalPlayFrom: turnPlayer
		because: [ errorDescriptionTemplate value: 'it''s not summoned.' ]
		unless: ( self summonedCreatures includes: aCreatureCard );
		signalIllegalPlayFrom: turnPlayer
		because: [ errorDescriptionTemplate value: 'it''s not yours.' ]
		unless: ( ( self summonedCreaturesOf: turnPlayer ) includes: aCreatureCard );
		signalIllegalPlayFrom: turnPlayer
		because: [ errorDescriptionTemplate value: 'it has summoning sickness.' ]
		unless: ( turnContext hasSummoningSickness: aCreatureCard ) not;
		signalIllegalPlayFrom: turnPlayer
		because: [ errorDescriptionTemplate value: 'it''s tapped.' ]
		unless: ( ( self tappedCreaturesOf: turnPlayer ) includes: aCreatureCard ) not
]

{ #category : #'private - asserting' }
Match >> assertCanBeAttacked: aCreatureCard [

	| errorDescriptionTemplate turnPlayer opponentPlayer |

	turnPlayer := self currentPlayer.
	opponentPlayer := self opponentOf: turnPlayer.

	errorDescriptionTemplate := [ :reason | 
	                            'You can''t attack <1p> because <2s>' expandMacrosWith: aCreatureCard
		                            with: reason ].

	self
		signalIllegalPlayFrom: turnPlayer
		because: [ errorDescriptionTemplate value: 'it''s not summoned.' ]
		unless: ( self summonedCreatures includes: aCreatureCard );
		signalIllegalPlayFrom: turnPlayer
		because: [ errorDescriptionTemplate value: 'it''s yours.' ]
		unless: ( ( self summonedCreaturesOf: turnPlayer ) includes: aCreatureCard ) not;
		signalIllegalPlayFrom: turnPlayer
		because: [ errorDescriptionTemplate value: 'it''s untapped.' ]
		unless: ( ( self tappedCreaturesOf: opponentPlayer ) includes: aCreatureCard )
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

	self assertCanAttackWith: aCreatureCard.
	self assertCanBeAttacked: anOpponentCreatureCard.

	turnPlayer := self currentPlayer.
	opponentPlayer := self opponentOf: turnPlayer.

	( self tappedCreaturesOf: turnPlayer ) add: aCreatureCard.

	( BattleResolver workingWith: self ) resolveBattleBetween: aCreatureCard
		of: turnPlayer
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
Match >> destroy: aCreatureCard of: aPlayer [

	( self summonedCreaturesOf: aPlayer ) remove: aCreatureCard.
	( self graveyardOf: aPlayer ) add: aCreatureCard
]

{ #category : #processing }
Match >> directAttackFrom: aCreatureCard [

	| turnPlayer opponentPlayer |

	self assertCanAttackWith: aCreatureCard.

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
Match >> endTurn [

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

	^ cardsInHandByPlayer at: aPotentialPlayer
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

	^ self currentPlayer = aPotentialPlayer
]

{ #category : #accessing }
Match >> manaOf: aPotentialPlayer [

	^ manaByPlayer at: aPotentialPlayer
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

	^ shieldsByPlayer at: aPotentialPlayer
]

{ #category : #'private - signaling' }
Match >> signalIllegalPlayFrom: aPotentialPlayer because: anErrorDescriptionOrBlock unless: aConditionToBeSatisfied [

	[ IllegalPlay from: aPotentialPlayer because: anErrorDescriptionOrBlock value ]
		unless: aConditionToBeSatisfied
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

	^ tappedCreaturesByPlayer at: aPotentialPlayer
]

{ #category : #accessing }
Match >> tappedManaOf: aPotentialPlayer [

	^ tappedManaByPlayer at: aPotentialPlayer
]

{ #category : #'private - accessing' }
Match >> untappedManaOf: aPlayer [

	^ ( self manaOf: aPlayer ) difference: ( self tappedManaOf: aPlayer )
]

{ #category : #accessing }
Match >> winner [

	^ status winner
]
