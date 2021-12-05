Class {
	#name : #DrawCardRequest,
	#superclass : #Object,
	#category : #'DM-Match-Request-Model'
}

{ #category : #accessing }
DrawCardRequest >> actionDescription [

	^ 'Draw Card'
]

{ #category : #executing }
DrawCardRequest >> executeOn: aMatch [

	aMatch drawCardFor: aMatch currentPlayer
]
