"
A WikitextArgumentParserTest is a test class for testing the behavior of WikitextArgumentParser
"
Class {
	#name : #WikitextArgumentParserTest,
	#superclass : #TestCase,
	#category : #'Duel-Masters-Plays-Model-Tests'
}

{ #category : #tests }
WikitextArgumentParserTest >> test01ParsingANamedWikitextArgumentWithBasicContent [

	| wikitextArgumentToParse wikitextArgumentParser parsedWikitextArgument expectedWikitextArgument |

	wikitextArgumentToParse := 'civilization=Water'.

	wikitextArgumentParser := WikitextArgumentParser toParse: wikitextArgumentToParse.
	parsedWikitextArgument := wikitextArgumentParser parse.
	expectedWikitextArgument := WikitextArgument
		named: 'civilization'
		content: ( WikitextBasicContent being: 'Water' ).

	self
		assert: ( wikitextArgumentParser isA: NamedWikitextArgumentParser );
		assert: ( expectedWikitextArgument isEquivalentTo: parsedWikitextArgument )
]

{ #category : #tests }
WikitextArgumentParserTest >> test02ParsingAnUnamedWikitextArgumentWithBasicContent [

	| wikitextArgumentToParse wikitextArgumentParser parsedWikitextArgument expectedWikitextArgument |

	wikitextArgumentToParse := 'Return one of your opponent''s creatures to their hand.'.

	wikitextArgumentParser := WikitextArgumentParser toParse: wikitextArgumentToParse.
	parsedWikitextArgument := wikitextArgumentParser parse.
	expectedWikitextArgument := WikitextArgument
		unnamedWithContent: ( WikitextBasicContent being: wikitextArgumentToParse ).

	self
		assert: ( wikitextArgumentParser isAn: UnnamedWikitextArgumentWithBasicContentParser );
		assert: ( expectedWikitextArgument isEquivalentTo: parsedWikitextArgument )
]

{ #category : #tests }
WikitextArgumentParserTest >> test03ParsingANamedWikitextArgumentWithWikitextContentWithoutArguments [

	| wikitextArgumentToParse wikitextArgumentParser parsedWikitextArgument expectedWikitextArgument |

	wikitextArgumentToParse := 'arg_name={{inner_temp_name}}'.

	wikitextArgumentParser := WikitextArgumentParser toParse: wikitextArgumentToParse.
	parsedWikitextArgument := wikitextArgumentParser parse.
	expectedWikitextArgument := WikitextArgument
		named: 'arg_name'
		content: ( WikitextTemplate withoutArgumentsNamed: 'inner_temp_name' ).

	self
		assert: ( wikitextArgumentParser isA: NamedWikitextArgumentParser );
		assert: ( expectedWikitextArgument isEquivalentTo: parsedWikitextArgument )
]

{ #category : #tests }
WikitextArgumentParserTest >> test04ParsingANamedWikitextArgumentWithWikitextContentWithOneNamedArgumentWithBasicContent [

	| wikitextArgumentToParse wikitextArgumentParser parsedWikitextArgument expectedWikitextArgument |

	wikitextArgumentToParse := 'arg_name={{inner_temp_name|inner_arg_name_2=basic_content_2}}'.

	wikitextArgumentParser := WikitextArgumentParser toParse: wikitextArgumentToParse.
	parsedWikitextArgument := wikitextArgumentParser parse.
	expectedWikitextArgument := WikitextArgument
		named: 'arg_name'
		content:
			( WikitextTemplate
				named: 'inner_temp_name'
				withArgument:
					( WikitextArgument
						named: 'inner_arg_name_2'
						content: ( WikitextBasicContent being: 'basic_content_2' ) ) ).

	self
		assert: ( wikitextArgumentParser isA: NamedWikitextArgumentParser );
		assert: ( expectedWikitextArgument isEquivalentTo: parsedWikitextArgument )
]
