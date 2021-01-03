Class {
	#name : #WikitextWhiteSpacesCleaner,
	#superclass : #WikitextCleaner,
	#category : #'Duel-Masters-Plays-Model'
}

{ #category : #cleaning }
WikitextWhiteSpacesCleaner >> clean: aWikitextToClean [

	^ aWikitextToClean trimmed
]
