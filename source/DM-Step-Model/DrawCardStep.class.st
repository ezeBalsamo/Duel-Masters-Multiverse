Class {
	#name : #DrawCardStep,
	#superclass : #TurnStep,
	#category : #'DM-Step-Model'
}

{ #category : #'private - accessing' }
DrawCardStep >> allowedActions [

	^ { DrawCardRequest actionDescription }
]

{ #category : #'private - accessing' }
DrawCardStep >> stepName [

	^ 'Draw Card'
]
