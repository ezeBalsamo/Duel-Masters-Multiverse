Class {
	#name : #TurnContext,
	#superclass : #Object,
	#instVars : [
		'match',
		'hasFirstTurnEnded'
	],
	#category : #'DM-Match-Model'
}

{ #category : #'instance creation' }
TurnContext class >> within: aMatch [

	^ self new initializeWithin: aMatch
]

{ #category : #processing }
TurnContext >> endTurn [

	hasFirstTurnEnded := true
]

{ #category : #executing }
TurnContext >> execute: aRequest requestedBy: aPlayer [

	[ IllegalPlay from: aPlayer because: 'You can''t Draw Card on your opponent''s turn.' ] unless:
		match currentPlayer = aPlayer.

	[ IllegalPlay from: aPlayer because: 'You can''t Draw Card in the Charge Mana Step.' ] unless:
		hasFirstTurnEnded
		inWhichCase: [ aRequest executeOn: match ]
]

{ #category : #initialization }
TurnContext >> initializeWithin: aMatch [

	match := aMatch.
	hasFirstTurnEnded := false
]
