Class {
	#name : #DrawCardStep,
	#superclass : #TurnStep,
	#category : #'DM-Step-Model'
}

{ #category : #'private - accessing' }
DrawCardStep >> allowedActionDescriptions [

	^ super allowedActionDescriptions
		  add: PlayerActionDescriptions drawCard;
		  yourself
]

{ #category : #'private - accessing' }
DrawCardStep >> stepName [

	^ 'Draw Card'
]
