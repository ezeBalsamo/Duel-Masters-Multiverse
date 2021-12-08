Class {
	#name : #DirectAttackRequest,
	#superclass : #DMRequest,
	#instVars : [
		'creatureCard'
	],
	#category : #'DM-Match-Request-Model'
}

{ #category : #accessing }
DirectAttackRequest class >> actionDescription [

	^ PlayerActionDescriptions directAttack
]

{ #category : #'instance creation' }
DirectAttackRequest class >> attackingWith: aCreatureCard [

	^ self new initializeAttackingWith: aCreatureCard
]

{ #category : #executing }
DirectAttackRequest >> executeOn: aMatch [

	aMatch directAttackFrom: creatureCard
]

{ #category : #initialization }
DirectAttackRequest >> initializeAttackingWith: aCreatureCard [

	creatureCard := aCreatureCard
]
