Class {
	#name : #MainStep,
	#superclass : #TurnStep,
	#category : #'DM-Step-Model'
}

{ #category : #'private - accessing' }
MainStep >> allowedActionDescriptions [

	^ { PlayerActionDescriptions summonCreature }
]

{ #category : #'private - accessing' }
MainStep >> stepName [

	^ 'Main'
]
