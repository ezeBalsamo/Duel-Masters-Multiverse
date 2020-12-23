Class {
	#name : #UnnamedWikitextArgumentParser,
	#superclass : #WikitextArgumentParser,
	#category : #'Duel-Masters-Plays-Model'
}

{ #category : #testing }
UnnamedWikitextArgumentParser class >> canHandle: aWikitextArgumentToParse [

	^ ( ( aWikitextArgumentToParse beginsWith: '{{' ) not
		and: [ ( aWikitextArgumentToParse includesSubstring: '=' ) not ] )
		or: [ aWikitextArgumentToParse beginsWith: '{{' ]
]

{ #category : #initialization }
UnnamedWikitextArgumentParser >> initializeToParse: aWikitextArgumentToParse [

	wikitextToParse := aWikitextArgumentToParse
]

{ #category : #parsing }
UnnamedWikitextArgumentParser >> parse [

	^ WikitextArgument unnamedWithContent: self parseContent
]

{ #category : #'parsing - private' }
UnnamedWikitextArgumentParser >> parseContent [

	^ ( WikitextContentParser toParse: wikitextToParse ) parse
]
