Class {
	#name : #SummonCreatureRequest,
	#superclass : #MatchRequest,
	#instVars : [
		'creatureToSummon',
		'cardsToTap'
	],
	#category : #'DM-Match-Request-Model'
}

{ #category : #'instance creation' }
SummonCreatureRequest class >> summoning: aCreatureCard tappingAll: aCardCollection [

	^ self new initializeSummoning: aCreatureCard tappingAll: aCardCollection
]

{ #category : #accessing }
SummonCreatureRequest >> cardsToTap [

	^ cardsToTap
]

{ #category : #initialization }
SummonCreatureRequest >> initializeSummoning: aCreatureCard tappingAll: aCardCollection [

	creatureToSummon := aCreatureCard.
	cardsToTap := aCardCollection
]
