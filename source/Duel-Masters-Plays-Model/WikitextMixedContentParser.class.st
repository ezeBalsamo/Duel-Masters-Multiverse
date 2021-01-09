Class {
	#name : #WikitextMixedContentParser,
	#superclass : #WikitextContentParser,
	#category : #'Duel-Masters-Plays-Model'
}

{ #category : #'private - testing' }
WikitextMixedContentParser class >> canHandle: aWikitextContentToParse [

	^ ( self isMixedContent: aWikitextContentToParse )
		and: [ ( self isVariableTemplateContent: aWikitextContentToParse ) not ]
]

{ #category : #initialization }
WikitextMixedContentParser >> parse [

	| wikitextTemplates |

	wikitextTemplates := self
		withSplittedWikitextContentsCollect: [ :splittedWikitextContentToParse | self parse: splittedWikitextContentToParse ].

	^ WikitextMixedContent conformedByAll: wikitextTemplates
]

{ #category : #'private - accessing' }
WikitextMixedContentParser >> parse: aSplittedWikitextContentToParse [

	^ ( WikitextContentParser toParse: aSplittedWikitextContentToParse ) parse
]

{ #category : #'private - accessing' }
WikitextMixedContentParser >> splittedWikitextContents [

	^ ( WikitextMixedContentSplitter splitting: wikitextContentToParse ) split
]

{ #category : #'private - accessing' }
WikitextMixedContentParser >> withSplittedWikitextContentsCollect: aBlockClosure [

	^ self splittedWikitextContents collect: aBlockClosure
]
