Class {
	#name : #TurnContext,
	#superclass : #Object,
	#instVars : [
		'match',
		'canCardBeDrawn',
		'currentStep'
	],
	#category : #'DM-Match-Model'
}

{ #category : #'instance creation' }
TurnContext class >> within: aMatch [

	^ self new initializeWithin: aMatch
]

{ #category : #processing }
TurnContext >> changeCurrentStepTo: aTurnStep [

	currentStep := aTurnStep
]

{ #category : #processing }
TurnContext >> endTurn [

	canCardBeDrawn := true.
	currentStep := DrawCardStep new
]

{ #category : #executing }
TurnContext >> execute: aRequest requestedBy: aPlayer [

	[ 
	IllegalPlay from: aPlayer
		because:
		( 'You can''t <1s> on your opponent''s turn.' expandMacrosWith: aRequest actionDescription )
	] unless: match currentPlayer = aPlayer.

	[ 
	IllegalPlay from: aPlayer
		because:
		( 'You can''t <1s> in the <2p>.' expandMacrosWith: aRequest actionDescription with: currentStep )
	] unless: ( aRequest isAllowedIn: currentStep ) inWhichCase: [ aRequest executeOn: match ].

	canCardBeDrawn := false
]

{ #category : #initialization }
TurnContext >> initializeWithin: aMatch [

	match := aMatch.
	canCardBeDrawn := false.
	currentStep := ChargeManaStep new
]
