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

{ #category : #tests }
TurnContextTest >> test01DrawCardForTurnPlayerOnFirstTurn [

	| request |

	request := DrawCardRequest new.

	self should: [ turnContext execute: request requestedBy: self turnPlayer ]
		raiseIllegalPlayFrom: self turnPlayer
		because: 'You can''t Draw Card in the Charge Mana Step.'
]

{ #category : #tests }
TurnContextTest >> test02DrawCardForNonTurnPlayer [

	| request |

	request := DrawCardRequest new.

	self should: [ turnContext execute: request requestedBy: self nonTurnPlayer ]
		raiseIllegalPlayFrom: self nonTurnPlayer
		because: 'You can''t Draw Card on your opponent''s turn.'
]

{ #category : #'private - accessing' }
TurnContextTest >> turnPlayer [

	^ match currentPlayer
]