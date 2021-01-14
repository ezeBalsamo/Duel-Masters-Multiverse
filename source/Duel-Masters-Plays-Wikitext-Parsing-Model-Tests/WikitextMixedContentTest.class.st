"
A MultipleWikitextTemplateTest is a test class for testing the behavior of MultipleWikitextTemplate
"
Class {
	#name : #WikitextMixedContentTest,
	#superclass : #TestCase,
	#category : #'Duel-Masters-Plays-Wikitext-Parsing-Model-Tests'
}

{ #category : #tests }
WikitextMixedContentTest >> test01WikitextMixedContentIsEquivalentToAnotherWikitextMixedContentWhenTheyShareTheSameContentTypeAndTheSameContent [

	| templateName multipleWikitextTemplate anotherMultipleWikitextTemplate |

	templateName := 'Double Breaker'.
	multipleWikitextTemplate := WikitextMixedContent
		conformedByAll: ( Array with: ( WikitextTemplate withoutArgumentsNamed: templateName ) ).
	anotherMultipleWikitextTemplate := WikitextMixedContent
		conformedByAll: ( Array with: ( WikitextTemplate withoutArgumentsNamed: templateName ) ).

	self assert: ( multipleWikitextTemplate isEquivalentTo: anotherMultipleWikitextTemplate )
]

{ #category : #tests }
WikitextMixedContentTest >> test02WikitextMixedContentIsNotEquivalentToAnotherWikitextMixedContentWhenTheyDontShareTheSameContentType [

	| multipleWikitextTemplate anotherMultipleWikitextTemplate |

	multipleWikitextTemplate := WikitextMixedContent
		conformedByAll:
			( Array
				with: ( WikitextTemplate withoutArgumentsNamed: 'Double Breaker' ) ).
	anotherMultipleWikitextTemplate := WikitextMixedContent
		conformedByAll: ( Array with: ( WikitextBasicContent being: 'Double Breaker' ) ).

	self
		deny:
			( multipleWikitextTemplate
				isEquivalentTo: anotherMultipleWikitextTemplate )
]

{ #category : #tests }
WikitextMixedContentTest >> test03WikitextMixedContentIsNotEquivalentToAnotherWikitextMixedContentWhenTheyShareTheSameContentTypeButNotTheSameContent [

	| multipleWikitextTemplate anotherMultipleWikitextTemplate |

	multipleWikitextTemplate := WikitextMixedContent
		conformedByAll: ( Array with: ( WikitextTemplate withoutArgumentsNamed: 'Double Breaker' ) ).
	anotherMultipleWikitextTemplate := WikitextMixedContent
		conformedByAll: ( Array with: ( WikitextTemplate withoutArgumentsNamed: 'Triple Breaker' ) ).

	self deny: ( multipleWikitextTemplate isEquivalentTo: anotherMultipleWikitextTemplate )
]
