"
A WikitextArgumentsSplitterTest is a test class for testing the behavior of WikitextArgumentsSplitter
"
Class {
	#name : #WikitextArgumentsSplitterTest,
	#superclass : #TestCase,
	#category : #'Duel-Masters-Plays-Model-Tests'
}

{ #category : #tests }
WikitextArgumentsSplitterTest >> test01SplittingTwoNamedWikitextArgumentsWithBasicContent [

	| wikitextArgumentToSplit wikitextArgumentsSplitted |

	wikitextArgumentToSplit := 'arg_name_1=basic_content_1|arg_name_2=basic_content_2'.

	wikitextArgumentsSplitted := ( WikitextArgumentsSplitter splitting: wikitextArgumentToSplit ) split.

	self
		assert: wikitextArgumentsSplitted size equals: 2;
		assert: wikitextArgumentsSplitted first equals: 'arg_name_1=basic_content_1';
		assert: wikitextArgumentsSplitted second equals: 'arg_name_2=basic_content_2'
]

{ #category : #tests }
WikitextArgumentsSplitterTest >> test02SplittingNamedWikitextArgumentWithBasicContentFromUnnamedWikitextArgumentWithBasicContent [

	| wikitextArgumentToSplit wikitextArgumentsSplitted |

	wikitextArgumentToSplit := 'arg_name_1=basic_content_1|basic_content_2'.

	wikitextArgumentsSplitted := ( WikitextArgumentsSplitter splitting: wikitextArgumentToSplit ) split.

	self
		assert: wikitextArgumentsSplitted size equals: 2;
		assert: wikitextArgumentsSplitted first equals: 'arg_name_1=basic_content_1';
		assert: wikitextArgumentsSplitted second equals: 'basic_content_2'
]

{ #category : #tests }
WikitextArgumentsSplitterTest >> test03SplittingTwoUnnamedWikitextArgumentsWithBasicContent [

	| wikitextArgumentToSplit wikitextArgumentsSplitted |

	wikitextArgumentToSplit := 'basic_content_1|basic_content_2'.

	wikitextArgumentsSplitted := ( WikitextArgumentsSplitter splitting: wikitextArgumentToSplit ) split.

	self
		assert: wikitextArgumentsSplitted size equals: 2;
		assert: wikitextArgumentsSplitted first equals: 'basic_content_1';
		assert: wikitextArgumentsSplitted second equals: 'basic_content_2'
]

{ #category : #tests }
WikitextArgumentsSplitterTest >> test04SplittingUnnamedWikitextArgumentWithBasicContentFromNamedWikitextArgumentWithBasicContent [

	| wikitextArgumentToSplit wikitextArgumentsSplitted |

	wikitextArgumentToSplit := 'basic_content_1|arg_name_2=basic_content_2'.

	wikitextArgumentsSplitted := ( WikitextArgumentsSplitter splitting: wikitextArgumentToSplit ) split.

	self
		assert: wikitextArgumentsSplitted size equals: 2;
		assert: wikitextArgumentsSplitted first equals: 'basic_content_1';
		assert: wikitextArgumentsSplitted second equals: 'arg_name_2=basic_content_2'
]

{ #category : #tests }
WikitextArgumentsSplitterTest >> test05SplittingNamedWikitextArgumentWithBasicContentFromNamedWikitextArgumentWithWikitextContentWithoutArguments [

	| wikitextArgumentToSplit wikitextArgumentsSplitted |

	wikitextArgumentToSplit := 'arg_name_1=basic_content_1|arg_name_2={{inner_temp_name}}'.

	wikitextArgumentsSplitted := ( WikitextArgumentsSplitter splitting: wikitextArgumentToSplit ) split.

	self
		assert: wikitextArgumentsSplitted size equals: 2;
		assert: wikitextArgumentsSplitted first equals: 'arg_name_1=basic_content_1';
		assert: wikitextArgumentsSplitted second equals: 'arg_name_2={{inner_temp_name}}'
]

{ #category : #tests }
WikitextArgumentsSplitterTest >> test06SplittingNamedWikitextArgumentWithBasicContentFromNamedWikitextArgumentWithWikitextContentWithNamedWikitextArgumentWithBasicContent [

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
WikitextArgumentsSplitterTest >> test07SplittingNamedWikitextArgumentWithWikitextContentWithoutArgumentsFromNamedWikitextArgumentWithBasicContent [

	| wikitextArgumentToSplit wikitextArgumentsSplitted |

	wikitextArgumentToSplit := 'arg_name_1={{inner_temp_name}}|arg_name_2=basic_content_2'.

	wikitextArgumentsSplitted := ( WikitextArgumentsSplitter splitting: wikitextArgumentToSplit ) split.

	self
		assert: wikitextArgumentsSplitted size equals: 2;
		assert: wikitextArgumentsSplitted first equals: 'arg_name_1={{inner_temp_name}}';
		assert: wikitextArgumentsSplitted second equals: 'arg_name_2=basic_content_2'
]

{ #category : #tests }
WikitextArgumentsSplitterTest >> test08NamedWikitextArgumentWithWikitextContentWithNamedWikitextArgumentWithBasicContentFromSplittingNamedWikitextArgumentWithBasicContent [

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
WikitextArgumentsSplitterTest >> test09SplittingAnEmptyWikitextArgumentShouldRaiseParsingFailed [

	self
		should: [ WikitextArgumentsSplitter splitting: '' ]
		raise: ParsingFailed
		withMessageText: #'A collection of wikitext arguments to split was expected'
]
