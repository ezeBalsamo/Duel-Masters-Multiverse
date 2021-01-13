Class {
	#name : #WikitextBlackSquareCleaner,
	#superclass : #WikitextCleaner,
	#category : #'Duel-Masters-Plays-Wikitext-Parsing-Model'
}

{ #category : #cleaning }
WikitextBlackSquareCleaner >> clean: aWikitextToClean [

	^ aWikitextToClean withoutPrefix: String blackSquare
]
