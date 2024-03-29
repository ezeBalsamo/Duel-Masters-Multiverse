Class {
	#name : #DirectAttackRequestTest,
	#superclass : #MatchRequestTest,
	#category : #'DM-Match-Request-Model-Tests'
}

{ #category : #tests }
DirectAttackRequestTest >> test01NonTurnPlayerCantAttackDirectly [

	| request |

	request := DirectAttackRequest attackingWith: self immortalBaronVorg.

	self should: [ match execute: request requestedBy: self nonTurnPlayer ]
		raiseIllegalPlayFrom: self nonTurnPlayer
		because: 'You can''t Direct attack on your opponent''s turn.'
]

{ #category : #tests }
DirectAttackRequestTest >> test02TurnPlayerCantAttackDirectlyBeforeDrawingCard [

	| request |

	request := DirectAttackRequest attackingWith: self immortalBaronVorg.

	self endTurn.

	self should: [ match execute: request requestedBy: self turnPlayer ]
		raiseIllegalPlayFrom: self turnPlayer
		because: 'You can''t Direct attack in the Draw Card Step.'
]

{ #category : #tests }
DirectAttackRequestTest >> test03TurnPlayerCantAttackDirectlyInTheChargeManaStep [

	| request |

	request := DirectAttackRequest attackingWith: self immortalBaronVorg.

	self should: [ match execute: request requestedBy: self turnPlayer ]
		raiseIllegalPlayFrom: self turnPlayer
		because: 'You can''t Direct attack in the Charge Mana Step.'
]

{ #category : #tests }
DirectAttackRequestTest >> test04TurnPlayerCantAttackDirectlyInTheMainStep [

	| request |

	request := DirectAttackRequest attackingWith: self immortalBaronVorg.

	self
		changeCurrentStepTo: MainStep new;
		should: [ match execute: request requestedBy: self turnPlayer ]
		raiseIllegalPlayFrom: self turnPlayer
		because: 'You can''t Direct attack in the Main Step.'
]

{ #category : #tests }
DirectAttackRequestTest >> test05TurnPlayerCantAttackDirectlyWithNotSummonedCreature [

	| request |

	request := DirectAttackRequest attackingWith: self immortalBaronVorg.

	self
		changeCurrentStepTo: AttackStep new;
		should: [ match execute: request requestedBy: self turnPlayer ]
		raiseIllegalPlayFrom: self turnPlayer
		because: 'You can''t attack with Immortal Baron, Vorg because it''s not summoned.'
]

{ #category : #tests }
DirectAttackRequestTest >> test06TurnPlayerCantAttackDirectlyWithNonBelongingCreature [

	| march tulkTheOracle request |

	march := self march.
	tulkTheOracle := self tulkTheOracle.

	request := DirectAttackRequest attackingWith: tulkTheOracle.

	self
		chargeManaWith: march;
		changeCurrentStepTo: MainStep new;
		summon: tulkTheOracle tapping: march;
		endTurn;
		changeCurrentStepTo: AttackStep new;
		should: [ match execute: request requestedBy: self turnPlayer ]
		raiseIllegalPlayFrom: self turnPlayer
		because: 'You can''t attack with Tulk, the Oracle because it''s not yours.'
]

{ #category : #tests }
DirectAttackRequestTest >> test07TurnPlayerCantAttackDirectlyWithCreatureThatHasSummoningSickness [

	| march tulkTheOracle request |

	march := self march.
	tulkTheOracle := self tulkTheOracle.

	request := DirectAttackRequest attackingWith: tulkTheOracle.

	self
		chargeManaWith: march;
		changeCurrentStepTo: MainStep new;
		summon: tulkTheOracle tapping: march;
		changeCurrentStepTo: AttackStep new;
		should: [ match execute: request requestedBy: self turnPlayer ]
		raiseIllegalPlayFrom: self turnPlayer
		because: 'You can''t attack with Tulk, the Oracle because it has summoning sickness.'
]

{ #category : #tests }
DirectAttackRequestTest >> test08TurnPlayerAttacksDirectly [

	| march tulkTheOracle request |

	march := self march.
	tulkTheOracle := self tulkTheOracle.

	request := DirectAttackRequest attackingWith: tulkTheOracle.

	self
		chargeManaWith: march;
		changeCurrentStepTo: MainStep new;
		summon: tulkTheOracle tapping: march;
		endTurn;
		changeCurrentStepTo: DrawCardStep new;
		drawCard;
		changeCurrentStepTo: ChargeManaStep new;
		endTurn;
		changeCurrentStepTo: AttackStep new;
		assert: ( match shieldsOf: self nonTurnPlayer ) size equals: 5;
		assert: ( match numberOfCardsInHandOf: self nonTurnPlayer ) equals: 6;
		assertEmpty: ( match tappedCreaturesOf: self turnPlayer ).

	match execute: request requestedBy: self turnPlayer.

	self
		assert: ( match shieldsOf: self nonTurnPlayer ) size equals: 4;
		assert: ( match numberOfCardsInHandOf: self nonTurnPlayer ) equals: 7;
		assertTheOnlyOneIn: ( match tappedCreaturesOf: self turnPlayer ) is: tulkTheOracle
]

{ #category : #tests }
DirectAttackRequestTest >> test09TurnPlayerCantAttackDirectlyWithTappedCreature [

	| numberOfShields numberOfCardsInHand tappedCreatures attackingCreature request |

	self test08TurnPlayerAttacksDirectly.

	numberOfShields := ( match shieldsOf: self nonTurnPlayer ) size.
	numberOfCardsInHand := match numberOfCardsInHandOf: self nonTurnPlayer.
	tappedCreatures := match tappedCreaturesOf: self turnPlayer.
	attackingCreature := tappedCreatures anyOne.

	request := DirectAttackRequest attackingWith: attackingCreature.

	self should: [ match execute: request requestedBy: self turnPlayer ]
		raiseIllegalPlayFrom: self turnPlayer
		because:
		( 'You can''t attack with <1p> because it''s tapped.' expandMacrosWith: attackingCreature ).

	self
		assert: ( match shieldsOf: self nonTurnPlayer ) size equals: numberOfShields;
		assert: ( match numberOfCardsInHandOf: self nonTurnPlayer ) equals: numberOfCardsInHand;
		assertCollection: ( match tappedCreaturesOf: self turnPlayer ) hasSameElements: tappedCreatures
]
