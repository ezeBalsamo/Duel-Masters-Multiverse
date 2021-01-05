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
WikitextMixedContentSplitterTest >> test03SplittingTwoListedBasicContents [

	| wikitextTemplatesToSplit wikitextTemplatesSplitted |

	wikitextTemplatesToSplit := '■ First listed basic content.■ Second listed basic content.'.

	wikitextTemplatesSplitted := ( WikitextMixedContentSplitter
		splitting: wikitextTemplatesToSplit ) split.

	self
		assert: wikitextTemplatesSplitted size equals: 2;
		assert: wikitextTemplatesSplitted first
			equals: '■ First listed basic content.';
		assert: wikitextTemplatesSplitted second
			equals: '■ Second listed basic content.'
]

{ #category : #tests }
WikitextMixedContentSplitterTest >> test04SplittingWikitextTemplateFromAListedBasicContent [

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
WikitextMixedContentSplitterTest >> test05SplittingListedBasicContentFromAWikitextTemplate [

	| wikitextTemplatesToSplit wikitextTemplatesSplitted |

	wikitextTemplatesToSplit := '■ Listed basic content.{{Double Breaker}}'.

	wikitextTemplatesSplitted := ( WikitextMixedContentSplitter
		splitting: wikitextTemplatesToSplit ) split.

	self
		assert: wikitextTemplatesSplitted size equals: 2;
		assert: wikitextTemplatesSplitted first
			equals: '■ Listed basic content.';
		assert: wikitextTemplatesSplitted second
			equals: '{{Double Breaker}}'
]

{ #category : #tests }
WikitextMixedContentSplitterTest >> test06SplittingAWikitextTemplateFromAListedBasicContentFromAWikitextTemplate [

	| wikitextTemplatesToSplit wikitextTemplatesSplitted |

	wikitextTemplatesToSplit := '{{Blocker}}■ Listed basic content.{{Double Breaker}}'.

	wikitextTemplatesSplitted := ( WikitextMixedContentSplitter
		splitting: wikitextTemplatesToSplit ) split.

	self
		assert: wikitextTemplatesSplitted size equals: 3;
		assert: wikitextTemplatesSplitted first equals: '{{Blocker}}';
		assert: wikitextTemplatesSplitted second
			equals: '■ Listed basic content.';
		assert: wikitextTemplatesSplitted third
			equals: '{{Double Breaker}}'
]

{ #category : #tests }
WikitextMixedContentSplitterTest >> test07SplittingAListedBasicContentFromAWikitextTemplateFromAListedBasicContent [

	| wikitextTemplatesToSplit wikitextTemplatesSplitted |

	wikitextTemplatesToSplit := '■ Listed basic content.{{Double Breaker}}■ Another Listed basic content.'.

	wikitextTemplatesSplitted := ( WikitextMixedContentSplitter
		splitting: wikitextTemplatesToSplit ) split.

	self
		assert: wikitextTemplatesSplitted size equals: 3;
		assert: wikitextTemplatesSplitted first
			equals: '■ Listed basic content.';
		assert: wikitextTemplatesSplitted second
			equals: '{{Double Breaker}}';
		assert: wikitextTemplatesSplitted third
			equals: '■ Another Listed basic content.'
]

{ #category : #tests }
WikitextMixedContentSplitterTest >> test08SplittingAListedBasicContentFromAnotherListedBasicContentFromAWikitextTemplate [

	| wikitextTemplatesToSplit wikitextTemplatesSplitted |

	wikitextTemplatesToSplit := '■ Listed basic content.■ Another Listed basic content.{{Double Breaker}}'.

	wikitextTemplatesSplitted := ( WikitextMixedContentSplitter
		splitting: wikitextTemplatesToSplit ) split.

	self
		assert: wikitextTemplatesSplitted size equals: 3;
		assert: wikitextTemplatesSplitted first
			equals: '■ Listed basic content.';
		assert: wikitextTemplatesSplitted second
			equals: '■ Another Listed basic content.';
		assert: wikitextTemplatesSplitted third
			equals: '{{Double Breaker}}'
]

{ #category : #tests }
WikitextMixedContentSplitterTest >> test09SplittingAWikitextTemplateFromAnotherWikitextTemplateFromAListedBasicContent [

	| wikitextTemplatesToSplit wikitextTemplatesSplitted |

	wikitextTemplatesToSplit := '{{Blocker}}{{Double Breaker}}■ Listed basic content.'.

	wikitextTemplatesSplitted := ( WikitextMixedContentSplitter
		splitting: wikitextTemplatesToSplit ) split.

	self
		assert: wikitextTemplatesSplitted size equals: 3;
		assert: wikitextTemplatesSplitted first equals: '{{Blocker}}';
		assert: wikitextTemplatesSplitted second
			equals: '{{Double Breaker}}';
		assert: wikitextTemplatesSplitted third
			equals: '■ Listed basic content.'
]
