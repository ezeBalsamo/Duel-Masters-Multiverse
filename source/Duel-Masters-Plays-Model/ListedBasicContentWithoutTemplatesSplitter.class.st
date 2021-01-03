Class {
	#name : #ListedBasicContentWithoutTemplatesSplitter,
	#superclass : #WikitextContentSplitter,
	#category : #'Duel-Masters-Plays-Model'
}

{ #category : #'private - testing' }
ListedBasicContentWithoutTemplatesSplitter class >> canHandle: aWikitextContentCollectionToSplit [

	^ ( self isListedBasicContent: aWikitextContentCollectionToSplit )
		and: [ ( self includesTemplateContent: aWikitextContentCollectionToSplit )
				not
			]
]

{ #category : #splitting }
ListedBasicContentWithoutTemplatesSplitter >> split [

	| blackSquareString basicContent |

	blackSquareString := Character blackSquare asString.
	basicContent := ( wikitextContentsToSplit withoutFirst
		splitOn: blackSquareString ) first.
	^ '<1s><2s>' expandMacrosWith: blackSquareString with: basicContent
]
