Class {
	#name : #TurnContext,
	#superclass : #Object,
	#instVars : [
		'match',
		'canCardBeDrawn',
		'currentStep',
		'canManaBeCharged',
		'creaturesHavingSummoningSickness'
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

{ #category : #accessing }
TurnContext >> creaturesHavingSummoningSickness [

	^ creaturesHavingSummoningSickness
]

{ #category : #accessing }
TurnContext >> currentStep [

	^ currentStep
]

{ #category : #processing }
TurnContext >> endTurn [

	creaturesHavingSummoningSickness removeAll.

	self
		changeCurrentStepTo: DrawCardStep new;
		manaCanBeCharged
]

{ #category : #processing }
TurnContext >> hasBeenSummoned: aCreatureCard [

	creaturesHavingSummoningSickness add: aCreatureCard
]

{ #category : #testing }
TurnContext >> hasSummoningSickness: aCreatureCard [

	^ creaturesHavingSummoningSickness includes: aCreatureCard
]

{ #category : #initialization }
TurnContext >> initializeWithin: aMatch [

	match := aMatch.
	creaturesHavingSummoningSickness := OrderedCollection new.

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
