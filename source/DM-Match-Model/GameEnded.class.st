Class {
	#name : #GameEnded,
	#superclass : #GameState,
	#instVars : [
		'winner'
	],
	#category : #'DM-Match-Model'
}

{ #category : #'instance creation' }
GameEnded class >> wonBy: aPlayer [

	^ self new initializeWonBy: aPlayer
]

{ #category : #accessing }
GameEnded >> hasEnded [

	^ true
]

{ #category : #initialization }
GameEnded >> initializeWonBy: aPlayer [

	winner := aPlayer
]

{ #category : #accessing }
GameEnded >> winner [

	^ winner
]
