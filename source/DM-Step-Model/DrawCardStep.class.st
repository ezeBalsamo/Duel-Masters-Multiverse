Class {
	#name : #DrawCardStep,
	#superclass : #TurnStep,
	#category : #'DM-Step-Model'
}

{ #category : #'private - accessing' }
DrawCardStep >> allowedActionDescriptions [

	^ super allowedActionDescriptions
		  remove: PlayerActionDescriptions endTurn;
		  add: PlayerActionDescriptions drawCard;
		  yourself
]

{ #category : #'private - accessing' }
DrawCardStep >> stepName [

	^ 'Draw Card'
]
