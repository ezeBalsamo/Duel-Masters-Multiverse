Class {
	#name : #DrawCardRequest,
	#superclass : #MatchRequest,
	#category : #'DM-Match-Request-Model'
}

{ #category : #accessing }
DrawCardRequest class >> actionDescription [

	^ PlayerActionDescriptions drawCard
]

{ #category : #executing }
DrawCardRequest >> executeOn: aMatch [

	aMatch drawCardFor: aMatch currentPlayer
]
