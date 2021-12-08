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
