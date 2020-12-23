Class {
	#name : #ContentsNotSuitableForEquivalenceAnalyzer,
	#superclass : #WikitextContentsEquivalenceAnalyzer,
	#category : #'Duel-Masters-Plays-Model'
}

{ #category : #'private - testing' }
ContentsNotSuitableForEquivalenceAnalyzer class >> canHandle: aWikitextContent with: anotherWikitextContent [

	^ aWikitextContent class ~= anotherWikitextContent class
]

{ #category : #testing }
ContentsNotSuitableForEquivalenceAnalyzer >> areEquivalents [

	^ false
]

{ #category : #'instance creation' }
ContentsNotSuitableForEquivalenceAnalyzer >> initializeAnalyzingEquivalenceBetween: aWikitextContent and: anotherWikitextContent [

	
]
