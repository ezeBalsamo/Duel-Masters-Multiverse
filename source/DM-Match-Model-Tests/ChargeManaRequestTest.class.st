Class {
	#name : #ChargeManaRequestTest,
	#superclass : #TurnContextTest,
	#category : #'DM-Match-Model-Tests'
}

{ #category : #tests }
ChargeManaRequestTest >> test01NonTurnPlayerCantChargeMana [

	| request mana |

	request := ChargeManaRequest chargingManaWith: self immortalBaronVorg.

	mana := match manaOf: self nonTurnPlayer.

	self
		should: [ turnContext execute: request requestedBy: self nonTurnPlayer ]
		raiseIllegalPlayFrom: self nonTurnPlayer
		because: 'You can''t Charge mana on your opponent''s turn.';
		assertCollection: ( match manaOf: self nonTurnPlayer ) equals: mana
]

{ #category : #tests }
ChargeManaRequestTest >> test02TurnPlayerCantChargeManaBeforeDrawingCard [

	| request mana |

	request := ChargeManaRequest chargingManaWith: self immortalBaronVorg.

	match endTurnOf: self turnPlayer.
	turnContext endTurn.

	mana := match manaOf: self turnPlayer.

	self
		should: [ turnContext execute: request requestedBy: self turnPlayer ]
		raiseIllegalPlayFrom: self turnPlayer
		because: 'You can''t Charge mana in the Draw Card Step.';
		assertCollection: ( match manaOf: self turnPlayer ) equals: mana
]

{ #category : #tests }
ChargeManaRequestTest >> test03ChargeManaOfTurnPlayer [

	| card request |

	card := self immortalBaronVorg.
	request := ChargeManaRequest chargingManaWith: card.

	self deny: ( match manaOf: self turnPlayer ) includes: card.
	turnContext execute: request requestedBy: self turnPlayer.
	self assert: ( match manaOf: self turnPlayer ) includes: card
]

{ #category : #tests }
ChargeManaRequestTest >> test04TurnPlayerCantChargeManaMoreThanOnceInTheSameTurn [

	| request mana |

	self test03ChargeManaOfTurnPlayer.

	request := ChargeManaRequest chargingManaWith: self immortalBaronVorg.

	mana := match manaOf: self turnPlayer.

	self
		should: [ turnContext execute: request requestedBy: self turnPlayer ]
		raiseIllegalPlayFrom: self turnPlayer
		because: 'Mana can only be charged once per turn.';
		assertCollection: ( match manaOf: self turnPlayer ) equals: mana
]

{ #category : #tests }
ChargeManaRequestTest >> test05PlayerCanChargeManaEveryTurn [

	self test03ChargeManaOfTurnPlayer.

	2 timesRepeat: [ 
		match endTurnOf: self turnPlayer.
		turnContext endTurn
		].

	turnContext
		execute: DrawCardRequest new requestedBy: self turnPlayer;
		changeCurrentStepTo: ChargeManaStep new.

	self test03ChargeManaOfTurnPlayer
]
