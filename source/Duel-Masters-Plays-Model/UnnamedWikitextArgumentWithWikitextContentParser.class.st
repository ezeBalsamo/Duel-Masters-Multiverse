Class {
	#name : #UnnamedWikitextArgumentWithWikitextContentParser,
	#superclass : #UnnamedWikitextArgumentParser,
	#category : #'Duel-Masters-Plays-Model'
}

{ #category : #testing }
UnnamedWikitextArgumentWithWikitextContentParser class >> canHandle: aWikitextArgumentToParse [

	^ aWikitextArgumentToParse beginsWith: '{{'
]

{ #category : #initialization }
UnnamedWikitextArgumentWithWikitextContentParser >> initializeToParse: aWikitextArgumentToParse [

	wikitextToParse := aWikitextArgumentToParse
]

{ #category : #parsing }
UnnamedWikitextArgumentWithWikitextContentParser >> parseContent [

	^ WikitextParser parse: wikitextToParse
]
