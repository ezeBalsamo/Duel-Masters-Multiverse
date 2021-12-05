Class {
	#name : #DrawCardStep,
	#superclass : #TurnStep,
	#category : #'DM-Step-Model'
}

{ #category : #'private - accessing' }
DrawCardStep >> allowedActionDescriptions [

	^ { PlayerActionDescriptions drawCard }
]

{ #category : #'private - accessing' }
DrawCardStep >> stepName [

	^ 'Draw Card'
]
