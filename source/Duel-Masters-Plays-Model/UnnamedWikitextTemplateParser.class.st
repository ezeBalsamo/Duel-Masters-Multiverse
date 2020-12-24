Class {
	#name : #UnnamedWikitextTemplateParser,
	#superclass : #WikitextTemplateParser,
	#category : #'Duel-Masters-Plays-Model'
}

{ #category : #'private - testing' }
UnnamedWikitextTemplateParser class >> canHandle: aWikitextTemplateToParse [

	^ self isUnnamed: aWikitextTemplateToParse
]

{ #category : #parsing }
UnnamedWikitextTemplateParser >> parse [

	^ WikitextTemplate
		unnamedWithArgument: ( WikitextArgument unnamedWithContent: ( BasicContentParser parse: self parseContent ) )
]

{ #category : #'private - parsing' }
UnnamedWikitextTemplateParser >> parseContent [

	^ ( wikitextTemplateToParse withoutPrefix: Character blackSquare asString ) trimLeft
]
