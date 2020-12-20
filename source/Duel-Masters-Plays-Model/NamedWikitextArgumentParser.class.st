Class {
	#name : #NamedWikitextArgumentParser,
	#superclass : #WikitextArgumentParser,
	#category : #'Duel-Masters-Plays-Model'
}

{ #category : #testing }
NamedWikitextArgumentParser class >> canHandle: aWikitextArgumentToParse [

	^ aWikitextArgumentToParse includesSubstring: '='
]

{ #category : #initialization }
NamedWikitextArgumentParser >> initializeToParse: aWikitextArgumentToParse [

	wikitextArgumentToParse := aWikitextArgumentToParse
]

{ #category : #parsing }
NamedWikitextArgumentParser >> parse [

	| argumentNameAndContentSplitted |

	argumentNameAndContentSplitted := self splitArgumentNameFromContent.

	^ WikitextArgument
		named: argumentNameAndContentSplitted first
		content: argumentNameAndContentSplitted second
]

{ #category : #'parsing - private' }
NamedWikitextArgumentParser >> splitArgumentNameFromContent [

	^ wikitextArgumentToParse substrings: '='
]
