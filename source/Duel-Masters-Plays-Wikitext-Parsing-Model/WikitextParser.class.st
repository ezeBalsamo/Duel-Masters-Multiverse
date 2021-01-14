Class {
	#name : #WikitextParser,
	#superclass : #Object,
	#category : #'Duel-Masters-Plays-Wikitext-Parsing-Model'
}

{ #category : #parsing }
WikitextParser class >> parse: aWikitextToParse [

	^ self new parse: aWikitextToParse
]

{ #category : #'private - parsing' }
WikitextParser >> cutAfterClosed: aWikitextToParse [

	^ aWikitextToParse
		detect: $}
		closeTo: ${
		startingAt: 1
		ifFound: [ :lastIndex | aWikitextToParse first: lastIndex ]
		ifNone: [ aWikitextToParse ]
]

{ #category : #parsing }
WikitextParser >> parse: aWikitextToParse [

	| wikitextWithoutLinksAfterClosed wikitextWithoutCurlyBraces |

	wikitextWithoutLinksAfterClosed := self cutAfterClosed: aWikitextToParse.
	wikitextWithoutCurlyBraces := self withoutCurlyBraces: wikitextWithoutLinksAfterClosed.
	^ self parseWikitextTemplateFrom: wikitextWithoutCurlyBraces
]

{ #category : #'private - parsing' }
WikitextParser >> parseWikitextTemplateFrom: aWikitextTemplateToParse [

	^ ( WikitextTemplateParser toParse: aWikitextTemplateToParse ) parse
]

{ #category : #'private - parsing' }
WikitextParser >> withoutCurlyBraces: aWikitextToParse [

	^ ( aWikitextToParse withoutPrefix: '{{' ) withoutSuffix: '}}'
]
