"
A MultipleTemplateContentSplitterTest is a test class for testing the behavior of MultipleTemplateContentSplitter
"
Class {
	#name : #WikitextMixedContentSplitterTest,
	#superclass : #TestCase,
	#category : #'Duel-Masters-Plays-Model-Tests'
}

{ #category : #tests }
WikitextMixedContentSplitterTest >> test01SplittingAnEmptyWikitextMixedContentShouldRaiseParsingFailed [

	self
		should: [ WikitextMixedContentSplitter splitting: '' ]
		raise: ParsingFailed
		withMessageText: #'A collection of wikitext contents to split was expected.'
]

{ #category : #tests }
WikitextMixedContentSplitterTest >> test02SplittingTwoWikitextTemplatesClearsBrTags [

	| wikitextTemplatesToSplit wikitextTemplatesSplitted |

	wikitextTemplatesToSplit := '{{Tap Skill|Return one of your opponent''s [[creature]]s to their [[hand]].}} <br>{{Double Breaker}}'.

	wikitextTemplatesSplitted := ( WikitextMixedContentSplitter
		splitting: wikitextTemplatesToSplit ) split.

	self
		assert: wikitextTemplatesSplitted size equals: 2;
		assert: wikitextTemplatesSplitted first
			equals:
			'{{Tap Skill|Return one of your opponent''s [[creature]]s to their [[hand]].}}';
		assert: wikitextTemplatesSplitted second
			equals: '{{Double Breaker}}'
]

{ #category : #tests }
WikitextMixedContentSplitterTest >> test03SplittingTwoListedContents [

	| wikitextTemplatesToSplit wikitextTemplatesSplitted |

	wikitextTemplatesToSplit := '■ First listed content.■ Second listed content.'.

	wikitextTemplatesSplitted := ( WikitextMixedContentSplitter
		splitting: wikitextTemplatesToSplit ) split.

	self
		assert: wikitextTemplatesSplitted size equals: 2;
		assert: wikitextTemplatesSplitted first
			equals: '■ First listed content.';
		assert: wikitextTemplatesSplitted second
			equals: '■ Second listed content.'
]

{ #category : #tests }
WikitextMixedContentSplitterTest >> test04SplittingWikitextTemplateFromAListedContent [

	| wikitextTemplatesToSplit wikitextTemplatesSplitted |

	wikitextTemplatesToSplit := '{{Blocker}}■ When this enters the [[battle zone]], you may return one of your opponent''s [[creature]]s to their [[hand]].'.

	wikitextTemplatesSplitted := ( WikitextMixedContentSplitter splitting: wikitextTemplatesToSplit )
		split.

	self
		assert: wikitextTemplatesSplitted size equals: 2;
		assert: wikitextTemplatesSplitted first equals: '{{Blocker}}';
		assert: wikitextTemplatesSplitted second
			equals:
			'■ When this enters the [[battle zone]], you may return one of your opponent''s [[creature]]s to their [[hand]].'
]

{ #category : #tests }
WikitextMixedContentSplitterTest >> test05SplittingListedContentFromAWikitextTemplate [

	| wikitextTemplatesToSplit wikitextTemplatesSplitted |

	wikitextTemplatesToSplit := '■ Listed content.{{Double Breaker}}'.

	wikitextTemplatesSplitted := ( WikitextMixedContentSplitter
		splitting: wikitextTemplatesToSplit ) split.

	self
		assert: wikitextTemplatesSplitted size equals: 2;
		assert: wikitextTemplatesSplitted first
			equals: '■ Listed content.';
		assert: wikitextTemplatesSplitted second
			equals: '{{Double Breaker}}'
]

{ #category : #tests }
WikitextMixedContentSplitterTest >> test06SplittingAWikitextTemplateFromAListedContentFromAWikitextTemplate [

	| wikitextTemplatesToSplit wikitextTemplatesSplitted |

	wikitextTemplatesToSplit := '{{Blocker}}■ Listed content.{{Double Breaker}}'.

	wikitextTemplatesSplitted := ( WikitextMixedContentSplitter
		splitting: wikitextTemplatesToSplit ) split.

	self
		assert: wikitextTemplatesSplitted size equals: 3;
		assert: wikitextTemplatesSplitted first equals: '{{Blocker}}';
		assert: wikitextTemplatesSplitted second
			equals: '■ Listed content.';
		assert: wikitextTemplatesSplitted third
			equals: '{{Double Breaker}}'
]

{ #category : #tests }
WikitextMixedContentSplitterTest >> test07SplittingAListedContentFromAWikitextTemplateFromAListedContent [

	| wikitextTemplatesToSplit wikitextTemplatesSplitted |

	wikitextTemplatesToSplit := '■ Listed content.{{Double Breaker}}■ Another Listed content.'.

	wikitextTemplatesSplitted := ( WikitextMixedContentSplitter
		splitting: wikitextTemplatesToSplit ) split.

	self
		assert: wikitextTemplatesSplitted size equals: 3;
		assert: wikitextTemplatesSplitted first equals: '■ Listed content.';
		assert: wikitextTemplatesSplitted second
			equals: '{{Double Breaker}}';
		assert: wikitextTemplatesSplitted third
			equals: '■ Another Listed content.'
]

{ #category : #tests }
WikitextMixedContentSplitterTest >> test08SplittingAListedContentFromAnotherListedContentFromAWikitextTemplate [

	| wikitextTemplatesToSplit wikitextTemplatesSplitted |

	wikitextTemplatesToSplit := '■ Listed content.■ Another Listed content.{{Double Breaker}}'.

	wikitextTemplatesSplitted := ( WikitextMixedContentSplitter
		splitting: wikitextTemplatesToSplit ) split.

	self
		assert: wikitextTemplatesSplitted size equals: 3;
		assert: wikitextTemplatesSplitted first equals: '■ Listed content.';
		assert: wikitextTemplatesSplitted second
			equals: '■ Another Listed content.';
		assert: wikitextTemplatesSplitted third
			equals: '{{Double Breaker}}'
]

{ #category : #tests }
WikitextMixedContentSplitterTest >> test09SplittingAWikitextTemplateFromAnotherWikitextTemplateFromAListedContent [

	| wikitextTemplatesToSplit wikitextTemplatesSplitted |

	wikitextTemplatesToSplit := '{{Blocker}}{{Double Breaker}}■ Listed content.'.

	wikitextTemplatesSplitted := ( WikitextMixedContentSplitter
		splitting: wikitextTemplatesToSplit ) split.

	self
		assert: wikitextTemplatesSplitted size equals: 3;
		assert: wikitextTemplatesSplitted first equals: '{{Blocker}}';
		assert: wikitextTemplatesSplitted second
			equals: '{{Double Breaker}}';
		assert: wikitextTemplatesSplitted third equals: '■ Listed content.'
]
