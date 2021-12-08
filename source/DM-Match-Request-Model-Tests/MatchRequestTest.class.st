"
A TurnContextTest is a test class for testing the behavior of TurnContext
"
Class {
	#name : #MatchRequestTest,
	#superclass : #TestCase,
	#instVars : [
		'match',
		'lightCivilization',
		'fireCivilization',
		'darknessCivilization'
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
			match endTurnOf: self turnPlayer.
			self drawCard
			].
		self changeCurrentStepTo: ChargeManaStep new
		]
]

{ #category : #'private - test support' }
MatchRequestTest >> drawCard [

	match execute: DrawCardRequest new requestedBy: self turnPlayer
]

{ #category : #'private - test support' }
MatchRequestTest >> endTurn [

	match endTurnOf: self turnPlayer
]

{ #category : #'private - accessing' }
MatchRequestTest >> immortalBaronVorg [

	^ CreatureCard named: 'Immortal Baron, Vorg'
		  from: fireCivilization
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
MatchRequestTest >> march [

	^ CreatureCard named: 'March'
		  from: lightCivilization
		  ofType: ( SingleRace ofTypeNamed: '2016 Calendar' )
		  costing: ( DMUnits mana with: 3 )
		  providing: self oneMana
		  with: ( DMUnits power with: 3000 )
]

{ #category : #'private - accessing' }
MatchRequestTest >> nonTurnPlayer [

	^ match opponentOf: self turnPlayer
]

{ #category : #'private - accessing' }
MatchRequestTest >> oneMana [

	^ DMUnits mana with: 1
]

{ #category : #running }
MatchRequestTest >> setUp [

	| shobu knight |

	super setUp.
	self setUpCivilizations.
	shobu := Duelist named: 'Shobu' using: self shobuDeck.
	knight := Duelist named: 'Knight' using: self knightDeck.
	match := Match between: shobu and: knight
]

{ #category : #'private - running' }
MatchRequestTest >> setUpCivilizations [

	lightCivilization := Civilization named: 'Light'.
	fireCivilization := Civilization named: 'Fire'.
	darknessCivilization := Civilization named: 'Darkness'
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

	match execute: ( SummonCreatureRequest summoning: aCreatureCard tapping: aCard )
		requestedBy: self turnPlayer
]

{ #category : #'private - accessing' }
MatchRequestTest >> tulkTheOracle [

	^ CreatureCard named: 'Tulk, the Oracle'
		  from: lightCivilization
		  ofType: ( SingleRace ofTypeNamed: 'Light Bringer' )
		  costing: self oneMana
		  providing: self oneMana
		  with: ( DMUnits power with: 500 )
]

{ #category : #'private - accessing' }
MatchRequestTest >> turnPlayer [

	^ match currentPlayer
]

{ #category : #'private - accessing' }
MatchRequestTest >> vocalMegahit [

	^ CreatureCard named: 'Vocal Megahit'
		  from: fireCivilization
		  ofType: ( SingleRace ofTypeNamed: 'Beat Jockey' )
		  costing: ( DMUnits mana with: 5 )
		  providing: self oneMana
		  with: ( DMUnits power with: 5000 )
]

{ #category : #'private - accessing' }
MatchRequestTest >> vorgBrawlerOfHell [

	^ CreatureCard
		  named: 'Vorg, Brawler of Hell'
		  fromAll: ( Array with: fireCivilization with: darknessCivilization )
		  ofType: ( MultipleRace conformedByAll: ( Array with: ( SingleRace ofTypeNamed: 'Human' )
					      with: ( SingleRace ofTypeNamed: 'Beat Jockey' )
					      with: ( SingleRace ofTypeNamed: 'Alien' ) ) )
		  costing: ( DMUnits mana with: 2 )
		  providing: self oneMana
		  with: ( DMUnits power with: 4000 )
]
