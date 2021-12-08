Class {
	#name : #DirectAttackRequestTest,
	#superclass : #MatchRequestTest,
	#category : #'DM-Match-Request-Model-Tests'
}

{ #category : #tests }
DirectAttackRequestTest >> test01NonTurnPlayerCantDirectAttack [

	| request |

	request := DirectAttackRequest attackingWith: self immortalBaronVorg.

	self should: [ match execute: request requestedBy: self nonTurnPlayer ]
		raiseIllegalPlayFrom: self nonTurnPlayer
		because: 'You can''t Direct attack on your opponent''s turn.'
]

{ #category : #tests }
DirectAttackRequestTest >> test02TurnPlayerCantDirectAttackBeforeDrawingCard [

	| request |

	request := DirectAttackRequest attackingWith: self immortalBaronVorg.

	match endTurnOf: self turnPlayer.

	self should: [ match execute: request requestedBy: self turnPlayer ]
		raiseIllegalPlayFrom: self turnPlayer
		because: 'You can''t Direct attack in the Draw Card Step.'
]

{ #category : #tests }
DirectAttackRequestTest >> test03TurnPlayerCantDirectAttackInTheChargeManaStep [

	| request |

	request := DirectAttackRequest attackingWith: self immortalBaronVorg.

	self should: [ match execute: request requestedBy: self turnPlayer ]
		raiseIllegalPlayFrom: self turnPlayer
		because: 'You can''t Direct attack in the Charge Mana Step.'
]

{ #category : #tests }
DirectAttackRequestTest >> test04TurnPlayerCantDirectAttackInTheMainStep [

	| request |

	request := DirectAttackRequest attackingWith: self immortalBaronVorg.

	self
		changeCurrentStepTo: MainStep new;
		should: [ match execute: request requestedBy: self turnPlayer ]
		raiseIllegalPlayFrom: self turnPlayer
		because: 'You can''t Direct attack in the Main Step.'
]

{ #category : #tests }
DirectAttackRequestTest >> test05TurnPlayerCantDirectAttackWithNotSummonedCreature [

	| request |

	request := DirectAttackRequest attackingWith: self immortalBaronVorg.

	self
		changeCurrentStepTo: AttackStep new;
		should: [ match execute: request requestedBy: self turnPlayer ]
		raiseIllegalPlayFrom: self turnPlayer
		because: 'You can''t Direct attack with Immortal Baron, Vorg because it''s not summoned.'
]
