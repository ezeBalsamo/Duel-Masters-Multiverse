"
A WikitextParserTest is a test class for testing the behavior of WikitextParser
"
Class {
	#name : #WikitextParserTest,
	#superclass : #TestCase,
	#category : #'Duel-Masters-Plays-Model-Tests'
}

{ #category : #tests }
WikitextParserTest >> test01ParsingAClosedWikitextWithOneTemplateWithoutArguments [

	| wikitext wikitextTemplate parsedWikitextTemplate |

	wikitext := '{{Double Breaker}}'.
	wikitextTemplate := WikitextTemplate withoutArgumentsNamed: 'Double Breaker'.

	parsedWikitextTemplate := WikitextParser new parse: wikitext.
	self assert: ( parsedWikitextTemplate isEquivalentTo: wikitextTemplate )
]

{ #category : #tests }
WikitextParserTest >> test02ParsingAClosedWikitextWithOneTemplateWithOneArgument [

	| wikitext wikitextArgument wikitextTemplate parsedWikitextTemplate |

	wikitext := '{{Cardtable|civilization=water}}'.

	wikitextArgument := WikitextArgument named: 'civilization' content: 'water'.
	wikitextTemplate := WikitextTemplate named: 'Cardtable' withArgument: wikitextArgument.

	parsedWikitextTemplate := WikitextParser new parse: wikitext.

	self assert: ( parsedWikitextTemplate isEquivalentTo: wikitextTemplate )
]

{ #category : #tests }
WikitextParserTest >> test03ParsingANotClosedWikitextWithOneTemplateWithOneArgument [

	| wikitext wikitextArgument wikitextTemplate parsedWikitextTemplate |

	wikitext := '{{Cardtable|civilization=water'.

	wikitextArgument := WikitextArgument named: 'civilization' content: 'water'.
	wikitextTemplate := WikitextTemplate named: 'Cardtable' withArgument: wikitextArgument.

	parsedWikitextTemplate := WikitextParser new parse: wikitext.

	self assert: ( parsedWikitextTemplate isEquivalentTo: wikitextTemplate )
]
