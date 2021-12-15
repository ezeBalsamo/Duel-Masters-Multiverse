Class {
	#name : #AttackCreatureRequest,
	#superclass : #DMRequest,
	#instVars : [
		'opponentCreatureCard',
		'creatureCard'
	],
	#category : #'DM-Match-Request-Model'
}

{ #category : #accessing }
AttackCreatureRequest class >> actionDescription [

	^PlayerActionDescriptions attackCreature
]

{ #category : #'instance creation' }
AttackCreatureRequest class >> attacking: anOpponentCreatureCard with: aCreatureCard [

	^ self new initializeAttacking: anOpponentCreatureCard with: aCreatureCard
]

{ #category : #executing }
AttackCreatureRequest >> executeOn: aMatch [

	aMatch attack: opponentCreatureCard with: creatureCard
]

{ #category : #initialization }
AttackCreatureRequest >> initializeAttacking: anOpponentCreatureCard with: aCreatureCard [

	opponentCreatureCard := anOpponentCreatureCard.
	creatureCard := aCreatureCard
]
