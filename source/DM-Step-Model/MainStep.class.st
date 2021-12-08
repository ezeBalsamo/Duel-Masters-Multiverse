Class {
	#name : #MainStep,
	#superclass : #TurnStep,
	#category : #'DM-Step-Model'
}

{ #category : #'private - accessing' }
MainStep >> allowedActionDescriptions [

	^ super allowedActionDescriptions
		  add: PlayerActionDescriptions summonCreature;
		  yourself
]

{ #category : #'private - accessing' }
MainStep >> stepName [

	^ 'Main'
]
