Class {
	#name : #WikitextParser,
	#superclass : #Object,
	#category : #'Duel-Masters-Plays-Model'
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

{ #category : #'parsing - private' }
WikitextParser >> parseWikitextTemplateFrom: aWikitextTemplateToParse [

	^ ( WikitextTemplateParser toParse: aWikitextTemplateToParse ) parse
]

{ #category : #'parsing - private' }
WikitextParser >> withoutCurlyBraces: aWikitextToParse [

	^ ( aWikitextToParse withoutPrefix: '{{' ) withoutSuffix: '}}'
]
