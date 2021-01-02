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

	wikitextArgumentToParse := 'arg_name=basic_content'.

	wikitextArgumentParser := WikitextArgumentParser toParse: wikitextArgumentToParse.
	parsedWikitextArgument := wikitextArgumentParser parse.
	expectedWikitextArgument := WikitextArgument
		named: 'arg_name'
		withContent: ( WikitextBasicContent being: 'basic_content' ).

	self
		assert: ( wikitextArgumentParser isA: NamedWikitextArgumentParser );
		assert: ( expectedWikitextArgument isEquivalentTo: parsedWikitextArgument )
]

{ #category : #tests }
WikitextArgumentParserTest >> test02ParsingAnUnamedWikitextArgumentWithBasicContent [

	| wikitextArgumentToParse wikitextArgumentParser parsedWikitextArgument expectedWikitextArgument |

	wikitextArgumentToParse := 'basic_content'.

	wikitextArgumentParser := WikitextArgumentParser toParse: wikitextArgumentToParse.
	parsedWikitextArgument := wikitextArgumentParser parse.
	expectedWikitextArgument := WikitextArgument
		unnamedWithContent: ( WikitextBasicContent being: 'basic_content' ).

	self
		assert: ( wikitextArgumentParser isAn: UnnamedWikitextArgumentParser );
		assert: ( expectedWikitextArgument isEquivalentTo: parsedWikitextArgument )
]

{ #category : #tests }
WikitextArgumentParserTest >> test03ParsingAnUnnamedWikitextArgumentWithWikitextContentWithoutArguments [

	| wikitextArgumentToParse wikitextArgumentParser parsedWikitextArgument expectedWikitextArgument |

	wikitextArgumentToParse := '{{inner_temp_name}}'.

	wikitextArgumentParser := WikitextArgumentParser toParse: wikitextArgumentToParse.
	parsedWikitextArgument := wikitextArgumentParser parse.
	expectedWikitextArgument := WikitextArgument
		unnamedWithContent: ( WikitextTemplate withoutArgumentsNamed: 'inner_temp_name' ).

	self
		assert: ( wikitextArgumentParser isA: UnnamedWikitextArgumentParser );
		assert: ( expectedWikitextArgument isEquivalentTo: parsedWikitextArgument )
]

{ #category : #tests }
WikitextArgumentParserTest >> test04ParsingTrimmingWhiteSpacesDetectsNamedWikitextArgument [

	| wikitextArgumentToParse wikitextArgumentParser parsedWikitextArgument expectedWikitextArgument |

	wikitextArgumentToParse := ' phonetic = Europika
'.

	wikitextArgumentParser := WikitextArgumentParser toParse: wikitextArgumentToParse.
	parsedWikitextArgument := wikitextArgumentParser parse.
	expectedWikitextArgument := WikitextArgument
		named: 'phonetic'
		withContent: ( WikitextBasicContent being: 'Europika' ).

	self
		assert: ( wikitextArgumentParser isA: NamedWikitextArgumentParser );
		assert: ( expectedWikitextArgument isEquivalentTo: parsedWikitextArgument )
]

{ #category : #tests }
WikitextArgumentParserTest >> test05ParsingTrimmingWhiteSpacesDetectsUnnamedWikitextArgumentWithBasicContent [

	| wikitextArgumentToParse wikitextArgumentParser parsedWikitextArgument expectedWikitextArgument |

	wikitextArgumentToParse := '  Europika
'.

	wikitextArgumentParser := WikitextArgumentParser toParse: wikitextArgumentToParse.
	parsedWikitextArgument := wikitextArgumentParser parse.
	expectedWikitextArgument := WikitextArgument
		unnamedWithContent: ( WikitextBasicContent being: 'Europika' ).

	self
		assert: ( wikitextArgumentParser isA: UnnamedWikitextArgumentParser );
		assert: ( expectedWikitextArgument isEquivalentTo: parsedWikitextArgument )
]

{ #category : #tests }
WikitextArgumentParserTest >> test06ParsingTrimmingWhiteSpacesDetectsUnnamedWikitextArgumentWithWikitextContext [

	| wikitextArgumentToParse wikitextArgumentParser parsedWikitextArgument expectedWikitextArgument |

	wikitextArgumentToParse := '  {{Europika}}
'.

	wikitextArgumentParser := WikitextArgumentParser toParse: wikitextArgumentToParse.
	parsedWikitextArgument := wikitextArgumentParser parse.
	expectedWikitextArgument := WikitextArgument
		unnamedWithContent: ( WikitextTemplate withoutArgumentsNamed: 'Europika' ).

	self
		assert: ( wikitextArgumentParser isA: UnnamedWikitextArgumentParser );
		assert: ( expectedWikitextArgument isEquivalentTo: parsedWikitextArgument )
]

{ #category : #tests }
WikitextArgumentParserTest >> test07ParsingANamedArgumentWithDoubleWikitextContext [

	| wikitextArgumentToParse wikitextArgumentParser parsedWikitextArgument expectedWikitextArgument |

	wikitextArgumentToParse := 'engtext={{Tap Skill|Return one of your opponent''s creatures to their hand.}}{{Double Breaker}}'.

	wikitextArgumentParser := WikitextArgumentParser toParse: wikitextArgumentToParse.
	parsedWikitextArgument := wikitextArgumentParser parse.
	expectedWikitextArgument := WikitextArgument
		named: 'engtext'
		withContent:
			( WikitextMixedContent
				conformedByAll:
					( Array
						with:
							( WikitextTemplate
								named: 'Tap Skill'
								withArgument:
									( WikitextArgument
										unnamedWithContent: ( WikitextBasicContent being: 'Return one of your opponent''s creatures to their hand.' ) ) )
						with: ( WikitextTemplate withoutArgumentsNamed: 'Double Breaker' ) ) ).

	self
		assert: ( wikitextArgumentParser isA: NamedWikitextArgumentParser );
		assert: ( expectedWikitextArgument isEquivalentTo: parsedWikitextArgument )
]
