Class {
	#name : #NamedWikitextArgumentParser,
	#superclass : #WikitextArgumentParser,
	#category : #'Duel-Masters-Plays-Model'
}

{ #category : #testing }
NamedWikitextArgumentParser class >> canHandle: aWikitextArgumentToParse [

	^ ( aWikitextArgumentToParse beginsWith: '{{' ) not
		and: [ aWikitextArgumentToParse includesSubstring: '=' ]
]

{ #category : #initialization }
NamedWikitextArgumentParser >> initializeToParse: aWikitextArgumentToParse [

	wikitextToParse := aWikitextArgumentToParse
]

{ #category : #parsing }
NamedWikitextArgumentParser >> parse [

	| argumentNameAndContentSplitted argumentName argumentContent |

	argumentNameAndContentSplitted := self splitArgumentNameFromContent.
	argumentName := self parseArgumentNameFrom: argumentNameAndContentSplitted.
	argumentContent := self parseArgumentContentFrom: argumentNameAndContentSplitted.

	^ WikitextArgument named: argumentName withContent: argumentContent
]

{ #category : #'parsing - private' }
NamedWikitextArgumentParser >> parseArgumentContentFrom: anArgumentNameAndContentCollection [

	^ ( WikitextArgumentContentParser toParse: anArgumentNameAndContentCollection second ) parse
]

{ #category : #'parsing - private' }
NamedWikitextArgumentParser >> parseArgumentNameFrom: anArgumentNameAndContentCollection [

	^ anArgumentNameAndContentCollection first
]

{ #category : #'parsing - private' }
NamedWikitextArgumentParser >> splitArgumentNameFromContent [

	^ wikitextToParse splitOnFirstOccurrenceOf: '='
]
