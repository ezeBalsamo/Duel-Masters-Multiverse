Class {
	#name : #WikitextContentParser,
	#superclass : #Object,
	#instVars : [
		'wikitextContentToParse'
	],
	#category : #'Duel-Masters-Plays-Model'
}

{ #category : #'private - testing' }
WikitextContentParser class >> canHandle: aWikitextContentToParse [

	self subclassResponsibility
]

{ #category : #'private - testing' }
WikitextContentParser class >> includesTemplateContent: aWikitextContentToParse [

	^ aWikitextContentToParse includesSubstring: '{{'
]

{ #category : #'private - testing' }
WikitextContentParser class >> isListedContent: aWikitextContentToParse [

	^ aWikitextContentToParse beginsWith: String blackSquare
]

{ #category : #'private - testing' }
WikitextContentParser class >> isListedContentWithTemplate: aWikitextContentToParse [

	^ ( self isListedContent: aWikitextContentToParse )
		and: [ self includesTemplateContent: aWikitextContentToParse ]
]

{ #category : #'private - testing' }
WikitextContentParser class >> isMixedContent: aWikitextContentToParse [

	^ ( self isListedContentWithTemplate: aWikitextContentToParse )
		or: [ ( self isTemplateContentWithListedContent: aWikitextContentToParse )
				or: [ ( self isMultipleListedContent: aWikitextContentToParse )
						or: [ self isMultipleTemplateContent: aWikitextContentToParse ]
					]
			]
]

{ #category : #'private - testing' }
WikitextContentParser class >> isMultipleListedContent: aWikitextContentToParse [

	^ ( aWikitextContentToParse occurrencesQuantityOf: String blackSquare )
		> 1
]

{ #category : #'private - testing' }
WikitextContentParser class >> isMultipleTemplateContent: aWikitextContentToParse [

	^ ( self isTemplateContent: aWikitextContentToParse )
		and: [ ( aWikitextContentToParse substrings: '}}' ) withoutFirst
				ifEmpty: [ false ]
				ifNotEmpty: [ :splittedContents | 
					splittedContents
						allSatisfy: [ :splittedContent | 
							self
								isTemplateContent: ( self trimBrTagsAndWhiteSpacesIn: splittedContent )
							]
					]
			]
]

{ #category : #'private - testing' }
WikitextContentParser class >> isTemplateContent: aWikitextContentToParse [

	^ aWikitextContentToParse beginsWith: '{{'
]

{ #category : #'private - testing' }
WikitextContentParser class >> isTemplateContentWithListedContent: aWikitextContentToParse [

	^ ( self isTemplateContent: aWikitextContentToParse )
		and: [ ( aWikitextContentToParse substrings: '}}' ) withoutFirst
				anySatisfy: [ :splittedContents | 
					self
						isListedContent: ( WikitextWhiteSpacesCleaner new clean: splittedContents )
					]
			]
]

{ #category : #'private - testing' }
WikitextContentParser class >> isTemplateVariableContent: aWikitextContentToParse [

	^ ( aWikitextContentToParse findBetweenSubstrings: '{{}}' )
		anySatisfy: [ :token | token includesSubstring: 'Ruby|' ]
]

{ #category : #'instance creation' }
WikitextContentParser class >> toParse: aWikitextContentToParse [

	| trimmedWikitextContentToParse |

	trimmedWikitextContentToParse := WikitextWhiteSpacesCleaner new
		clean: aWikitextContentToParse.

	^ ( SuitableClassFinder
		findDirectSubclassOf: self
		suitableFor: trimmedWikitextContentToParse ) value new
		initializeToParse: trimmedWikitextContentToParse
]

{ #category : #'private - parsing' }
WikitextContentParser class >> trimBrTagsAndWhiteSpacesIn: aNotClosedWikitextTemplateToParse [

	^ WikitextConfigurableCleaner new
		configureBrTagsCleaner;
		configureWhiteSpacesCleaner;
		clean: aNotClosedWikitextTemplateToParse
]

{ #category : #initialization }
WikitextContentParser >> initializeToParse: aWikitextContentToParse [

	wikitextContentToParse := aWikitextContentToParse
]

{ #category : #initialization }
WikitextContentParser >> parse [

	self subclassResponsibility
]
