"
A TurnContextTest is a test class for testing the behavior of TurnContext
"
Class {
	#name : #MatchRequestTest,
	#superclass : #TestCase,
	#traits : 'TestCreatureCardProvider + RequestExecutionTestAssistant',
	#classTraits : 'TestCreatureCardProvider classTrait + RequestExecutionTestAssistant classTrait',
	#instVars : [
		'match',
		'cardProvider'
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

{ #category : #'private - test support' }
MatchRequestTest >> chargeManaWith: aCard [

	match execute: ( ChargeManaRequest chargingManaWith: aCard ) requestedBy: self turnPlayer
]

{ #category : #'private - test support' }
MatchRequestTest >> chargeManaWithAll: aCardCollection [

	aCardCollection do: [ :aCard | 
		self chargeManaWith: aCard.
		2 timesRepeat: [ 
			self
				endTurn;
				changeCurrentStepTo: DrawCardStep new;
				drawCard;
				changeCurrentStepTo: ChargeManaStep new
			]
		]
]

{ #category : #'private - test support' }
MatchRequestTest >> directAttackFrom: aCreatureCard [

	match execute: ( DirectAttackRequest attackingWith: aCreatureCard ) requestedBy: self turnPlayer
]

{ #category : #'private - test support' }
MatchRequestTest >> drawCard [

	match execute: DrawCardRequest new requestedBy: self turnPlayer
]

{ #category : #'private - test support' }
MatchRequestTest >> endTurn [

	match execute: EndTurnRequest new requestedBy: self turnPlayer
]

{ #category : #'private - accessing' }
MatchRequestTest >> knightDeck [

	^ ( ( 1 to: 15 ) collect: #asString ) asOrderedCollection
]

{ #category : #'private - accessing' }
MatchRequestTest >> match [

	^ match
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

{ #category : #'private - test support' }
MatchRequestTest >> summon: aCreatureCard tapping: aCard [

	self summon: aCreatureCard tappingAll: { aCard }
]

{ #category : #'private - test support' }
MatchRequestTest >> summon: aCreatureCard tappingAll: aCardCollection [

	match execute: ( SummonCreatureRequest summoning: aCreatureCard tappingAll: aCardCollection )
		requestedBy: self turnPlayer
]
