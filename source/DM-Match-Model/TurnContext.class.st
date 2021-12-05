Class {
	#name : #TurnContext,
	#superclass : #Object,
	#instVars : [
		'match'
	],
	#category : #'DM-Match-Model'
}

{ #category : #'instance creation' }
TurnContext class >> within: aMatch [

	^ self new initializeWithin: aMatch
]

{ #category : #executing }
TurnContext >> execute: aRequest requestedBy: aPlayer [

	IllegalPlay from: aPlayer because: 'You can''t Draw Card in the Charge Mana Step.'
]

{ #category : #initialization }
TurnContext >> initializeWithin: aMatch [

	match := aMatch
]
