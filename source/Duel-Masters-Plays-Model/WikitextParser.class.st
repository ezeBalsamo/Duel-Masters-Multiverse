Class {
	#name : #WikitextParser,
	#superclass : #Object,
	#category : #'Duel-Masters-Plays-Model'
}

{ #category : #parsing }
WikitextParser >> parse: aWikitext [

	| wikitextWithoutCurlyBraces |

	wikitextWithoutCurlyBraces := self withoutCurlyBraces: aWikitext.
	^ self parseWikitextTemplateFrom: wikitextWithoutCurlyBraces
]

{ #category : #'parsing - private' }
WikitextParser >> parseTemplateNameFrom: aTemplateNameAndArgumentsCollection [

	^ aTemplateNameAndArgumentsCollection first
]

{ #category : #'parsing - private' }
WikitextParser >> parseWikitextArgumentFrom: aWikitextArgumentToParse [

	^ ( WikitextArgumentParser toParse: aWikitextArgumentToParse ) parse
]

{ #category : #'parsing - private' }
WikitextParser >> parseWikitextArgumentsFrom: aTemplateNameAndArgumentsCollection [

	^ aTemplateNameAndArgumentsCollection allButFirst
		collect: [ :aWikitextArgumentToParse | self parseWikitextArgumentFrom: aWikitextArgumentToParse ]
]

{ #category : #'parsing - private' }
WikitextParser >> parseWikitextTemplateFrom: aWikitextTemplateToParse [

	| templateNameAndArgumentsSplitted templateName arguments |

	templateNameAndArgumentsSplitted := self splitTemplateNameFromArgumentsIn: aWikitextTemplateToParse.

	templateName := self parseTemplateNameFrom: templateNameAndArgumentsSplitted.
	arguments := self parseWikitextArgumentsFrom: templateNameAndArgumentsSplitted.

	^ WikitextTemplate named: templateName withArguments: arguments
]

{ #category : #'parsing - private' }
WikitextParser >> splitTemplateNameFromArgumentsIn: aWikitextToParse [

	^ aWikitextToParse splitOn: '|'
]

{ #category : #'parsing - private' }
WikitextParser >> withoutCurlyBraces: aWikitext [

	^ ( aWikitext withoutPrefix: '{{' ) withoutSuffix: '}}'
]
