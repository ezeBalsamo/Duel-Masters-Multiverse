"
A TurnContextTest is a test class for testing the behavior of TurnContext
"
Class {
	#name : #MatchRequestTest,
	#superclass : #TestCase,
	#instVars : [
		'match'
	],
	#category : #'DM-Match-Request-Model-Tests'
}

{ #category : #testing }
MatchRequestTest class >> isAbstract [

	^ self = MatchRequestTest
]

{ #category : #'private - processing' }
MatchRequestTest >> changeCurrentStepTo: aTurnStep [

	match execute: ( ChangeCurrentStepRequest changingTo: aTurnStep ) requestedBy: self turnPlayer
]

{ #category : #'private - accessing' }
MatchRequestTest >> immortalBaronVorg [

	^ CreatureCard named: 'Immortal Baron, Vorg'
		  from: ( Civilization named: 'Fire' )
		  ofType: ( SingleRace ofTypeNamed: 'Human' )
		  costing: ( DMUnits mana with: 2 )
		  providing: ( DMUnits mana with: 1 )
		  with: ( DMUnits power with: 2000 )
]

{ #category : #'private - accessing' }
MatchRequestTest >> knightDeck [

	^ ( ( 1 to: 15 ) collect: #asString ) asOrderedCollection
]

{ #category : #'private - accessing' }
MatchRequestTest >> nonTurnPlayer [

	^ match opponentOf: self turnPlayer
]

{ #category : #running }
MatchRequestTest >> setUp [

	| shobu knight |

	super setUp.
	shobu := Duelist named: 'Shobu' using: self shobuDeck.
	knight := Duelist named: 'Knight' using: self knightDeck.
	match := Match between: shobu and: knight
]

{ #category : #'private - accessing' }
MatchRequestTest >> shobuDeck [

	^ ( ( 1 to: 15 ) collect: #asString ) asOrderedCollection
]

{ #category : #'private - asserting' }
MatchRequestTest >> should: aBlock raiseIllegalPlayFrom: aPlayer because: anErrorDescription [

	self should: aBlock raise: IllegalPlay withExceptionDo: [ :signal | 
		self
			assert: signal player equals: aPlayer;
			assert: signal errorDescription equals: anErrorDescription
		]
]

{ #category : #'private - accessing' }
MatchRequestTest >> turnPlayer [

	^ match currentPlayer
]
