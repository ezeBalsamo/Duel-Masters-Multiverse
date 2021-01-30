"
A WikitextArgumentsSplitterTest is a test class for testing the behavior of WikitextArgumentsSplitter
"
Class {
	#name : #WikitextArgumentsSplitterTest,
	#superclass : #TestCase,
	#category : #'DMP-Wikitext-Parsing-Model-Tests'
}

{ #category : #tests }
WikitextArgumentsSplitterTest >> test01SplittingAnEmptyWikitextArgumentShouldRaiseParsingFailed [

	self
		should: [ WikitextArgumentsSplitter splitting: '' ]
		raise: ParsingFailed
		withMessageText: #'A collection of wikitext arguments to split was expected'
]

{ #category : #tests }
WikitextArgumentsSplitterTest >> test02SplittingTwoNamedWikitextArgumentsWithBasicContent [

	| wikitextArgumentToSplit wikitextArgumentsSplitted |

	wikitextArgumentToSplit := 'arg_name_1=basic_content_1|arg_name_2=basic_content_2'.

	wikitextArgumentsSplitted := ( WikitextArgumentsSplitter splitting: wikitextArgumentToSplit ) split.

	self
		assert: wikitextArgumentsSplitted size equals: 2;
		assert: wikitextArgumentsSplitted first equals: 'arg_name_1=basic_content_1';
		assert: wikitextArgumentsSplitted second equals: 'arg_name_2=basic_content_2'
]

{ #category : #tests }
WikitextArgumentsSplitterTest >> test03SplittingNamedWikitextArgumentWithBasicContentFromNamedWikitextArgumentWithWikitextContentWithNamedWikitextArgumentWithBasicContent [

	| wikitextArgumentToSplit wikitextArgumentsSplitted |

	wikitextArgumentToSplit := 'arg_name_1=basic_content_1|arg_name_2={{inner_temp_name|inner_arg_name_3=basic_content_3}}'.

	wikitextArgumentsSplitted := ( WikitextArgumentsSplitter splitting: wikitextArgumentToSplit ) split.

	self
		assert: wikitextArgumentsSplitted size equals: 2;
		assert: wikitextArgumentsSplitted first equals: 'arg_name_1=basic_content_1';
		assert: wikitextArgumentsSplitted second
			equals: 'arg_name_2={{inner_temp_name|inner_arg_name_3=basic_content_3}}'
]

{ #category : #tests }
WikitextArgumentsSplitterTest >> test04SplittingNamedWikitextArgumentWithWikitextContentWithoutArgumentsFromNamedWikitextArgumentWithBasicContent [

	| wikitextArgumentToSplit wikitextArgumentsSplitted |

	wikitextArgumentToSplit := 'arg_name_1={{inner_temp_name}}|arg_name_2=basic_content_2'.

	wikitextArgumentsSplitted := ( WikitextArgumentsSplitter splitting: wikitextArgumentToSplit ) split.

	self
		assert: wikitextArgumentsSplitted size equals: 2;
		assert: wikitextArgumentsSplitted first equals: 'arg_name_1={{inner_temp_name}}';
		assert: wikitextArgumentsSplitted second equals: 'arg_name_2=basic_content_2'
]

{ #category : #tests }
WikitextArgumentsSplitterTest >> test05SplittingNamedWikitextArgumentWithWikitextContentWithNamedWikitextArgumentWithBasicContentFromNamedWikitextArgumentWithBasicContent [

	| wikitextArgumentToSplit wikitextArgumentsSplitted |

	wikitextArgumentToSplit := 'arg_name_1={{inner_temp_name|inner_arg_name_2=basic_content_2}}|arg_name_3=basic_content_3'.

	wikitextArgumentsSplitted := ( WikitextArgumentsSplitter splitting: wikitextArgumentToSplit ) split.

	self
		assert: wikitextArgumentsSplitted size equals: 2;
		assert: wikitextArgumentsSplitted first
			equals: 'arg_name_1={{inner_temp_name|inner_arg_name_2=basic_content_2}}';
		assert: wikitextArgumentsSplitted second equals: 'arg_name_3=basic_content_3'
]

{ #category : #tests }
WikitextArgumentsSplitterTest >> test06SplittingNamedWikitextArgumentWithWikitextContentWithNamedWikitextArgumentWithBasicContentFromSplittingMixedContent [

	| wikitextArgumentToSplit wikitextArgumentsSplitted |

	wikitextArgumentToSplit := 'arg_name_1={{inner_temp_name|inner_arg_name_2=basic_content_2}}|{{inner_temp_name_2|inner_arg_name_3}}{{inner_temp_name_3}}'.

	wikitextArgumentsSplitted := ( WikitextArgumentsSplitter splitting: wikitextArgumentToSplit ) split.

	self
		assert: wikitextArgumentsSplitted size equals: 2;
		assert: wikitextArgumentsSplitted first
			equals: 'arg_name_1={{inner_temp_name|inner_arg_name_2=basic_content_2}}';
		assert: wikitextArgumentsSplitted second
			equals: '{{inner_temp_name_2|inner_arg_name_3}}{{inner_temp_name_3}}'
]

{ #category : #tests }
WikitextArgumentsSplitterTest >> test07SplittingANonFullyClosedWikitextArgumentsShouldRaiseParsingFailedError [

	self
		should: [ ( WikitextArgumentsSplitter splitting: '{{Double Breaker' ) split ]
		raise: ParsingFailed
		withMessageText: #'The arguments were not splitted and merged correctly.'
]

{ #category : #tests }
WikitextArgumentsSplitterTest >> test08SplittingNamedWikitextArgumentWithMixedContentTrimsWhiteSpaces [

	| wikitextArgumentToSplit wikitextArgumentsSplitted |

	wikitextArgumentToSplit := 'engtext = {{Tap Skill|Return one of your opponent''s creatures to their hand.}}{{Double Breaker}}
'.

	wikitextArgumentsSplitted := ( WikitextArgumentsSplitter splitting: wikitextArgumentToSplit ) split.

	self
		withTheOnlyOneIn: wikitextArgumentsSplitted
		do: [ :wikitextArgumentSplitted | 
			self
				assert: wikitextArgumentSplitted
				equals: 'engtext = {{Tap Skill|Return one of your opponent''s creatures to their hand.}}{{Double Breaker}}
'
			]
]

{ #category : #tests }
WikitextArgumentsSplitterTest >> test09SplittingNamedWikitextArgumentWithMixedContentConformedByTwoTemplatesAndOneHavingArguments [

	| wikitextArgumentToSplit wikitextArgumentsSplitted |

	wikitextArgumentToSplit := 'engtext = {{Tap Skill|Return one of your opponent''s creatures to their hand.}}{{Double Breaker}}'.

	wikitextArgumentsSplitted := ( WikitextArgumentsSplitter splitting: wikitextArgumentToSplit ) split.

	self
		withTheOnlyOneIn: wikitextArgumentsSplitted
		do: [ :wikitextArgumentSplitted | 
			self
				assert: wikitextArgumentSplitted
				equals: 'engtext = {{Tap Skill|Return one of your opponent''s creatures to their hand.}}{{Double Breaker}}'
			]
]

{ #category : #tests }
WikitextArgumentsSplitterTest >> test10SplittingNamedWikitextArgumentWithMixedContentConformedByTwoTemplatesBothHavingArguments [

	| wikitextArgumentToSplit wikitextArgumentsSplitted |

	wikitextArgumentToSplit := 'engtext = {{Tap Skill|Return one of your opponent''s creatures to their hand.|jp}}{{Double Breaker|jp}}'.

	wikitextArgumentsSplitted := ( WikitextArgumentsSplitter splitting: wikitextArgumentToSplit ) split.

	self
		withTheOnlyOneIn: wikitextArgumentsSplitted
		do: [ :wikitextArgumentSplitted | 
			self
				assert: wikitextArgumentSplitted
				equals:
					'engtext = {{Tap Skill|Return one of your opponent''s creatures to their hand.|jp}}{{Double Breaker|jp}}'
			]
]

{ #category : #tests }
WikitextArgumentsSplitterTest >> test11SplittingNamedWikitextArgumentWithMixedContentConformedByTwoTemplatesBothHavingArgumentsAndOneHavingAnInnerTemplateWithOneArgument [

	| wikitextArgumentToSplit wikitextArgumentsSplitted |

	wikitextArgumentToSplit := 'engtext = {{first_temp_name|{{inner_temp_name|inner_temp_argument}}|first_temp_argument}}{{second_temp_name|second_temp_argument}}'.

	wikitextArgumentsSplitted := ( WikitextArgumentsSplitter
		splitting: wikitextArgumentToSplit ) split.

	self
		withTheOnlyOneIn: wikitextArgumentsSplitted
		do: [ :wikitextArgumentSplitted | 
			self
				assert: wikitextArgumentSplitted
				equals:
					'engtext = {{first_temp_name|{{inner_temp_name|inner_temp_argument}}|first_temp_argument}}{{second_temp_name|second_temp_argument}}'
			]
]
