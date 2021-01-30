"
A WikitextArgumentContentEquivalenceAnalyzerTest is a test class for testing the behavior of WikitextArgumentContentEquivalenceAnalyzer
"
Class {
	#name : #WikitextContentsEquivalenceAnalyzerTest,
	#superclass : #TestCase,
	#category : #'DMP-Wikitext-Parsing-Model-Tests'
}

{ #category : #tests }
WikitextContentsEquivalenceAnalyzerTest >> test01WikitextTemplateAsContentCantBeComparedWithWikitextBasicContent [

	| wikitextTemplate wikitextBasicContent analyzer |

	wikitextTemplate := WikitextTemplate withoutArgumentsNamed: 'Tap Skill'.
	wikitextBasicContent := WikitextBasicContent being: 'Rare'.

	analyzer := WikitextContentsEquivalenceAnalyzer
		analyzingEquivalenceBetween: wikitextTemplate
		and: wikitextBasicContent.

	self
		assert: ( analyzer isA: ContentsNotSuitableForEquivalenceAnalyzer );
		deny: analyzer areEquivalents
]

{ #category : #tests }
WikitextContentsEquivalenceAnalyzerTest >> test02WikitextBasicContentCanBeComparedWithWikitextBasicContent [

	| wikitextBasicContent anotherWikitextBasicContent equivalentWikitextBasicContent analyzer |

	wikitextBasicContent := WikitextBasicContent being: 'equivalent content'.
	anotherWikitextBasicContent := WikitextBasicContent being: 'not equivalent content'.
	equivalentWikitextBasicContent := WikitextBasicContent being: 'equivalent content'.

	analyzer := WikitextContentsEquivalenceAnalyzer
		analyzingEquivalenceBetween: wikitextBasicContent
		and: anotherWikitextBasicContent.

	self
		assert: ( analyzer isA: ContentsSuitableForEquivalenceAnalyzer );
		deny: analyzer areEquivalents.

	analyzer := WikitextContentsEquivalenceAnalyzer
		analyzingEquivalenceBetween: wikitextBasicContent
		and: equivalentWikitextBasicContent.

	self
		assert: ( analyzer isA: ContentsSuitableForEquivalenceAnalyzer );
		assert: analyzer areEquivalents
]

{ #category : #tests }
WikitextContentsEquivalenceAnalyzerTest >> test03WikitextTemplateCanBeComparedWithWikitextTemplate [

	| wikitextTemplate anotherWikitextTemplate equivalentWikitextTemplate analyzer |

	wikitextTemplate := WikitextTemplate withoutArgumentsNamed: 'equivalent template'.
	anotherWikitextTemplate := WikitextTemplate withoutArgumentsNamed: 'not equivalent template'.
	equivalentWikitextTemplate := WikitextTemplate withoutArgumentsNamed: 'equivalent template'.

	analyzer := WikitextContentsEquivalenceAnalyzer
		analyzingEquivalenceBetween: wikitextTemplate
		and: anotherWikitextTemplate.

	self
		assert: ( analyzer isA: ContentsSuitableForEquivalenceAnalyzer );
		deny: analyzer areEquivalents.

	analyzer := WikitextContentsEquivalenceAnalyzer
		analyzingEquivalenceBetween: wikitextTemplate
		and: equivalentWikitextTemplate.

	self
		assert: ( analyzer isA: ContentsSuitableForEquivalenceAnalyzer );
		assert: analyzer areEquivalents
]
