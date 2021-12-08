Class {
	#name : #AttackCreatureRequestTest,
	#superclass : #MatchRequestTest,
	#category : #'DM-Match-Request-Model-Tests'
}

{ #category : #tests }
AttackCreatureRequestTest >> test01NonTurnPlayerCantAttackCreature [

	| request |

	request := AttackCreatureRequest attacking: self immortalBaronVorg with: self immortalBaronVorg.

	self should: [ match execute: request requestedBy: self nonTurnPlayer ]
		raiseIllegalPlayFrom: self nonTurnPlayer
		because: 'You can''t Attack a creature on your opponent''s turn.'
]

{ #category : #tests }
AttackCreatureRequestTest >> test02TurnPlayerCantAttackCreatureBeforeDrawingCard [

	| request |

	request := AttackCreatureRequest attacking: self immortalBaronVorg with: self immortalBaronVorg.

	match endTurnOf: self turnPlayer.

	self should: [ match execute: request requestedBy: self turnPlayer ]
		raiseIllegalPlayFrom: self turnPlayer
		because: 'You can''t Attack a creature in the Draw Card Step.'
]

{ #category : #tests }
AttackCreatureRequestTest >> test03TurnPlayerCantAttackCreatureInTheChargeManaStep [

	| request |

	request := AttackCreatureRequest attacking: self immortalBaronVorg with: self immortalBaronVorg.

	self should: [ match execute: request requestedBy: self turnPlayer ]
		raiseIllegalPlayFrom: self turnPlayer
		because: 'You can''t Attack a creature in the Charge Mana Step.'
]

{ #category : #tests }
AttackCreatureRequestTest >> test04TurnPlayerCantAttackCreatureInTheMainStep [

	| request |

	request := AttackCreatureRequest attacking: self immortalBaronVorg with: self immortalBaronVorg.

	self
		changeCurrentStepTo: MainStep new;
		should: [ match execute: request requestedBy: self turnPlayer ]
		raiseIllegalPlayFrom: self turnPlayer
		because: 'You can''t Attack a creature in the Main Step.'
]

{ #category : #tests }
AttackCreatureRequestTest >> test05TurnPlayerCantAttackCreatureWithNotSummonedCreature [

	| request |

	request := AttackCreatureRequest attacking: self vocalMegahit with: self immortalBaronVorg.

	self
		changeCurrentStepTo: AttackStep new;
		should: [ match execute: request requestedBy: self turnPlayer ]
		raiseIllegalPlayFrom: self turnPlayer
		because: 'You can''t attack with Immortal Baron, Vorg because it''s not summoned.'
]

{ #category : #tests }
AttackCreatureRequestTest >> test06TurnPlayerCantAttackCreatureWithNonBelongingCreature [

	| march tulkTheOracle request |

	march := self march.
	tulkTheOracle := self tulkTheOracle.

	request := AttackCreatureRequest attacking: self vocalMegahit with: tulkTheOracle.

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
AttackCreatureRequestTest >> test07TurnPlayerCantAttackCreatureWithCreatureThatHasSummoningSickness [

	| march tulkTheOracle request |

	march := self march.
	tulkTheOracle := self tulkTheOracle.

	request := AttackCreatureRequest attacking: self vocalMegahit with: tulkTheOracle.

	self
		chargeManaWith: march;
		changeCurrentStepTo: MainStep new;
		summon: tulkTheOracle tapping: march;
		changeCurrentStepTo: AttackStep new;
		should: [ match execute: request requestedBy: self turnPlayer ]
		raiseIllegalPlayFrom: self turnPlayer
		because: 'You can''t attack with Tulk, the Oracle because it has summoning sickness.'
]
