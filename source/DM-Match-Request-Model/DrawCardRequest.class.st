Class {
	#name : #DrawCardRequest,
	#superclass : #Object,
	#category : #'DM-Match-Request-Model'
}

{ #category : #accessing }
DrawCardRequest class >> actionDescription [

	^ 'Draw Card'
]

{ #category : #accessing }
DrawCardRequest >> actionDescription [

	^ self class actionDescription
]

{ #category : #executing }
DrawCardRequest >> executeOn: aMatch [

	aMatch drawCardFor: aMatch currentPlayer
]

{ #category : #testing }
DrawCardRequest >> isAllowedIn: aStep [

	^ aStep allows: self
]
