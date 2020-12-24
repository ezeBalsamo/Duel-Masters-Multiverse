"
A MultipleWikitextTemplateTest is a test class for testing the behavior of MultipleWikitextTemplate
"
Class {
	#name : #MultipleWikitextTemplateTest,
	#superclass : #TestCase,
	#category : #'Duel-Masters-Plays-Model-Tests'
}

{ #category : #tests }
MultipleWikitextTemplateTest >> test01MutipleWikitextTemplateIsEquivalentToAnotherMultipleWikitextTemplate [

	| templateName multipleWikitextTemplate anotherMultipleWikitextTemplate |

	templateName := 'Double Breaker'.
	multipleWikitextTemplate := MultipleWikitextTemplate
		conformedByAll: ( Array with: ( WikitextTemplate withoutArgumentsNamed: templateName ) ).
	anotherMultipleWikitextTemplate := MultipleWikitextTemplate
		conformedByAll: ( Array with: ( WikitextTemplate withoutArgumentsNamed: templateName ) ).

	self assert: ( multipleWikitextTemplate isEquivalentTo: anotherMultipleWikitextTemplate )
]

{ #category : #tests }
MultipleWikitextTemplateTest >> test02MutipleWikitextTemplateIsNotEquivalentToAnotherMultipleWikitextTemplate [

	| multipleWikitextTemplate anotherMultipleWikitextTemplate |

	multipleWikitextTemplate := MultipleWikitextTemplate
		conformedByAll: ( Array with: ( WikitextTemplate withoutArgumentsNamed: 'Double Breaker' ) ).
	anotherMultipleWikitextTemplate := MultipleWikitextTemplate
		conformedByAll: ( Array with: ( WikitextTemplate withoutArgumentsNamed: 'Triple Breaker' ) ).

	self deny: ( multipleWikitextTemplate isEquivalentTo: anotherMultipleWikitextTemplate )
]
