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
WikitextContentParser class >> isListedBasicContent: aWikitextContentToParse [

	^ aWikitextContentToParse beginsWith: Character blackSquare asString
]

{ #category : #'private - testing' }
WikitextContentParser class >> isListedBasicContentWithTemplate: aWikitextContentToParse [

	^ ( self isListedBasicContent: aWikitextContentToParse )
		and: [ self includesTemplateContent: aWikitextContentToParse ]
]

{ #category : #'private - testing' }
WikitextContentParser class >> isMixedContent: aWikitextContentToParse [

	^ ( self isListedBasicContentWithTemplate: aWikitextContentToParse )
		or: [ ( self isTemplateContentWithListedContent: aWikitextContentToParse )
				or: [ ( self isMultipleListedBasicContent: aWikitextContentToParse )
						or: [ self isMultipleTemplateContent: aWikitextContentToParse ]
					]
			]
]

{ #category : #'private - testing' }
WikitextContentParser class >> isMultipleListedBasicContent: aWikitextContentToParse [

	^ ( self isListedBasicContent: aWikitextContentToParse )
		and: [ aWikitextContentToParse withoutFirst
				includes: Character blackSquare asString
			]
]

{ #category : #'private - testing' }
WikitextContentParser class >> isMultipleTemplateContent: aWikitextContentToParse [

	^ ( self isTemplateContent: aWikitextContentToParse )
		and: [ ( aWikitextContentToParse substrings: '}}' ) withoutFirst
				allSatisfy: [ :splittedContents | 
					self
						isTemplateContent: ( self trimBrTagsAndWhiteSpacesIn: splittedContents )
					]
			]
]

{ #category : #'private - testing' }
WikitextContentParser class >> isTemplateContent: aWikitextContentToParse [

	^ aWikitextContentToParse beginsWith: '{{'
]

{ #category : #'private - testing' }
WikitextContentParser class >> isTemplateContentWithListedContent: aWikitextContentToParse [

	^ ( aWikitextContentToParse beginsWith: '{{' )
		and: [ ( aWikitextContentToParse splitOn: '}}' ) withoutFirst
				anySatisfy: [ :splittedContents | 
					self
						isListedBasicContent: ( WikitextWhiteSpacesCleaner new clean: splittedContents )
					]
			]
]

{ #category : #'private - testing' }
WikitextContentParser class >> isTemplateVariableContent: aWikitextContentToParse [

	^ ( self isTemplateContent: aWikitextContentToParse )
		and: [ ( aWikitextContentToParse substrings: '}}' )
				anySatisfy: [ :splittedContent | 
					| trimmedSplittedContent |

					trimmedSplittedContent := self
						trimBrTagsAndWhiteSpacesIn: splittedContent.
					( self isTemplateContent: trimmedSplittedContent ) not
						and: [ ( self isListedBasicContent: trimmedSplittedContent ) not ]
					]
			]
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
