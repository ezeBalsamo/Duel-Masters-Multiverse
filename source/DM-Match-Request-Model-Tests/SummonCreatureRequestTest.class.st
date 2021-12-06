Class {
	#name : #SummonCreatureRequestTest,
	#superclass : #MatchRequestTest,
	#category : #'DM-Match-Request-Model-Tests'
}

{ #category : #tests }
SummonCreatureRequestTest >> test01NonTurnPlayerCantSummonCreature [

	| request |

	request := SummonCreatureRequest summoning: self immortalBaronVorg tappingAll: #(  ).

	self
		assertEmpty: ( match summonedCreaturesOf: self nonTurnPlayer );
		should: [ match execute: request requestedBy: self nonTurnPlayer ]
		raiseIllegalPlayFrom: self nonTurnPlayer
		because: 'You can''t Summon a creature on your opponent''s turn.';
		assertEmpty: ( match summonedCreaturesOf: self nonTurnPlayer )
]

{ #category : #tests }
SummonCreatureRequestTest >> test02TurnPlayerCantSummonCreatureBeforeDrawingCard [

	| request |

	request := SummonCreatureRequest summoning: self immortalBaronVorg tappingAll: #(  ).

	match endTurnOf: self turnPlayer.

	self
		assertEmpty: ( match summonedCreaturesOf: self turnPlayer );
		should: [ match execute: request requestedBy: self turnPlayer ]
		raiseIllegalPlayFrom: self turnPlayer
		because: 'You can''t Summon a creature in the Draw Card Step.';
		assertEmpty: ( match summonedCreaturesOf: self turnPlayer )
]

{ #category : #tests }
SummonCreatureRequestTest >> test03TurnPlayerCantSummonCreatureInTheChargeManaStep [

	| request |

	request := SummonCreatureRequest summoning: self immortalBaronVorg tappingAll: #(  ).

	self
		assertEmpty: ( match summonedCreaturesOf: self turnPlayer );
		should: [ match execute: request requestedBy: self turnPlayer ]
		raiseIllegalPlayFrom: self turnPlayer
		because: 'You can''t Summon a creature in the Charge Mana Step.';
		assertEmpty: ( match summonedCreaturesOf: self turnPlayer )
]

{ #category : #tests }
SummonCreatureRequestTest >> test04TurnPlayerCantSummonCreatureWithoutTappingMana [

	| request |

	request := SummonCreatureRequest summoning: self immortalBaronVorg tappingAll: #(  ).

	self
		changeCurrentStepTo: MainStep new;
		assertEmpty: ( match summonedCreaturesOf: self turnPlayer );
		should: [ match execute: request requestedBy: self turnPlayer ]
		raiseIllegalPlayFrom: self turnPlayer
		because: 'You can''t Summon a creature without tapping mana.';
		assertEmpty: ( match summonedCreaturesOf: self turnPlayer )
]
