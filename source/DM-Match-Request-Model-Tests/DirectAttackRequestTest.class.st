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
