"
A TurnContextTest is a test class for testing the behavior of TurnContext
"
Class {
	#name : #TurnContextTest,
	#superclass : #TestCase,
	#instVars : [
		'turnContext',
		'shobu',
		'knight',
		'match'
	],
	#category : #'DM-Match-Model-Tests'
}

{ #category : #'private - accessing' }
TurnContextTest >> immortalBaronVorg [

	^ CreatureCard named: 'Immortal Baron, Vorg'
		  from: ( Civilization named: 'Fire' )
		  ofType: ( SingleRace ofTypeNamed: 'Human' )
		  costing: ( DMUnits mana with: 2 )
		  providing: ( DMUnits mana with: 1 )
		  with: ( DMUnits power with: 2000 )
]

{ #category : #'private - accessing' }
TurnContextTest >> knightDeck [

	^ ( ( 1 to: 15 ) collect: #asString ) asOrderedCollection
]

{ #category : #'private - accessing' }
TurnContextTest >> nonTurnPlayer [

	^ match opponentOf: self turnPlayer
]

{ #category : #running }
TurnContextTest >> setUp [

	super setUp.
	shobu := Duelist named: 'Shobu' using: self shobuDeck.
	knight := Duelist named: 'Knight' using: self knightDeck.
	match := Match between: shobu and: knight.
	turnContext := TurnContext within: match
]

{ #category : #'private - accessing' }
TurnContextTest >> shobuDeck [

	^ ( ( 1 to: 15 ) collect: #asString ) asOrderedCollection
]

{ #category : #'private - asserting' }
TurnContextTest >> should: aBlock raiseIllegalPlayFrom: aPlayer because: anErrorDescription [

	self should: aBlock raise: IllegalPlay withExceptionDo: [ :signal | 
		self
			assert: signal player equals: aPlayer;
			assert: signal errorDescription equals: anErrorDescription
		]
]

{ #category : #'tests - draw card' }
TurnContextTest >> test01NonTurnPlayerCantDrawCard [

	| request numberOfCardsInHand |

	request := DrawCardRequest new.

	numberOfCardsInHand := match numberOfCardsInHandOf: self nonTurnPlayer.

	self
		should: [ turnContext execute: request requestedBy: self nonTurnPlayer ]
		raiseIllegalPlayFrom: self nonTurnPlayer
		because: 'You can''t Draw Card on your opponent''s turn.';
		assert: ( match numberOfCardsInHandOf: self nonTurnPlayer ) equals: numberOfCardsInHand
]

{ #category : #'tests - draw card' }
TurnContextTest >> test02TurnPlayerCantDrawCardOnFirstTurn [

	| request numberOfCardsInHand |

	request := DrawCardRequest new.

	numberOfCardsInHand := match numberOfCardsInHandOf: self turnPlayer.

	self
		should: [ turnContext execute: request requestedBy: self turnPlayer ]
		raiseIllegalPlayFrom: self turnPlayer
		because: 'You can''t Draw Card in the Charge Mana Step.';
		assert: ( match numberOfCardsInHandOf: self turnPlayer ) equals: numberOfCardsInHand
]

{ #category : #'tests - draw card' }
TurnContextTest >> test03DrawCardForTurnPlayerOnAnyTurnExceptTheFirst [

	| request numberOfCardsInHand |

	request := DrawCardRequest new.

	match endTurnOf: self turnPlayer.
	turnContext endTurn.
	numberOfCardsInHand := match numberOfCardsInHandOf: self turnPlayer.
	turnContext execute: request requestedBy: self turnPlayer.
	self assert: ( match numberOfCardsInHandOf: self turnPlayer ) equals: numberOfCardsInHand + 1
]

{ #category : #'tests - draw card' }
TurnContextTest >> test04TurnPlayerCantDrawCardMoreThanOnceInTheSameTurn [

	| request numberOfCardsInHand |

	self test03DrawCardForTurnPlayerOnAnyTurnExceptTheFirst.

	request := DrawCardRequest new.

	numberOfCardsInHand := match numberOfCardsInHandOf: self turnPlayer.

	self
		should: [ turnContext execute: request requestedBy: self turnPlayer ]
		raiseIllegalPlayFrom: self turnPlayer
		because: 'Only one card can be drawn per turn.';
		assert: ( match numberOfCardsInHandOf: self turnPlayer ) equals: numberOfCardsInHand
]

{ #category : #'tests - charge mana' }
TurnContextTest >> test05NonTurnPlayerCantChargeMana [

	| request |

	request := ChargeManaRequest chargingManaWith: self immortalBaronVorg.

	self should: [ turnContext execute: request requestedBy: self nonTurnPlayer ]
		raiseIllegalPlayFrom: self nonTurnPlayer
		because: 'You can''t Charge Mana on your opponent''s turn.'
]

{ #category : #'tests - charge mana' }
TurnContextTest >> test06TurnPlayerCantChargeManaBeforeDrawingCard [

	| request |

	request := ChargeManaRequest chargingManaWith: self immortalBaronVorg.
	
	match endTurnOf: self turnPlayer.
	turnContext endTurn.
	self should: [ turnContext execute: request requestedBy: self turnPlayer ]
		raiseIllegalPlayFrom: self turnPlayer
		because: 'You can''t Charge Mana in the Draw Card Step.'
]

{ #category : #'tests - charge mana' }
TurnContextTest >> test07ChargeManaOfTurnPlayer [

	| card request |

	card := self immortalBaronVorg.
	request := ChargeManaRequest chargingManaWith: card.

	self assertEmpty: ( match manaOf: self turnPlayer ).
	turnContext execute: request requestedBy: self turnPlayer.
	self assertTheOnlyOneIn: ( match manaOf: self turnPlayer ) is: card
]

{ #category : #'tests - charge mana' }
TurnContextTest >> test08TurnPlayerCantChargeManaMoreThanOnceInTheSameTurn [

	| request turnPlayerMana |

	self test07ChargeManaOfTurnPlayer.

	request := ChargeManaRequest chargingManaWith: self immortalBaronVorg.

	turnPlayerMana := match manaOf: self turnPlayer.

	self
		should: [ turnContext execute: request requestedBy: self turnPlayer ]
		raiseIllegalPlayFrom: self turnPlayer
		because: 'Mana can only be charged once per turn.';
		assertCollection: ( match manaOf: self turnPlayer ) equals: turnPlayerMana
]

{ #category : #'private - accessing' }
TurnContextTest >> turnPlayer [

	^ match currentPlayer
]
