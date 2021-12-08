Class {
	#name : #DirectAttackRequestTest,
	#superclass : #MatchRequestTest,
	#category : #'DM-Match-Request-Model-Tests'
}

{ #category : #tests }
DirectAttackRequestTest >> test01NonTurnPlayerCantAttack [

	| request |

	request := DirectAttackRequest attackingWith: self immortalBaronVorg.

	self
		should: [ match execute: request requestedBy: self nonTurnPlayer ]
		raiseIllegalPlayFrom: self nonTurnPlayer
		because: 'You can''t Attack on your opponent''s turn.';
		assertEmpty: ( match summonedCreaturesOf: self nonTurnPlayer )
]
