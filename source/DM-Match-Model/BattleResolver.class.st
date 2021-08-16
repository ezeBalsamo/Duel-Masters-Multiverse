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
BattleResolver >> resolveBattleBetween: aCreatureCard of: aDuelist and: anOpponentCreatureCard of: anOpponentDuelist [

	| creaturePower opponentCreaturePower |

	creaturePower := aCreatureCard power.
	opponentCreaturePower := anOpponentCreatureCard power.

	creaturePower > opponentCreaturePower
		then: [ match destroy: anOpponentCreatureCard of: anOpponentDuelist ]
		otherwise: [ creaturePower = opponentCreaturePower
				then: [ match
						destroy: aCreatureCard of: aDuelist;
						destroy: anOpponentCreatureCard of: anOpponentDuelist
					]
				otherwise: [ match destroy: aCreatureCard of: aDuelist ]
			]
]
