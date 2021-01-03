Class {
	#name : #WikitextTemplateAsContentSplitter,
	#superclass : #WikitextContentSplitter,
	#category : #'Duel-Masters-Plays-Model'
}

{ #category : #'private - testing' }
WikitextTemplateAsContentSplitter class >> canHandle: aWikitextContentCollectionToSplit [

	^ self isTemplateContent: aWikitextContentCollectionToSplit
]

{ #category : #splitting }
WikitextTemplateAsContentSplitter >> split [

	^ wikitextContentsToSplit
		detect: $}
		closeTo: ${
		startingAt: 1
		ifFound: [ :lastIndex | wikitextContentsToSplit first: lastIndex ]
		ifNone: [ "It'll never arrive here.- ebalsamo" ]
]
