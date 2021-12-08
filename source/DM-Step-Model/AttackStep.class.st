Class {
	#name : #AttackStep,
	#superclass : #TurnStep,
	#category : #'DM-Step-Model'
}

{ #category : #'private - accessing' }
AttackStep >> allowedActionDescriptions [

	^ super allowedActionDescriptions
		  add: PlayerActionDescriptions attack;
		  yourself
]

{ #category : #'private - accessing' }
AttackStep >> stepName [

	^ 'Attack'
]
