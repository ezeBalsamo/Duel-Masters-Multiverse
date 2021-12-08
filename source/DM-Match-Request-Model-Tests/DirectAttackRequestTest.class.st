Class {
	#name : #DirectAttackRequestTest,
	#superclass : #MatchRequestTest,
	#category : #'DM-Match-Request-Model-Tests'
}

{ #category : #tests }
DirectAttackRequestTest >> test01NonTurnPlayerCantAttack [

	| request |

	request := DirectAttackRequest attackingWith: self immortalBaronVorg.

	self should: [ match execute: request requestedBy: self nonTurnPlayer ]
		raiseIllegalPlayFrom: self nonTurnPlayer
		because: 'You can''t Attack on your opponent''s turn.'
]

{ #category : #tests }
DirectAttackRequestTest >> test02TurnPlayerCantAttackBeforeDrawingCard [

	| request |

	request := DirectAttackRequest attackingWith: self immortalBaronVorg.

	match endTurnOf: self turnPlayer.

	self should: [ match execute: request requestedBy: self turnPlayer ]
		raiseIllegalPlayFrom: self turnPlayer
		because: 'You can''t Attack in the Draw Card Step.'
]

{ #category : #tests }
DirectAttackRequestTest >> test03TurnPlayerCantAttackInTheChargeManaStep [

	| request |

	request := DirectAttackRequest attackingWith: self immortalBaronVorg.

	self should: [ match execute: request requestedBy: self turnPlayer ]
		raiseIllegalPlayFrom: self turnPlayer
		because: 'You can''t Attack in the Charge Mana Step.'
]

{ #category : #tests }
DirectAttackRequestTest >> test04TurnPlayerCantAttackInTheMainStep [

	| request |

	request := DirectAttackRequest attackingWith: self immortalBaronVorg.

	self
		changeCurrentStepTo: MainStep new;
		should: [ match execute: request requestedBy: self turnPlayer ]
		raiseIllegalPlayFrom: self turnPlayer
		because: 'You can''t Attack in the Main Step.'
]

{ #category : #tests }
DirectAttackRequestTest >> test05TurnPlayerCantAttackWithNotSummonedCreature [

	| request |

	request := DirectAttackRequest attackingWith: self immortalBaronVorg.

	self
		changeCurrentStepTo: AttackStep new;
		should: [ match execute: request requestedBy: self turnPlayer ]
		raiseIllegalPlayFrom: self turnPlayer
		because: 'You can''t Attack with Immortal Baron, Vorg because it''s not summoned.'
]
