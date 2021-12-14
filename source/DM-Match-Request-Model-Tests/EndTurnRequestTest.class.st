Class {
	#name : #EndTurnRequestTest,
	#superclass : #MatchRequestTest,
	#category : #'DM-Match-Request-Model-Tests'
}

{ #category : #tests }
EndTurnRequestTest >> test01NonTurnPlayerCantEndTurn [

	| request |

	request := EndTurnRequest new.

	self should: [ match execute: request requestedBy: self nonTurnPlayer ]
		raiseIllegalPlayFrom: self nonTurnPlayer
		because: 'You can''t End turn on your opponent''s turn.'
]

{ #category : #tests }
EndTurnRequestTest >> test02TurnPlayerEndsTurn [

	| request currentTurnPlayer currentNonTurnPlayer |

	request := EndTurnRequest new.

	currentTurnPlayer := self turnPlayer.
	currentNonTurnPlayer := self nonTurnPlayer.

	match execute: request requestedBy: self turnPlayer.

	self
		assert: currentNonTurnPlayer equals: self turnPlayer;
		assert: currentTurnPlayer equals: self nonTurnPlayer
]
