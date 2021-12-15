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

{ #category : #tests }
EndTurnRequestTest >> test03TurnPlayerCantEndTurnBeforeDrawingCard [

	| request currentTurnPlayer currentNonTurnPlayer |

	self test02TurnPlayerEndsTurn.

	request := EndTurnRequest new.

	currentTurnPlayer := self turnPlayer.
	currentNonTurnPlayer := self nonTurnPlayer.

	self should: [ match execute: request requestedBy: self turnPlayer ]
		raiseIllegalPlayFrom: self turnPlayer
		because: 'You can''t End turn in the Draw Card Step.'.

	self
		assert: currentNonTurnPlayer equals: self nonTurnPlayer;
		assert: currentTurnPlayer equals: self turnPlayer
]
