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
