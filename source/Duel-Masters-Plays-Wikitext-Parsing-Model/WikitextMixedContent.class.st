Class {
	#name : #WikitextMixedContent,
	#superclass : #Object,
	#instVars : [
		'wikitextContents'
	],
	#category : #'Duel-Masters-Plays-Wikitext-Parsing-Model'
}

{ #category : #'instance creation' }
WikitextMixedContent class >> conformedByAll: aWikitextContentCollection [

	^ self new initializeConformedByAll: aWikitextContentCollection
]

{ #category : #'private - testing' }
WikitextMixedContent >> hasContent: aPotentialContent [

	^ wikitextContents
		anySatisfy: [ :wikitextContent | self is: wikitextContent equivalentTo: aPotentialContent ]
]

{ #category : #'private - testing' }
WikitextMixedContent >> hasEquivalentContentsThan: aWikitextMixedContent [

	^ wikitextContents
		allSatisfy: [ :wikitextContent | aWikitextMixedContent hasContent: wikitextContent ]
]

{ #category : #initialization }
WikitextMixedContent >> initializeConformedByAll: aWikitextContentCollection [

	wikitextContents := aWikitextContentCollection
]

{ #category : #'private - testing' }
WikitextMixedContent >> is: aWikitextContent equivalentTo: aPotentialWikitextContent [

	^ ( WikitextContentsEquivalenceAnalyzer
		analyzingEquivalenceBetween: aWikitextContent
		and: aPotentialWikitextContent ) areEquivalents
]

{ #category : #testing }
WikitextMixedContent >> isEquivalentTo: aWikitextMixedContent [

	^ ( self hasEquivalentContentsThan: aWikitextMixedContent )
		and: [ aWikitextMixedContent hasEquivalentContentsThan: self ]
]
