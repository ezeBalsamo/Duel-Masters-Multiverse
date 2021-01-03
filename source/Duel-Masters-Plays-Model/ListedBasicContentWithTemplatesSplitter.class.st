Class {
	#name : #ListedBasicContentWithTemplatesSplitter,
	#superclass : #WikitextContentSplitter,
	#category : #'Duel-Masters-Plays-Model'
}

{ #category : #'private - testing' }
ListedBasicContentWithTemplatesSplitter class >> canHandle: aWikitextContentCollectionToSplit [

	^ ( self isListedBasicContent: aWikitextContentCollectionToSplit )
		and: [ self includesTemplateContent: aWikitextContentCollectionToSplit ]
]

{ #category : #splitting }
ListedBasicContentWithTemplatesSplitter >> split [

	^ ( wikitextContentsToSplit splitOn: '{{' ) first
]
