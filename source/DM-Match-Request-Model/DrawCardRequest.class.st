Class {
	#name : #DrawCardRequest,
	#superclass : #DMRequest,
	#category : #'DM-Match-Request-Model'
}

{ #category : #accessing }
DrawCardRequest class >> actionDescription [

	^ PlayerActionDescriptions drawCard
]

{ #category : #executing }
DrawCardRequest >> executeOn: aMatch [

	aMatch drawCard
]
