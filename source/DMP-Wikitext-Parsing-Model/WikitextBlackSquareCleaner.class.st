Class {
	#name : #WikitextBlackSquareCleaner,
	#superclass : #WikitextCleaner,
	#category : #'DMP-Wikitext-Parsing-Model'
}

{ #category : #cleaning }
WikitextBlackSquareCleaner >> clean: aWikitextToClean [

	^ aWikitextToClean withoutPrefix: String blackSquare
]
