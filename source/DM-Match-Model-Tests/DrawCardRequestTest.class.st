Class {
	#name : #DrawCardRequestTest,
	#superclass : #TurnContextTest,
	#category : #'DM-Match-Model-Tests'
}

{ #category : #tests }
DrawCardRequestTest >> test01NonTurnPlayerCantDrawCard [

	| request numberOfCardsInHand |

	request := DrawCardRequest new.

	numberOfCardsInHand := match numberOfCardsInHandOf: self nonTurnPlayer.

	self
		should: [ turnContext execute: request requestedBy: self nonTurnPlayer ]
		raiseIllegalPlayFrom: self nonTurnPlayer
		because: 'You can''t Draw Card on your opponent''s turn.';
		assert: ( match numberOfCardsInHandOf: self nonTurnPlayer ) equals: numberOfCardsInHand
]

{ #category : #tests }
DrawCardRequestTest >> test02TurnPlayerCantDrawCardOnFirstTurn [

	| request numberOfCardsInHand |

	request := DrawCardRequest new.

	numberOfCardsInHand := match numberOfCardsInHandOf: self turnPlayer.

	self
		should: [ turnContext execute: request requestedBy: self turnPlayer ]
		raiseIllegalPlayFrom: self turnPlayer
		because: 'You can''t Draw Card in the Charge Mana Step.';
		assert: ( match numberOfCardsInHandOf: self turnPlayer ) equals: numberOfCardsInHand
]

{ #category : #tests }
DrawCardRequestTest >> test03DrawCardForTurnPlayerOnAnyTurnExceptTheFirst [

	| request numberOfCardsInHand |

	request := DrawCardRequest new.

	match endTurnOf: self turnPlayer.
	turnContext endTurn.
	numberOfCardsInHand := match numberOfCardsInHandOf: self turnPlayer.
	turnContext execute: request requestedBy: self turnPlayer.
	self assert: ( match numberOfCardsInHandOf: self turnPlayer ) equals: numberOfCardsInHand + 1
]

{ #category : #tests }
DrawCardRequestTest >> test04TurnPlayerCantDrawCardMoreThanOnceInTheSameTurn [

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

{ #category : #tests }
DrawCardRequestTest >> test05PlayerCanDrawCardEveryTurn [

	self test03DrawCardForTurnPlayerOnAnyTurnExceptTheFirst.

	2 timesRepeat: [ 
		match endTurnOf: self turnPlayer.
		turnContext endTurn
		].

	self test03DrawCardForTurnPlayerOnAnyTurnExceptTheFirst
]
