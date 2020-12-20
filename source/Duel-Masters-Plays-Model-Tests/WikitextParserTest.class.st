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

{ #category : #tests }
WikitextParserTest >> test04ParsingAClosedWikitextWithOneTemplateWithOneUnnamedArgument [

	| wikitext wikitextArgument wikitextTemplate parsedWikitextTemplate |

	wikitext := '{{Tap Skill|Return one of your opponent''s creatures to their hand.}}'.

	wikitextArgument := WikitextArgument
		unnamedWithContent: 'Return one of your opponent''s creatures to their hand.'.
	wikitextTemplate := WikitextTemplate named: 'Tap Skill' withArgument: wikitextArgument.

	parsedWikitextTemplate := WikitextParser new parse: wikitext.

	self assert: ( parsedWikitextTemplate isEquivalentTo: wikitextTemplate )
]

{ #category : #tests }
WikitextParserTest >> test05ParsingAClosedWikitextWithOneTemplateWithManyArguments [

	| wikitext firstWikitextArgument secondWikitextArgument thirdWikitextArgument wikitextTemplate parsedWikitextTemplate |

	wikitext := '{{Cardtable|civilization=Water|type=Creature|cost=7}}'.

	firstWikitextArgument := WikitextArgument named: 'civilization' content: 'Water'.
	secondWikitextArgument := WikitextArgument named: 'type' content: 'Creature'.
	thirdWikitextArgument := WikitextArgument named: 'cost' content: '7'.

	wikitextTemplate := WikitextTemplate
		named: 'Cardtable'
		withArguments: ( Array with: firstWikitextArgument with: secondWikitextArgument with: thirdWikitextArgument ).

	parsedWikitextTemplate := WikitextParser new parse: wikitext.

	self assert: ( parsedWikitextTemplate isEquivalentTo: wikitextTemplate )
]
