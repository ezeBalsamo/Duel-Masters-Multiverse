Class {
	#name : #WikitextContentsEquivalenceAnalyzer,
	#superclass : #Object,
	#category : #'DMP-Wikitext-Parsing-Model'
}

{ #category : #'instance creation' }
WikitextContentsEquivalenceAnalyzer class >> analyzingEquivalenceBetween: aWikitextContent and: anotherWikitextContent [

	^ ( SuitableClassFinder
		findDirectSubclassOf: self
		suitableFor: aWikitextContent
		with: anotherWikitextContent ) value new
		initializeAnalyzingEquivalenceBetween: aWikitextContent
		and: anotherWikitextContent
]

{ #category : #'private - testing' }
WikitextContentsEquivalenceAnalyzer class >> canHandle: aWikitextContent with: anotherWikitextContent [

	self subclassResponsibility
]

{ #category : #testing }
WikitextContentsEquivalenceAnalyzer >> areEquivalents [

	self subclassResponsibility
]
