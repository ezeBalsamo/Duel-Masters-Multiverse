"
A MultipleTemplateContentSplitterTest is a test class for testing the behavior of MultipleTemplateContentSplitter
"
Class {
	#name : #MultipleTemplateContentSplitterTest,
	#superclass : #TestCase,
	#category : #'Duel-Masters-Plays-Model-Tests'
}

{ #category : #tests }
MultipleTemplateContentSplitterTest >> test01SplittingAnEmptyMultipleWikitextTemplateShouldRaiseParsingFailed [

	self
		should: [ MultipleTemplateContentSplitter splitting: '' ]
		raise: ParsingFailed
		withMessageText: #'A collection of wikitext templates to split was expected'
]

{ #category : #tests }
MultipleTemplateContentSplitterTest >> test02SplittingTwoANamedWithoutArgumentsTemplateFromAnUnamedTemplateWithBasicContent [

	| wikitextTemplatesToSplit wikitextTemplatesSplitted |

	wikitextTemplatesToSplit := '{{Blocker}}■ When this enters the [[battle zone]], you may return one of your opponent''s [[creature]]s to their [[hand]].'.

	wikitextTemplatesSplitted := ( MultipleTemplateContentSplitter splitting: wikitextTemplatesToSplit )
		split.

	self
		assert: wikitextTemplatesSplitted size equals: 2;
		assert: wikitextTemplatesSplitted first equals: '{{Blocker}}';
		assert: wikitextTemplatesSplitted second
			equals:
			'■ When this enters the [[battle zone]], you may return one of your opponent''s [[creature]]s to their [[hand]].'
]
