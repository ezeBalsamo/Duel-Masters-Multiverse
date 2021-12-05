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
		because: 'You can''t Charge Mana on your opponent''s turn.';
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
		because: 'You can''t Charge Mana in the Draw Card Step.';
		assertCollection: ( match manaOf: self turnPlayer ) equals: mana
]

{ #category : #tests }
ChargeManaRequestTest >> test03ChargeManaOfTurnPlayer [

	| card request |

	card := self immortalBaronVorg.
	request := ChargeManaRequest chargingManaWith: card.

	self assertEmpty: ( match manaOf: self turnPlayer ).
	turnContext execute: request requestedBy: self turnPlayer.
	self assertTheOnlyOneIn: ( match manaOf: self turnPlayer ) is: card
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
