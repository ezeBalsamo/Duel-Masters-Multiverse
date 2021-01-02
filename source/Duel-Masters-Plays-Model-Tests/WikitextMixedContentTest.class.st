"
A MultipleWikitextTemplateTest is a test class for testing the behavior of MultipleWikitextTemplate
"
Class {
	#name : #WikitextMixedContentTest,
	#superclass : #TestCase,
	#category : #'Duel-Masters-Plays-Model-Tests'
}

{ #category : #tests }
WikitextMixedContentTest >> test01WikitextMixedContentIsEquivalentToAnotherWikitextMixedContent [

	| templateName multipleWikitextTemplate anotherMultipleWikitextTemplate |

	templateName := 'Double Breaker'.
	multipleWikitextTemplate := WikitextMixedContent
		conformedByAll: ( Array with: ( WikitextTemplate withoutArgumentsNamed: templateName ) ).
	anotherMultipleWikitextTemplate := WikitextMixedContent
		conformedByAll: ( Array with: ( WikitextTemplate withoutArgumentsNamed: templateName ) ).

	self assert: ( multipleWikitextTemplate isEquivalentTo: anotherMultipleWikitextTemplate )
]

{ #category : #tests }
WikitextMixedContentTest >> test02WikitextMixedContentIsNotEquivalentToAnotherWikitextMixedContent [

	| multipleWikitextTemplate anotherMultipleWikitextTemplate |

	multipleWikitextTemplate := WikitextMixedContent
		conformedByAll: ( Array with: ( WikitextTemplate withoutArgumentsNamed: 'Double Breaker' ) ).
	anotherMultipleWikitextTemplate := WikitextMixedContent
		conformedByAll: ( Array with: ( WikitextTemplate withoutArgumentsNamed: 'Triple Breaker' ) ).

	self deny: ( multipleWikitextTemplate isEquivalentTo: anotherMultipleWikitextTemplate )
]
