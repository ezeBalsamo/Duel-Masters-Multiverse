Class {
	#name : #GameInProgress,
	#superclass : #GameState,
	#category : #'DM-Match-Model'
}

{ #category : #accessing }
GameInProgress >> hasEnded [

	^ false
]

{ #category : #accessing }
GameInProgress >> winner [

	Error signal: 'Can''t know the winner until the game has ended.'
]
