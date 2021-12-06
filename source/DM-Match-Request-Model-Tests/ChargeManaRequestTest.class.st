Class {
	#name : #ChargeManaRequestTest,
	#superclass : #MatchRequestTest,
	#category : #'DM-Match-Request-Model-Tests'
}

{ #category : #tests }
ChargeManaRequestTest >> test01NonTurnPlayerCantChargeMana [

	| request |

	request := ChargeManaRequest chargingManaWith: self immortalBaronVorg.

	self
		should: [ match execute: request requestedBy: self nonTurnPlayer ]
		raiseIllegalPlayFrom: self nonTurnPlayer
		because: 'You can''t Charge mana on your opponent''s turn.';
		assertEmpty: ( match manaOf: self nonTurnPlayer )
]

{ #category : #tests }
ChargeManaRequestTest >> test02TurnPlayerCantChargeManaBeforeDrawingCard [

	| request |

	request := ChargeManaRequest chargingManaWith: self immortalBaronVorg.

	match endTurnOf: self turnPlayer.

	self
		should: [ match execute: request requestedBy: self turnPlayer ]
		raiseIllegalPlayFrom: self turnPlayer
		because: 'You can''t Charge mana in the Draw Card Step.';
		assertEmpty: ( match manaOf: self turnPlayer )
]

{ #category : #tests }
ChargeManaRequestTest >> test03ChargeManaOfTurnPlayer [

	| card request |

	card := self immortalBaronVorg.
	request := ChargeManaRequest chargingManaWith: card.

	self deny: ( match manaOf: self turnPlayer ) includes: card.
	match execute: request requestedBy: self turnPlayer.
	self assert: ( match manaOf: self turnPlayer ) includes: card
]

{ #category : #tests }
ChargeManaRequestTest >> test04TurnPlayerCantChargeManaMoreThanOnceInTheSameTurn [

	| request mana |

	self test03ChargeManaOfTurnPlayer.

	request := ChargeManaRequest chargingManaWith: self immortalBaronVorg.

	mana := match manaOf: self turnPlayer.

	self
		should: [ match execute: request requestedBy: self turnPlayer ]
		raiseIllegalPlayFrom: self turnPlayer
		because: 'Mana can only be charged once per turn.';
		assertCollection: ( match manaOf: self turnPlayer ) equals: mana
]

{ #category : #tests }
ChargeManaRequestTest >> test05PlayerCanChargeManaEveryTurn [

	self test03ChargeManaOfTurnPlayer.

	2 timesRepeat: [ match endTurnOf: self turnPlayer ].

	match execute: DrawCardRequest new requestedBy: self turnPlayer.
	self changeCurrentStepTo: ChargeManaStep new.

	self test03ChargeManaOfTurnPlayer
]
