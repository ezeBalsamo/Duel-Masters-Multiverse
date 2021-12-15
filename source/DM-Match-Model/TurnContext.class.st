Class {
	#name : #TurnContext,
	#superclass : #Object,
	#instVars : [
		'match',
		'canCardBeDrawn',
		'currentStep',
		'canManaBeCharged',
		'creaturesThatHaveSummoningSickness'
	],
	#category : #'DM-Match-Model'
}

{ #category : #'instance creation' }
TurnContext class >> within: aMatch [

	^ self new initializeWithin: aMatch
]

{ #category : #testing }
TurnContext >> canManaBeCharged [

	^ canManaBeCharged
]

{ #category : #processing }
TurnContext >> changeCurrentStepTo: aTurnStep [

	currentStep := aTurnStep
]

{ #category : #processing }
TurnContext >> creatureWasSummoned: aCreatureCard [

	creaturesThatHaveSummoningSickness add: aCreatureCard
]

{ #category : #accessing }
TurnContext >> creaturesThatHaveSummoningSickness [

	^ creaturesThatHaveSummoningSickness
]

{ #category : #accessing }
TurnContext >> currentStep [

	^ currentStep
]

{ #category : #processing }
TurnContext >> endTurn [

	creaturesThatHaveSummoningSickness removeAll.

	self
		changeCurrentStepTo: DrawCardStep new;
		manaCanBeCharged
]

{ #category : #testing }
TurnContext >> hasSummoningSickness: aCreatureCard [

	^ creaturesThatHaveSummoningSickness includes: aCreatureCard
]

{ #category : #initialization }
TurnContext >> initializeWithin: aMatch [

	match := aMatch.
	creaturesThatHaveSummoningSickness := OrderedCollection new.

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
