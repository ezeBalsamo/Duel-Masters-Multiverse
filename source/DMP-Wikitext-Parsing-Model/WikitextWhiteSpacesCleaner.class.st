Class {
	#name : #WikitextWhiteSpacesCleaner,
	#superclass : #WikitextCleaner,
	#category : #'DMP-Wikitext-Parsing-Model'
}

{ #category : #cleaning }
WikitextWhiteSpacesCleaner >> clean: aWikitextToClean [

	^ aWikitextToClean trimmed
]
