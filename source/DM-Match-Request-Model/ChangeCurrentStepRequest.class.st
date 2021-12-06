Class {
	#name : #ChangeCurrentStepRequest,
	#superclass : #MatchRequest,
	#instVars : [
		'turnStep'
	],
	#category : #'DM-Match-Request-Model'
}

{ #category : #accessing }
ChangeCurrentStepRequest class >> actionDescription [

	^ PlayerActionDescriptions changeCurrentStep
]

{ #category : #'instance creation' }
ChangeCurrentStepRequest class >> changingTo: aTurnStep [

	^ self new initializeChangingTo: aTurnStep
]

{ #category : #executing }
ChangeCurrentStepRequest >> executeOn: aMatch [

	aMatch changeCurrentStepTo: turnStep
]

{ #category : #initialization }
ChangeCurrentStepRequest >> initializeChangingTo: aTurnStep [

	turnStep := aTurnStep
]

{ #category : #testing }
ChangeCurrentStepRequest >> isAllowedIn: aStep [

	^ true
]
