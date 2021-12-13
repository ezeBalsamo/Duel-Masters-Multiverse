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
