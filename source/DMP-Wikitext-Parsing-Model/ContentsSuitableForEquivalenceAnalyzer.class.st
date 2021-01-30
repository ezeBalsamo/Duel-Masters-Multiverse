Class {
	#name : #ContentsSuitableForEquivalenceAnalyzer,
	#superclass : #WikitextContentsEquivalenceAnalyzer,
	#instVars : [
		'wikitextContent',
		'theOtherWikitextContent'
	],
	#category : #'DMP-Wikitext-Parsing-Model'
}

{ #category : #'private - testing' }
ContentsSuitableForEquivalenceAnalyzer class >> canHandle: aWikitextContent with: anotherWikitextContent [

	^ aWikitextContent isA: anotherWikitextContent class
]

{ #category : #testing }
ContentsSuitableForEquivalenceAnalyzer >> areEquivalents [

	^ wikitextContent isEquivalentTo: theOtherWikitextContent
]

{ #category : #initialization }
ContentsSuitableForEquivalenceAnalyzer >> initializeAnalyzingEquivalenceBetween: aWikitextContent and: anotherWikitextContent [

	wikitextContent := aWikitextContent.
	theOtherWikitextContent := anotherWikitextContent
]
