Class {
	#name : #TurnContext,
	#superclass : #Object,
	#instVars : [
		'match',
		'canCardBeDrawn',
		'currentStep',
		'canManaBeCharged'
	],
	#category : #'DM-Match-Model'
}

{ #category : #'instance creation' }
TurnContext class >> within: aMatch [

	^ self new initializeWithin: aMatch
]

{ #category : #testing }
TurnContext >> canCardBeDrawn [

	^ match canCardBeDrawn
]

{ #category : #testing }
TurnContext >> canManaBeCharged [

	^ canManaBeCharged
]

{ #category : #processing }
TurnContext >> changeCurrentStepTo: aTurnStep [

	currentStep := aTurnStep
]

{ #category : #accessing }
TurnContext >> currentPlayer [

	^ match currentPlayer
]

{ #category : #accessing }
TurnContext >> currentStep [

	^ currentStep
]

{ #category : #processing }
TurnContext >> endTurn [

	self
		changeCurrentStepTo: DrawCardStep new;
		manaCanBeCharged
]

{ #category : #executing }
TurnContext >> execute: aRequest requestedBy: aPlayer [

	( RequestExecutionAssertion for: aRequest requestedBy: aPlayer workingWith: self ) assert.

	aRequest executeOn: match
]

{ #category : #initialization }
TurnContext >> initializeWithin: aMatch [

	match := aMatch.

	self
		manaCanBeCharged;
		changeCurrentStepTo: ChargeManaStep new
]

{ #category : #initialization }
TurnContext >> manaCanBeCharged [

	canManaBeCharged := true
]

{ #category : #processing }
TurnContext >> manaHasBeenCharged [

	canManaBeCharged := false
]
