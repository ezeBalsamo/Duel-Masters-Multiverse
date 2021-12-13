Class {
	#name : #BattleResolver,
	#superclass : #Object,
	#instVars : [
		'match'
	],
	#category : #'DM-Match-Model'
}

{ #category : #'instance creation' }
BattleResolver class >> workingWith: aMatch [

	^ self new initializeWorkingWith: aMatch
]

{ #category : #initialization }
BattleResolver >> initializeWorkingWith: aMatch [

	match := aMatch
]

{ #category : #processing }
BattleResolver >> resolveBattleBetween: aCreatureCard of: aPlayer and: anOpponentCreatureCard of: anOpponentPlayer [

	| creaturePower opponentCreaturePower |

	creaturePower := aCreatureCard power.
	opponentCreaturePower := anOpponentCreatureCard power.

	creaturePower > opponentCreaturePower then: [ 
		match destroy: anOpponentCreatureCard of: anOpponentPlayer ]
		otherwise: [ 
			creaturePower = opponentCreaturePower
				then: [ 
					match
						destroy: aCreatureCard of: aPlayer;
						destroy: anOpponentCreatureCard of: anOpponentPlayer
					]
				otherwise: [ match destroy: aCreatureCard of: aPlayer ]
			]
]
