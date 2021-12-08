Class {
	#name : #AttackStep,
	#superclass : #TurnStep,
	#category : #'DM-Step-Model'
}

{ #category : #'private - accessing' }
AttackStep >> allowedActionDescriptions [

	^ super allowedActionDescriptions
		  add: PlayerActionDescriptions directAttack;
		  add: PlayerActionDescriptions attackCreature;
		  yourself
]

{ #category : #'private - accessing' }
AttackStep >> stepName [

	^ 'Attack'
]
