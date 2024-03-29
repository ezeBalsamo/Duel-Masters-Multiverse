Class {
	#name : #EndTurnRequest,
	#superclass : #DMRequest,
	#category : #'DM-Match-Request-Model'
}

{ #category : #accessing }
EndTurnRequest class >> actionDescription [

	^ PlayerActionDescriptions endTurn
]

{ #category : #executing }
EndTurnRequest >> executeOn: aMatch [

	aMatch endTurn
]
