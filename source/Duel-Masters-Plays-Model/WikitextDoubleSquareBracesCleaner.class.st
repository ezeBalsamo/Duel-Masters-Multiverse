Class {
	#name : #WikitextDoubleSquareBracesCleaner,
	#superclass : #WikitextCleaner,
	#category : #'Duel-Masters-Plays-Model'
}

{ #category : #cleaning }
WikitextDoubleSquareBracesCleaner >> clean: aWikitextToClean [

	^ ( CollectionFormatter separatingWith: '' )
		format: ( aWikitextToClean findBetweenSubstrings: '[[]]' )
]
