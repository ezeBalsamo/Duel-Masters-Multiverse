Class {
	#name : #SummonCreatureRequestTest,
	#superclass : #TurnContextTest,
	#category : #'DM-Match-Model-Tests'
}

{ #category : #tests }
SummonCreatureRequestTest >> test01NonTurnPlayerCantSummonCreature [

	| request |

	request := SummonCreatureRequest summoning: self immortalBaronVorg tappingAll: #(  ).

	self
		assertEmpty: ( match summonedCreaturesOf: self nonTurnPlayer );
		should: [ turnContext execute: request requestedBy: self nonTurnPlayer ]
		raiseIllegalPlayFrom: self nonTurnPlayer
		because: 'You can''t Summon a creature on your opponent''s turn.';
		assertEmpty: ( match summonedCreaturesOf: self nonTurnPlayer )
]

{ #category : #tests }
SummonCreatureRequestTest >> test02TurnPlayerCantSummonCreatureBeforeDrawingCard [

	| request |

	request := SummonCreatureRequest summoning: self immortalBaronVorg tappingAll: #(  ).

	match endTurnOf: self turnPlayer.
	turnContext endTurn.

	self
		assertEmpty: ( match summonedCreaturesOf: self turnPlayer );
		should: [ turnContext execute: request requestedBy: self turnPlayer ]
		raiseIllegalPlayFrom: self turnPlayer
		because: 'You can''t Summon a creature in the Draw Card Step.';
		assertEmpty: ( match summonedCreaturesOf: self turnPlayer )
]
