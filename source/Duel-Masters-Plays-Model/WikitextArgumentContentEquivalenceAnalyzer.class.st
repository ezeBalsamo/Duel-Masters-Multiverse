Class {
	#name : #WikitextArgumentContentEquivalenceAnalyzer,
	#superclass : #Object,
	#category : #'Duel-Masters-Plays-Model'
}

{ #category : #'instance creation' }
WikitextArgumentContentEquivalenceAnalyzer class >> analyzingEquivalenceBetween: aWikitextContent and: anotherWikitextContent [

	^ ( SuitableClassFinder
		findDirectSubclassOf: self
		suitableFor: aWikitextContent
		with: anotherWikitextContent ) value new
		initializeAnalyzingEquivalenceBetween: aWikitextContent
		and: anotherWikitextContent
]

{ #category : #'instance creation' }
WikitextArgumentContentEquivalenceAnalyzer class >> canHandle: aWikitextContent with: anotherWikitextContent [

	self subclassResponsibility
]

{ #category : #testing }
WikitextArgumentContentEquivalenceAnalyzer >> areEquivalents [

	self subclassResponsibility
]
