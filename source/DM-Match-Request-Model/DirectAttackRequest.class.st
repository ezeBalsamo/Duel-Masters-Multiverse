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

	^ PlayerActionDescriptions attack
]

{ #category : #'instance creation' }
DirectAttackRequest class >> attackingWith: aCreatureCard [

	^ self new initializeAttackingWith: aCreatureCard
]

{ #category : #initialization }
DirectAttackRequest >> initializeAttackingWith: aCreatureCard [

	creatureCard := aCreatureCard
]
