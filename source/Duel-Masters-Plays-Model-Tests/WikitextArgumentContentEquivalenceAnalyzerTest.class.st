"
A WikitextArgumentContentEquivalenceAnalyzerTest is a test class for testing the behavior of WikitextArgumentContentEquivalenceAnalyzer
"
Class {
	#name : #WikitextArgumentContentEquivalenceAnalyzerTest,
	#superclass : #TestCase,
	#category : #'Duel-Masters-Plays-Model-Tests'
}

{ #category : #tests }
WikitextArgumentContentEquivalenceAnalyzerTest >> test01WikitextTemplateAsContentCantBeComparedWithWikitextBasicContent [

	| wikitextTemplate wikitextBasicContent analyzer |

	wikitextTemplate := WikitextTemplate withoutArgumentsNamed: 'Tap Skill'.
	wikitextBasicContent := WikitextBasicContent being: 'Rare'.

	analyzer := WikitextArgumentContentEquivalenceAnalyzer
		analyzingEquivalenceBetween: wikitextTemplate
		and: wikitextBasicContent.

	self
		assert: ( analyzer isA: ContentsNotSuitableForEquivalenceAnalyzer );
		deny: analyzer areEquivalents
]

{ #category : #tests }
WikitextArgumentContentEquivalenceAnalyzerTest >> test02WikitextBasicContentCanBeComparedWithWikitextBasicContent [

	| wikitextBasicContent anotherWikitextBasicContent equivalentWikitextBasicContent analyzer |

	wikitextBasicContent := WikitextBasicContent being: 'equivalent content'.
	anotherWikitextBasicContent := WikitextBasicContent being: 'not equivalent content'.
	equivalentWikitextBasicContent := WikitextBasicContent being: 'equivalent content'.

	analyzer := WikitextArgumentContentEquivalenceAnalyzer
		analyzingEquivalenceBetween: wikitextBasicContent
		and: anotherWikitextBasicContent.

	self
		assert: ( analyzer isA: ContentsSuitableForEquivalenceAnalyzer );
		deny: analyzer areEquivalents.

	analyzer := WikitextArgumentContentEquivalenceAnalyzer
		analyzingEquivalenceBetween: wikitextBasicContent
		and: equivalentWikitextBasicContent.

	self
		assert: ( analyzer isA: ContentsSuitableForEquivalenceAnalyzer );
		assert: analyzer areEquivalents
]

{ #category : #tests }
WikitextArgumentContentEquivalenceAnalyzerTest >> test03WikitextTemplateCanBeComparedWithWikitextTemplate [

	| wikitextTemplate anotherWikitextTemplate equivalentWikitextTemplate analyzer |

	wikitextTemplate := WikitextTemplate withoutArgumentsNamed: 'equivalent template'.
	anotherWikitextTemplate := WikitextTemplate withoutArgumentsNamed: 'not equivalent template'.
	equivalentWikitextTemplate := WikitextTemplate withoutArgumentsNamed: 'equivalent template'.

	analyzer := WikitextArgumentContentEquivalenceAnalyzer
		analyzingEquivalenceBetween: wikitextTemplate
		and: anotherWikitextTemplate.

	self
		assert: ( analyzer isA: ContentsSuitableForEquivalenceAnalyzer );
		deny: analyzer areEquivalents.

	analyzer := WikitextArgumentContentEquivalenceAnalyzer
		analyzingEquivalenceBetween: wikitextTemplate
		and: equivalentWikitextTemplate.

	self
		assert: ( analyzer isA: ContentsSuitableForEquivalenceAnalyzer );
		assert: analyzer areEquivalents
]
