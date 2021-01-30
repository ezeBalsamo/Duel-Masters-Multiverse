Class {
	#name : #UnnamedWikitextArgumentParser,
	#superclass : #WikitextArgumentParser,
	#category : #'DMP-Wikitext-Parsing-Model'
}

{ #category : #'private - testing' }
UnnamedWikitextArgumentParser class >> canHandle: aWikitextArgumentToParse [

	^ ( self isUnnamedArgumentWithBasicContent: aWikitextArgumentToParse )
		or: [ self isUnnamedArgumentWithTemplateContent: aWikitextArgumentToParse ]
]

{ #category : #'private - testing' }
UnnamedWikitextArgumentParser class >> isUnnamedArgumentWithBasicContent: aWikitextArgumentToParse [

	^ ( self isUnnamedArgumentWithTemplateContent: aWikitextArgumentToParse ) not
		and: [ ( self isNamed: aWikitextArgumentToParse ) not ]
]

{ #category : #parsing }
UnnamedWikitextArgumentParser >> parse [

	^ WikitextArgument unnamedWithContent: self parseContent
]

{ #category : #'private - parsing' }
UnnamedWikitextArgumentParser >> parseContent [

	^ ( WikitextContentParser toParse: wikitextArgumentToParse ) parse
]
