Class {
	#name : #SummonCreatureRequest,
	#superclass : #DMRequest,
	#instVars : [
		'creatureToSummon',
		'cardsToTap'
	],
	#category : #'DM-Match-Request-Model'
}

{ #category : #accessing }
SummonCreatureRequest class >> actionDescription [

	^ PlayerActionDescriptions summonCreature
]

{ #category : #'instance creation' }
SummonCreatureRequest class >> summoning: aCreatureCard tappingAll: aCardCollection [

	^ self new initializeSummoning: aCreatureCard tappingAll: aCardCollection
]

{ #category : #accessing }
SummonCreatureRequest >> cardsToTap [

	^ cardsToTap
]

{ #category : #executing }
SummonCreatureRequest >> executeOn: aMatch [

	aMatch summon: creatureToSummon of: aMatch currentPlayer tappingAll: self cardsToTap
]

{ #category : #initialization }
SummonCreatureRequest >> initializeSummoning: aCreatureCard tappingAll: aCardCollection [

	creatureToSummon := aCreatureCard.
	cardsToTap := aCardCollection
]
