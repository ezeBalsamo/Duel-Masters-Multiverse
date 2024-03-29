Class {
	#name : #IllegalPlay,
	#superclass : #Error,
	#instVars : [
		'player',
		'errorDescription'
	],
	#category : #'DM-Exception-Model'
}

{ #category : #'instance creation' }
IllegalPlay class >> from: aPlayer because: anErrorDescription [

	^ self new
		initializeFrom: aPlayer because: anErrorDescription;
		signal
]

{ #category : #accessing }
IllegalPlay >> errorDescription [

	^ errorDescription
]

{ #category : #initialization }
IllegalPlay >> initializeFrom: aPlayer because: anErrorDescription [

	player := aPlayer.
	errorDescription := anErrorDescription.
	self messageText: ( '<1p>: <2s>' expandMacrosWith: player with: anErrorDescription )
]

{ #category : #accessing }
IllegalPlay >> player [

	^ player
]
