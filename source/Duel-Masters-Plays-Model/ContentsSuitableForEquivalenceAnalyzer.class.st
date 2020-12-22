Class {
	#name : #ContentsSuitableForEquivalenceAnalyzer,
	#superclass : #WikitextArgumentContentEquivalenceAnalyzer,
	#instVars : [
		'wikitextContent',
		'theOtherWikitextContent'
	],
	#category : #'Duel-Masters-Plays-Model'
}

{ #category : #'instance creation' }
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
