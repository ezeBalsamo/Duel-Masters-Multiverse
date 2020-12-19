Class {
	#name : #WikitextParser,
	#superclass : #Object,
	#category : #'Duel-Masters-Plays-Model'
}

{ #category : #testing }
WikitextParser >> hasArguments: aTemplateNameAndArgumentsCollection [

	^ aTemplateNameAndArgumentsCollection size > 1
]

{ #category : #parsing }
WikitextParser >> parse: aWikitext [

	| wikitextWithoutCurlyBraces templateNameAndArgumentsSplitted templateName arguments |

	wikitextWithoutCurlyBraces := self withoutCurlyBraces: aWikitext.
	templateNameAndArgumentsSplitted := self
		splitTemplateNameFromArgumentsIn: wikitextWithoutCurlyBraces.

	templateName := self parseTemplateNameFrom: templateNameAndArgumentsSplitted.
	arguments := self parseArgumentsFrom: templateNameAndArgumentsSplitted.

	^ WikitextTemplate named: templateName withArguments: arguments
]

{ #category : #'parsing - private' }
WikitextParser >> parseArgumentsFrom: aTemplateNameAndArgumentsCollection [

	| argumentNameAndContentSplitted |

	^ ( self hasArguments: aTemplateNameAndArgumentsCollection )
		then: [ argumentNameAndContentSplitted := aTemplateNameAndArgumentsCollection second splitOn: '='.
			Array
				with:
					( WikitextArgument
						named: argumentNameAndContentSplitted first
						content: argumentNameAndContentSplitted second )
			]
		otherwise: [ #() ]
]

{ #category : #'parsing - private' }
WikitextParser >> parseTemplateNameFrom: aTemplateNameAndArgumentsCollection [

	^ aTemplateNameAndArgumentsCollection first
]

{ #category : #'parsing - private' }
WikitextParser >> splitTemplateNameFromArgumentsIn: aWikitext [

	^ aWikitext splitOn: '|'
]

{ #category : #'parsing - private' }
WikitextParser >> withoutCurlyBraces: aWikitext [

	^ ( aWikitext withoutPrefix: '{{' ) withoutSuffix: '}}'
]
