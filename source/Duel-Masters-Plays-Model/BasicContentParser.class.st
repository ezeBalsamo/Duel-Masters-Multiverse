Class {
	#name : #BasicContentParser,
	#superclass : #WikitextContentParser,
	#category : #'Duel-Masters-Plays-Model'
}

{ #category : #'private - testing' }
BasicContentParser class >> canHandle: aWikitextContentToParse [

	^ ( self isTemplateContent: aWikitextContentToParse ) not
]

{ #category : #'parsing - private' }
BasicContentParser >> contentWithoutDoubleSquareBraces [

	^ ( CollectionFormatter separatingWith: '' ) format: ( wikitextContentToParse findBetweenSubstrings: '[[]]' )
]

{ #category : #initialization }
BasicContentParser >> parse [

	^ WikitextBasicContent being: self contentWithoutDoubleSquareBraces
]
