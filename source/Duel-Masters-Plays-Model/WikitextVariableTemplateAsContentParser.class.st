Class {
	#name : #WikitextVariableTemplateAsContentParser,
	#superclass : #WikitextContentParser,
	#category : #'Duel-Masters-Plays-Model'
}

{ #category : #'private - testing' }
WikitextVariableTemplateAsContentParser class >> canHandle: aWikitextContentToParse [

	^ self isVariableTemplateContent: aWikitextContentToParse
]

{ #category : #initialization }
WikitextVariableTemplateAsContentParser >> parse [

	^ WikitextBasicContent being: self parsedContent
]

{ #category : #'private - parsing' }
WikitextVariableTemplateAsContentParser >> parsedContent [

	^ ( CollectionFormatter separatingWith: '' )
		format: self splittedParts
]

{ #category : #'private - accessing' }
WikitextVariableTemplateAsContentParser >> splittedParts [

	^ ( wikitextContentToParse findBetweenSubstrings: '{{}}' )
		collect: [ :token | 
			( token includesSubstring: '|' )
				then: [ ( token splitOn: '|' ) second ]
				otherwise: [ token ]
			]
]
