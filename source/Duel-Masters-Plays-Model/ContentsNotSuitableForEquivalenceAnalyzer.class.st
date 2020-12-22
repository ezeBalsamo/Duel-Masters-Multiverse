Class {
	#name : #ContentsNotSuitableForEquivalenceAnalyzer,
	#superclass : #WikitextArgumentContentEquivalenceAnalyzer,
	#category : #'Duel-Masters-Plays-Model'
}

{ #category : #'instance creation' }
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
