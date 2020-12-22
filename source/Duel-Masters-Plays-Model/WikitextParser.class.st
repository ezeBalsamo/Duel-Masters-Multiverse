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
WikitextParser >> parseWikitextTemplateFrom: aWikitextTemplateToParse [

	^ ( WikitextTemplateParser toParse: aWikitextTemplateToParse ) parse
]

{ #category : #'parsing - private' }
WikitextParser >> withoutCurlyBraces: aWikitext [

	^ ( aWikitext withoutPrefix: '{{' ) withoutSuffix: '}}'
]
