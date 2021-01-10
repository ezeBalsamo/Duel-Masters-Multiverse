"
A WikitextArgumentContentParserTest is a test class for testing the behavior of WikitextArgumentContentParser
"
Class {
	#name : #WikitextContentParserTest,
	#superclass : #TestCase,
	#category : #'Duel-Masters-Plays-Model-Tests'
}

{ #category : #tests }
WikitextContentParserTest >> test01ParsingAWikitextBasicContent [

	| wikitexContentToParse wikitextContentParser parsedWikitextContent expectedWikitextContent |

	wikitexContentToParse := 'basic_content'.

	wikitextContentParser := WikitextContentParser toParse: wikitexContentToParse.
	parsedWikitextContent := wikitextContentParser parse.
	expectedWikitextContent := WikitextBasicContent being: 'basic_content'.

	self
		assert: ( wikitextContentParser isA: WikitextBasicContentParser );
		assert: ( expectedWikitextContent isEquivalentTo: parsedWikitextContent )
]

{ #category : #tests }
WikitextContentParserTest >> test02ParsingAWikitextTemplateAsContentWithoutArguments [

	| wikitexContentToParse wikitextContentParser parsedWikitextContent expectedWikitextContent |

	wikitexContentToParse := '{{inner_temp_name}}'.

	wikitextContentParser := WikitextContentParser toParse: wikitexContentToParse.
	parsedWikitextContent := wikitextContentParser parse.
	expectedWikitextContent := WikitextTemplate withoutArgumentsNamed: 'inner_temp_name'.

	self
		assert: ( wikitextContentParser isA: WikitextTemplateAsContentParser );
		assert: ( expectedWikitextContent isEquivalentTo: parsedWikitextContent )
]

{ #category : #tests }
WikitextContentParserTest >> test03ParsingAWikitextTemplateAsContentWithOneNamedArgumentWithBasicContent [

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
		assert: ( wikitextContentParser isA: WikitextTemplateAsContentParser );
		assert: ( expectedWikitextContent isEquivalentTo: parsedWikitextContent )
]

{ #category : #tests }
WikitextContentParserTest >> test04ParsingAWikitextTemplateAsContentWithOneUnnamedArgumentWithBasicContent [

	| wikitexContentToParse wikitextContentParser parsedWikitextContent expectedWikitextContent |

	wikitexContentToParse := '{{inner_temp_name|basic_content_2}}'.

	wikitextContentParser := WikitextContentParser toParse: wikitexContentToParse.
	parsedWikitextContent := wikitextContentParser parse.
	expectedWikitextContent := WikitextTemplate
		named: 'inner_temp_name'
		withArgument: ( WikitextArgument unnamedWithContent: ( WikitextBasicContent being: 'basic_content_2' ) ).

	self
		assert: ( wikitextContentParser isA: WikitextTemplateAsContentParser );
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
		assert: ( wikitextContentParser isA: WikitextBasicContentParser );
		assert: ( expectedWikitextContent isEquivalentTo: parsedWikitextContent )
]

{ #category : #tests }
WikitextContentParserTest >> test06ParsingTrimmingWhiteSpacesDetectsWikitextTemplateAsContent [

	| wikitexContentToParse wikitextContentParser parsedWikitextContent expectedWikitextContent |

	wikitexContentToParse := ' {{Europika}}
'.

	wikitextContentParser := WikitextContentParser toParse: wikitexContentToParse.
	parsedWikitextContent := wikitextContentParser parse.
	expectedWikitextContent := WikitextTemplate withoutArgumentsNamed: 'Europika'.

	self
		assert: ( wikitextContentParser isA: WikitextTemplateAsContentParser );
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
		assert: ( wikitextContentParser isA: WikitextBasicContentParser );
		assert: ( expectedWikitextContent isEquivalentTo: parsedWikitextContent )
]

{ #category : #tests }
WikitextContentParserTest >> test08ParsingAWikitextMixedContentConformedByTwoWikitextTemplates [

	| wikitexContentToParse wikitextContentParser parsedWikitextContent expectedWikitextContent |

	wikitexContentToParse := '{{Tap Skill|Return one of your opponent''s creatures to their hand.}}{{Double Breaker}}'.

	wikitextContentParser := WikitextContentParser toParse: wikitexContentToParse.
	parsedWikitextContent := wikitextContentParser parse.
	expectedWikitextContent := WikitextMixedContent
		conformedByAll:
			( Array
				with:
					( WikitextTemplate
						named: 'Tap Skill'
						withArgument:
							( WikitextArgument
								unnamedWithContent: ( WikitextBasicContent being: 'Return one of your opponent''s creatures to their hand.' ) ) )
				with: ( WikitextTemplate withoutArgumentsNamed: 'Double Breaker' ) ).

	self
		assert: ( wikitextContentParser isA: WikitextMixedContentParser );
		assert: ( expectedWikitextContent isEquivalentTo: parsedWikitextContent )
]

{ #category : #tests }
WikitextContentParserTest >> test09ParsingTrimsBrTagsAndWhiteSpacesInAWikitextMixedContent [

	| wikitexContentToParse wikitextContentParser parsedWikitextContent expectedWikitextContent |

	wikitexContentToParse := '{{Tap Skill|Return one of your opponent''s creatures to their hand.}} <br> 

{{Double Breaker}}
'.

	wikitextContentParser := WikitextContentParser toParse: wikitexContentToParse.
	parsedWikitextContent := wikitextContentParser parse.
	expectedWikitextContent := WikitextMixedContent
		conformedByAll:
			( Array
				with:
					( WikitextTemplate
						named: 'Tap Skill'
						withArgument:
							( WikitextArgument
								unnamedWithContent: ( WikitextBasicContent being: 'Return one of your opponent''s creatures to their hand.' ) ) )
				with: ( WikitextTemplate withoutArgumentsNamed: 'Double Breaker' ) ).

	self
		assert: ( wikitextContentParser isA: WikitextMixedContentParser );
		assert: ( expectedWikitextContent isEquivalentTo: parsedWikitextContent )
]

{ #category : #tests }
WikitextContentParserTest >> test10ParsingAWikitextBasicContentFromAListedContent [

	| wikitexContentToParse wikitextContentParser parsedWikitextContent expectedWikitextContent |

	wikitexContentToParse := '■ When this enters the [[battle zone]], you may return one of your opponent''s [[creature]]s to their [[hand]].'.

	wikitextContentParser := WikitextContentParser
		toParse: wikitexContentToParse.
	parsedWikitextContent := wikitextContentParser parse.
	expectedWikitextContent := WikitextBasicContent
		being:
			'When this enters the battle zone, you may return one of your opponent''s creatures to their hand.'.

	self
		assert: ( wikitextContentParser isA: WikitextListedContentParser );
		assert: ( expectedWikitextContent isEquivalentTo: parsedWikitextContent )
]

{ #category : #tests }
WikitextContentParserTest >> test11ParsingAWikitextMixedContentConformedByATemplateAndAListedContent [

	| wikitexContentToParse wikitextContentParser parsedWikitextContent expectedWikitextContent |

	wikitexContentToParse := '{{Blocker}}

■ When this enters the [[battle zone]], you may return one of your opponent''s [[creature]]s to their [[hand]].
'.

	wikitextContentParser := WikitextContentParser toParse: wikitexContentToParse.
	parsedWikitextContent := wikitextContentParser parse.
	expectedWikitextContent := WikitextMixedContent
		conformedByAll:
			( Array
				with: ( WikitextTemplate withoutArgumentsNamed: 'Blocker' )
				with:
					( WikitextBasicContent
						being: 'When this enters the battle zone, you may return one of your opponent''s creatures to their hand.' ) ).

	self
		assert: ( wikitextContentParser isA: WikitextMixedContentParser );
		assert: ( expectedWikitextContent isEquivalentTo: parsedWikitextContent )
]

{ #category : #tests }
WikitextContentParserTest >> test12ParsingAWikitextMixedContentConformedByAListedContentAndATemplate [

	| wikitexContentToParse wikitextContentParser parsedWikitextContent expectedWikitextContent |

	wikitexContentToParse := '■ Listed content.{{Blocker}}'.

	wikitextContentParser := WikitextContentParser
		toParse: wikitexContentToParse.
	parsedWikitextContent := wikitextContentParser parse.
	expectedWikitextContent := WikitextMixedContent
		conformedByAll:
			( Array
				with: ( WikitextBasicContent being: 'Listed content.' )
				with: ( WikitextTemplate withoutArgumentsNamed: 'Blocker' ) ).

	self
		assert: ( wikitextContentParser isA: WikitextMixedContentParser );
		assert: ( expectedWikitextContent isEquivalentTo: parsedWikitextContent )
]

{ #category : #tests }
WikitextContentParserTest >> test13ParsingAWikitextBasicContentFromAVariableTemplateAsContentWithThePrefixVariable [

	| wikitexContentToParse wikitextContentParser parsedWikitextContent expectedWikitextContent |

	wikitexContentToParse := '{{Ruby|聖核|せいかく}}の{{Ruby|精霊|せいれい}}ウルセリオス'.

	wikitextContentParser := WikitextContentParser
		toParse: wikitexContentToParse.
	parsedWikitextContent := wikitextContentParser parse.
	expectedWikitextContent := WikitextBasicContent being: '聖核の精霊ウルセリオス'.

	self
		assert: ( wikitextContentParser isA: WikitextVariableTemplateAsContentParser );
		assert: ( expectedWikitextContent isEquivalentTo: parsedWikitextContent )
]

{ #category : #tests }
WikitextContentParserTest >> test14ParsingAWikitextBasicContentFromAVariableTemplateAsContentWithTheSuffixVariable [

	| wikitexContentToParse wikitextContentParser parsedWikitextContent expectedWikitextContent |

	wikitexContentToParse := 'いけにえの{{Ruby|鎖|くさり}}'.

	wikitextContentParser := WikitextContentParser
		toParse: wikitexContentToParse.
	parsedWikitextContent := wikitextContentParser parse.
	expectedWikitextContent := WikitextBasicContent being: 'いけにえの鎖'.

	self
		assert: ( wikitextContentParser isA: WikitextVariableTemplateAsContentParser );
		assert: ( expectedWikitextContent isEquivalentTo: parsedWikitextContent )
]

{ #category : #tests }
WikitextContentParserTest >> test15ParsingAWikitextBasicContentFromAVariableTemplateAsContentWithEverythingBeingVariable [

	| wikitexContentToParse wikitextContentParser parsedWikitextContent expectedWikitextContent |

	wikitexContentToParse := '{{Ruby|自|じ}}{{Ruby|動|どう}}{{Ruby|車|しゃ}}{{Ruby|男|おとこ}}'.

	wikitextContentParser := WikitextContentParser
		toParse: wikitexContentToParse.
	parsedWikitextContent := wikitextContentParser parse.
	expectedWikitextContent := WikitextBasicContent being: '自動車男'.

	self
		assert: ( wikitextContentParser isA: WikitextVariableTemplateAsContentParser );
		assert: ( expectedWikitextContent isEquivalentTo: parsedWikitextContent )
]

{ #category : #tests }
WikitextContentParserTest >> test16ParsingTrimsCurlyBracesFromSearchStringInAWikitextListedContent [

	| wikitexContentToParse wikitextContentParser parsedWikitextContent expectedWikitextContent |

	wikitexContentToParse := '■ When this enters the [[battle zone]], you may {{search}} your [[deck]] for [[spell]]s, reveal one and add it to your [[hand]]. Then [[shuffle]] your [[deck]].'.

	wikitextContentParser := WikitextContentParser toParse: wikitexContentToParse.
	parsedWikitextContent := wikitextContentParser parse.
	expectedWikitextContent := WikitextBasicContent
		being:
			'When this enters the battle zone, you may search your deck for spells, reveal one and add it to your hand. Then shuffle your deck.'.

	self
		assert: ( wikitextContentParser isA: WikitextListedContentParser );
		assert: ( expectedWikitextContent isEquivalentTo: parsedWikitextContent )
]

{ #category : #tests }
WikitextContentParserTest >> test17ParsingPreservesOnlySearchStringFromAWikitextListedContent [

	| wikitexContentToParse wikitextContentParser parsedWikitextContent expectedWikitextContent |

	wikitexContentToParse := '■ {{Search|cap}} your [[deck]] for a [[spell]]. You may reveal one and add it to your [[hand]]. Then [[shuffle]] your [[deck]].'.

	wikitextContentParser := WikitextContentParser toParse: wikitexContentToParse.
	parsedWikitextContent := wikitextContentParser parse.
	expectedWikitextContent := WikitextBasicContent
		being: 'Search your deck for a spell. You may reveal one and add it to your hand. Then shuffle your deck.'.

	self
		assert: ( wikitextContentParser isA: WikitextListedContentParser );
		assert: ( expectedWikitextContent isEquivalentTo: parsedWikitextContent )
]

{ #category : #tests }
WikitextContentParserTest >> test18ParsingTrimsCurlyBracesFromSlayerStringInAWikitextListedContent [

	| wikitexContentToParse wikitextContentParser parsedWikitextContent expectedWikitextContent |

	wikitexContentToParse := '■ One of your [[creature]]s gets "{{Slayer|no}}" until the end of the turn.'.

	wikitextContentParser := WikitextContentParser toParse: wikitexContentToParse.
	parsedWikitextContent := wikitextContentParser parse.
	expectedWikitextContent := WikitextBasicContent
		being: 'One of your creatures gets Slayer until the end of the turn.'.

	self
		assert: ( wikitextContentParser isA: WikitextListedContentParser );
		assert: ( expectedWikitextContent isEquivalentTo: parsedWikitextContent )
]
