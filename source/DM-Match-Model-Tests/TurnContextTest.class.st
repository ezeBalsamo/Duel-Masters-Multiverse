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

{ #category : #testing }
TurnContextTest class >> isAbstract [

	^ self = TurnContextTest
]

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

{ #category : #'private - accessing' }
TurnContextTest >> turnPlayer [

	^ match currentPlayer
]
