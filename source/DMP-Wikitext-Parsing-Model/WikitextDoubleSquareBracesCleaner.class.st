Class {
	#name : #WikitextDoubleSquareBracesCleaner,
	#superclass : #WikitextCleaner,
	#category : #'DMP-Wikitext-Parsing-Model'
}

{ #category : #cleaning }
WikitextDoubleSquareBracesCleaner >> clean: aWikitextToClean [

	^ ( CollectionFormatter separatingWith: '' )
		format: ( aWikitextToClean findBetweenSubstrings: '[[]]' )
]
