Class {
	#name : #SummonCreatureTest,
	#superclass : #TurnContextTest,
	#category : #'DM-Match-Model-Tests'
}

{ #category : #tests }
SummonCreatureTest >> test01NonTurnPlayerCantSummonCreature [

	| request |

	request := SummonCreatureRequest summoning: self immortalBaronVorg tappingAll: #(  ).

	self
		assertEmpty: ( match summonedCreaturesOf: self nonTurnPlayer );
		should: [ turnContext execute: request requestedBy: self nonTurnPlayer ]
		raiseIllegalPlayFrom: self nonTurnPlayer
		because: 'You can''t Summon a creature on your opponent''s turn.';
		assertEmpty: ( match summonedCreaturesOf: self nonTurnPlayer )
]
