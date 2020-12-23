"
A WikitextArgumentContentParserTest is a test class for testing the behavior of WikitextArgumentContentParser
"
Class {
	#name : #WikitextContentParserTest,
	#superclass : #TestCase,
	#category : #'Duel-Masters-Plays-Model-Tests'
}

{ #category : #tests }
WikitextContentParserTest >> test01ParsingABasicContent [

	| wikitexContentToParse wikitextContentParser parsedWikitextContent expectedWikitextContent |

	wikitexContentToParse := 'basic_content'.

	wikitextContentParser := WikitextContentParser toParse: wikitexContentToParse.
	parsedWikitextContent := wikitextContentParser parse.
	expectedWikitextContent := WikitextBasicContent being: 'basic_content'.

	self
		assert: ( wikitextContentParser isA: BasicContentParser );
		assert: ( expectedWikitextContent isEquivalentTo: parsedWikitextContent )
]

{ #category : #tests }
WikitextContentParserTest >> test02ParsingAWikitextContentWithoutArguments [

	| wikitexContentToParse wikitextContentParser parsedWikitextContent expectedWikitextContent |

	wikitexContentToParse := '{{inner_temp_name}}'.

	wikitextContentParser := WikitextContentParser toParse: wikitexContentToParse.
	parsedWikitextContent := wikitextContentParser parse.
	expectedWikitextContent := WikitextTemplate withoutArgumentsNamed: 'inner_temp_name'.

	self
		assert: ( wikitextContentParser isA: TemplateContentParser );
		assert: ( expectedWikitextContent isEquivalentTo: parsedWikitextContent )
]

{ #category : #tests }
WikitextContentParserTest >> test03ParsingAWikitextContentWithOneNamedArgumentWithBasicContent [

	| wikitextContentToParse wikitextContentParser parsedWikitextContent expectedWikitextContent |

	wikitextContentToParse := '{{inner_temp_name|inner_arg_name_2=basic_content_2}}'.

	wikitextContentParser := WikitextContentParser toParse: wikitextContentToParse.
	parsedWikitextContent := wikitextContentParser parse.
	expectedWikitextContent := WikitextTemplate
		named: 'inner_temp_name'
		withArgument:
			( WikitextArgument
				named: 'inner_arg_name_2'
				withContent: ( WikitextBasicContent being: 'basic_content_2' ) ).

	self
		assert: ( wikitextContentParser isA: TemplateContentParser );
		assert: ( expectedWikitextContent isEquivalentTo: parsedWikitextContent )
]

{ #category : #tests }
WikitextContentParserTest >> test04ParsingAWikitextContentWithOneUnnamedArgumentWithBasicContent [

	| wikitexContentToParse wikitextContentParser parsedWikitextContent expectedWikitextContent |

	wikitexContentToParse := '{{inner_temp_name|basic_content_2}}'.

	wikitextContentParser := WikitextContentParser toParse: wikitexContentToParse.
	parsedWikitextContent := wikitextContentParser parse.
	expectedWikitextContent := WikitextTemplate
		named: 'inner_temp_name'
		withArgument: ( WikitextArgument unnamedWithContent: ( WikitextBasicContent being: 'basic_content_2' ) ).

	self
		assert: ( wikitextContentParser isA: TemplateContentParser );
		assert: ( expectedWikitextContent isEquivalentTo: parsedWikitextContent )
]

{ #category : #tests }
WikitextContentParserTest >> test05ParsingTrimmingWhiteSpacesDetectsBasicContent [

	| wikitexContentToParse wikitextContentParser parsedWikitextContent expectedWikitextContent |

	wikitexContentToParse := ' Europika
'.

	wikitextContentParser := WikitextContentParser toParse: wikitexContentToParse.
	parsedWikitextContent := wikitextContentParser parse.
	expectedWikitextContent := WikitextBasicContent being: 'Europika'.

	self
		assert: ( wikitextContentParser isA: BasicContentParser );
		assert: ( expectedWikitextContent isEquivalentTo: parsedWikitextContent )
]

{ #category : #tests }
WikitextContentParserTest >> test06ParsingTrimmingWhiteSpacesDetectsWikitextContent [

	| wikitexContentToParse wikitextContentParser parsedWikitextContent expectedWikitextContent |

	wikitexContentToParse := ' {{Europika}}
'.

	wikitextContentParser := WikitextContentParser toParse: wikitexContentToParse.
	parsedWikitextContent := wikitextContentParser parse.
	expectedWikitextContent := WikitextTemplate withoutArgumentsNamed: 'Europika'.

	self
		assert: ( wikitextContentParser isA: TemplateContentParser );
		assert: ( expectedWikitextContent isEquivalentTo: parsedWikitextContent )
]

{ #category : #tests }
WikitextContentParserTest >> test07ParsingABasicContentDeletesLinksReferences [

	| wikitexContentToParse wikitextContentParser parsedWikitextContent expectedWikitextContent |

	wikitexContentToParse := 'Return one of your opponent''s [[creature]]s to their [[hand]].'.

	wikitextContentParser := WikitextContentParser toParse: wikitexContentToParse.
	parsedWikitextContent := wikitextContentParser parse.
	expectedWikitextContent := WikitextBasicContent
		being: 'Return one of your opponent''s creatures to their hand.'.

	self
		assert: ( wikitextContentParser isA: BasicContentParser );
		assert: ( expectedWikitextContent isEquivalentTo: parsedWikitextContent )
]
