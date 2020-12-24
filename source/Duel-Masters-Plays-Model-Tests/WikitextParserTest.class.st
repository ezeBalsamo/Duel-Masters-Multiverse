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

	parsedWikitextTemplate := WikitextParser parse: wikitext.
	self assert: ( parsedWikitextTemplate isEquivalentTo: wikitextTemplate )
]

{ #category : #tests }
WikitextParserTest >> test02ParsingAClosedWikitextWithOneTemplateWithOneNamedArgumentWithBasicContent [

	| wikitext wikitextArgument wikitextTemplate parsedWikitextTemplate |

	wikitext := '{{Cardtable|civilization=water}}'.

	wikitextArgument := WikitextArgument
		named: 'civilization'
		withContent: ( WikitextBasicContent being: 'water' ).
	wikitextTemplate := WikitextTemplate named: 'Cardtable' withArgument: wikitextArgument.

	parsedWikitextTemplate := WikitextParser parse: wikitext.

	self assert: ( parsedWikitextTemplate isEquivalentTo: wikitextTemplate )
]

{ #category : #tests }
WikitextParserTest >> test03ParsingANotClosedWikitextWithOneTemplateWithOneNamedArgumentWithBasicContent [

	| wikitext wikitextArgument wikitextTemplate parsedWikitextTemplate |

	wikitext := '{{Cardtable|civilization=water'.

	wikitextArgument := WikitextArgument
		named: 'civilization'
		withContent: ( WikitextBasicContent being: 'water' ).
	wikitextTemplate := WikitextTemplate named: 'Cardtable' withArgument: wikitextArgument.

	parsedWikitextTemplate := WikitextParser parse: wikitext.

	self assert: ( parsedWikitextTemplate isEquivalentTo: wikitextTemplate )
]

{ #category : #tests }
WikitextParserTest >> test04ParsingAClosedWikitextWithOneTemplateWithOneUnnamedArgumentWithBasicContent [

	| wikitext wikitextArgument wikitextTemplate parsedWikitextTemplate |

	wikitext := '{{Tap Skill|Return one of your opponent''s creatures to their hand.}}'.

	wikitextArgument := WikitextArgument
		unnamedWithContent: ( WikitextBasicContent being: 'Return one of your opponent''s creatures to their hand.' ).
	wikitextTemplate := WikitextTemplate named: 'Tap Skill' withArgument: wikitextArgument.

	parsedWikitextTemplate := WikitextParser parse: wikitext.

	self assert: ( parsedWikitextTemplate isEquivalentTo: wikitextTemplate )
]

{ #category : #tests }
WikitextParserTest >> test05ParsingANotClosedWikitextWithOneTemplateWithOneUnnamedArgumentWithBasicContent [

	| wikitext wikitextArgument wikitextTemplate parsedWikitextTemplate |

	wikitext := '{{Tap Skill|Return one of your opponent''s creatures to their hand.'.

	wikitextArgument := WikitextArgument
		unnamedWithContent: ( WikitextBasicContent being: 'Return one of your opponent''s creatures to their hand.' ).
	wikitextTemplate := WikitextTemplate named: 'Tap Skill' withArgument: wikitextArgument.

	parsedWikitextTemplate := WikitextParser parse: wikitext.

	self assert: ( parsedWikitextTemplate isEquivalentTo: wikitextTemplate )
]

{ #category : #tests }
WikitextParserTest >> test06ParsingAClosedWikitextWithOneTemplateWithOneNamedArgumentWithInnerWikitextTemplateWithUnnamedArgumentWithBasicContent [

	| wikitext innerWikitextArgument innerWikitextTemplate wikitextArgument wikitextTemplate parsedWikitextTemplate |

	wikitext := '{{Cardtable|engtext={{Tap Skill|Return one of your opponent''s creatures to their hand.}}}}'.

	innerWikitextArgument := WikitextArgument
		unnamedWithContent: ( WikitextBasicContent being: 'Return one of your opponent''s creatures to their hand.' ).
	innerWikitextTemplate := WikitextTemplate named: 'Tap Skill' withArgument: innerWikitextArgument.
	wikitextArgument := WikitextArgument named: 'engtext' withContent: innerWikitextTemplate.
	wikitextTemplate := WikitextTemplate named: 'Cardtable' withArgument: wikitextArgument.

	parsedWikitextTemplate := WikitextParser parse: wikitext.

	self assert: ( parsedWikitextTemplate isEquivalentTo: wikitextTemplate )
]

{ #category : #tests }
WikitextParserTest >> test07ParsingAClosedWikitextWithOneTemplateWithOneUnnamedArgumentWithInnerWikitextTemplateWithUnnamedArgumentWithBasicContent [

	| wikitext innerWikitextArgument innerWikitextTemplate wikitextArgument wikitextTemplate parsedWikitextTemplate |

	wikitext := '{{Cardtable|{{Tap Skill|Return one of your opponent''s creatures to their hand.}}}}'.

	innerWikitextArgument := WikitextArgument
		unnamedWithContent: ( WikitextBasicContent being: 'Return one of your opponent''s creatures to their hand.' ).
	innerWikitextTemplate := WikitextTemplate named: 'Tap Skill' withArgument: innerWikitextArgument.
	wikitextArgument := WikitextArgument unnamedWithContent: innerWikitextTemplate.
	wikitextTemplate := WikitextTemplate named: 'Cardtable' withArgument: wikitextArgument.

	parsedWikitextTemplate := WikitextParser parse: wikitext.

	self assert: ( parsedWikitextTemplate isEquivalentTo: wikitextTemplate )
]

{ #category : #tests }
WikitextParserTest >> test08ParsingAClosedWikitextWithOneTemplateWithOneNamedArgumentWithInnerWikitextTemplateWithNamedArgumentWithBasicContent [

	| wikitext innerWikitextArgument innerWikitextTemplate wikitextArgument wikitextTemplate parsedWikitextTemplate |

	wikitext := '{{Cardtable|engtext={{Tap Skill|effect=Return one of your opponent''s creatures to their hand.}}}}'.

	innerWikitextArgument := WikitextArgument
		named: 'effect'
		withContent: ( WikitextBasicContent being: 'Return one of your opponent''s creatures to their hand.' ).
	innerWikitextTemplate := WikitextTemplate named: 'Tap Skill' withArgument: innerWikitextArgument.
	wikitextArgument := WikitextArgument named: 'engtext' withContent: innerWikitextTemplate.
	wikitextTemplate := WikitextTemplate named: 'Cardtable' withArgument: wikitextArgument.

	parsedWikitextTemplate := WikitextParser parse: wikitext.

	self assert: ( parsedWikitextTemplate isEquivalentTo: wikitextTemplate )
]

{ #category : #tests }
WikitextParserTest >> test09ParsingAClosedWikitextWithOneTemplateWithOneUnnamedArgumentWithInnerWikitextTemplateWithNamedArgumentWithBasicContent [

	| wikitext innerWikitextArgument innerWikitextTemplate wikitextArgument wikitextTemplate parsedWikitextTemplate |

	wikitext := '{{Cardtable|{{Tap Skill|effect=Return one of your opponent''s creatures to their hand.}}}}'.

	innerWikitextArgument := WikitextArgument
		named: 'effect'
		withContent: ( WikitextBasicContent being: 'Return one of your opponent''s creatures to their hand.' ).
	innerWikitextTemplate := WikitextTemplate named: 'Tap Skill' withArgument: innerWikitextArgument.
	wikitextArgument := WikitextArgument unnamedWithContent: innerWikitextTemplate.
	wikitextTemplate := WikitextTemplate named: 'Cardtable' withArgument: wikitextArgument.

	parsedWikitextTemplate := WikitextParser parse: wikitext.

	self assert: ( parsedWikitextTemplate isEquivalentTo: wikitextTemplate )
]

{ #category : #tests }
WikitextParserTest >> test10ParsingAClosedWikitextWithOneTemplateWithManyArguments [

	| wikitext firstWikitextArgument secondWikitextArgument thirdWikitextArgument fourthWikitextArgument fifthWikitextArgument wikitextTemplate parsedWikitextTemplate |

	wikitext := '{{Cardtable|civilization=Water|engtext={{Tap Skill|Return one of your opponent''s creatures to their hand.}}|Rare|{{Double Breaker}}|type=Creature}}'.

	firstWikitextArgument := WikitextArgument
		named: 'civilization'
		withContent: ( WikitextBasicContent being: 'Water' ).
	secondWikitextArgument := WikitextArgument
		named: 'engtext'
		withContent:
			( WikitextTemplate
				named: 'Tap Skill'
				withArgument:
					( WikitextArgument
						unnamedWithContent: ( WikitextBasicContent being: 'Return one of your opponent''s creatures to their hand.' ) ) ).
	thirdWikitextArgument := WikitextArgument
		unnamedWithContent: ( WikitextBasicContent being: 'Rare' ).
	fourthWikitextArgument := WikitextArgument
		unnamedWithContent: ( WikitextTemplate withoutArgumentsNamed: 'Double Breaker' ).
	fifthWikitextArgument := WikitextArgument
		named: 'type'
		withContent: ( WikitextBasicContent being: 'Creature' ).

	wikitextTemplate := WikitextTemplate
		named: 'Cardtable'
		withArguments:
			( Array
				with: firstWikitextArgument
				with: secondWikitextArgument
				with: thirdWikitextArgument
				with: fourthWikitextArgument
				with: fifthWikitextArgument ).

	parsedWikitextTemplate := WikitextParser parse: wikitext.

	self assert: ( parsedWikitextTemplate isEquivalentTo: wikitextTemplate )
]

{ #category : #tests }
WikitextParserTest >> test11ParsingIgnoresEverythingAfterLastClosedDoubleCurlyBraces [

	| wikitext wikitextTemplate parsedWikitextTemplate |

	wikitext := '{{temp_name|arg_name={{inner_temp_name|inner_basic_content}}|basic_content_2}}[[to_ignore]]'.
	wikitextTemplate := WikitextTemplate
		named: 'temp_name'
		withArguments:
			( Array
				with:
					( WikitextArgument
						named: 'arg_name'
						withContent:
							( WikitextTemplate
								named: 'inner_temp_name'
								withArgument: ( WikitextArgument unnamedWithContent: ( WikitextBasicContent being: 'inner_basic_content' ) ) ) )
				with: ( WikitextArgument unnamedWithContent: ( WikitextBasicContent being: 'basic_content_2' ) ) ).

	parsedWikitextTemplate := WikitextParser parse: wikitext.
	self assert: ( parsedWikitextTemplate isEquivalentTo: wikitextTemplate )
]
