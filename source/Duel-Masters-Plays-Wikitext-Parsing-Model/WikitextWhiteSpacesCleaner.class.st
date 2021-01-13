Class {
	#name : #WikitextWhiteSpacesCleaner,
	#superclass : #WikitextCleaner,
	#category : #'Duel-Masters-Plays-Wikitext-Parsing-Model'
}

{ #category : #cleaning }
WikitextWhiteSpacesCleaner >> clean: aWikitextToClean [

	^ aWikitextToClean trimmed
]
