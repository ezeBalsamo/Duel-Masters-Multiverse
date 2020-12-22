"
A WikitextArgumentContentParserTest is a test class for testing the behavior of WikitextArgumentContentParser
"
Class {
	#name : #WikitextArgumentContentParserTest,
	#superclass : #TestCase,
	#category : #'Duel-Masters-Plays-Model-Tests'
}

{ #category : #tests }
WikitextArgumentContentParserTest >> test01ParsingABasicContent [

	| wikitexContentToParse wikitextContentParser parsedWikitextContent expectedWikitextContent |

	wikitexContentToParse := 'basic_content'.

	wikitextContentParser := WikitextArgumentContentParser toParse: wikitexContentToParse.
	parsedWikitextContent := wikitextContentParser parse.
	expectedWikitextContent := WikitextBasicContent being: 'basic_content'.

	self
		assert: ( wikitextContentParser isA: WikitextArgumentWithBasicContentParser );
		assert: ( expectedWikitextContent isEquivalentTo: parsedWikitextContent )
]

{ #category : #tests }
WikitextArgumentContentParserTest >> test02ParsingAWikitextContentWithoutArguments [

	| wikitexContentToParse wikitextContentParser parsedWikitextContent expectedWikitextContent |

	wikitexContentToParse := '{{inner_temp_name}}'.

	wikitextContentParser := WikitextArgumentContentParser toParse: wikitexContentToParse.
	parsedWikitextContent := wikitextContentParser parse.
	expectedWikitextContent := WikitextTemplate withoutArgumentsNamed: 'inner_temp_name'.

	self
		assert: ( wikitextContentParser isA: WikitextArgumentWithWikitextContentParser );
		assert: ( expectedWikitextContent isEquivalentTo: parsedWikitextContent )
]

{ #category : #tests }
WikitextArgumentContentParserTest >> test03ParsingAWikitextContentWithOneNamedArgumentWithBasicContent [

	| wikitextContentToParse wikitextContentParser parsedWikitextContent expectedWikitextContent |

	wikitextContentToParse := '{{inner_temp_name|inner_arg_name_2=basic_content_2}}'.

	wikitextContentParser := WikitextArgumentContentParser toParse: wikitextContentToParse.
	parsedWikitextContent := wikitextContentParser parse.
	expectedWikitextContent := WikitextTemplate
		named: 'inner_temp_name'
		withArgument:
			( WikitextArgument
				named: 'inner_arg_name_2'
				withContent: ( WikitextBasicContent being: 'basic_content_2' ) ).

	self
		assert: ( wikitextContentParser isA: WikitextArgumentWithWikitextContentParser );
		assert: ( expectedWikitextContent isEquivalentTo: parsedWikitextContent )
]

{ #category : #tests }
WikitextArgumentContentParserTest >> test04ParsingAWikitextContentWithOneUnnamedArgumentWithBasicContent [

	| wikitexContentToParse wikitextContentParser parsedWikitextContent expectedWikitextContent |

	wikitexContentToParse := '{{inner_temp_name|basic_content_2}}'.

	wikitextContentParser := WikitextArgumentContentParser toParse: wikitexContentToParse.
	parsedWikitextContent := wikitextContentParser parse.
	expectedWikitextContent := WikitextTemplate
		named: 'inner_temp_name'
		withArgument: ( WikitextArgument unnamedWithContent: ( WikitextBasicContent being: 'basic_content_2' ) ).

	self
		assert: ( wikitextContentParser isA: WikitextArgumentWithWikitextContentParser );
		assert: ( expectedWikitextContent isEquivalentTo: parsedWikitextContent )
]
