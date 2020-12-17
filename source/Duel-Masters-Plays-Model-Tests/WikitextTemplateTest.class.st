"
A WikitextTemplateTest is a test class for testing the behavior of WikitextTemplate
"
Class {
	#name : #WikitextTemplateTest,
	#superclass : #TestCase,
	#category : #'Duel-Masters-Plays-Model-Tests'
}

{ #category : #tests }
WikitextTemplateTest >> testWikitextTemplateMustHaveAtLeastOneArgument [

	self
		should: [ WikitextTemplate named: 'Cardtable' withArguments: #() ]
		raise: InstanceCreationFailed
		withMessageText: #'The Template must have at least one argument.'
]

{ #category : #tests }
WikitextTemplateTest >> testWikitextTemplateWithManyArguments [

	| templateName firstArgumentName firstArgumentContent secondArgumentName secondArgumentContent firstWikitextArgument secondWikitextArgument wikitextTemplate |

	templateName := 'Cardtable'.

	firstArgumentName := 'civilization'.
	firstArgumentContent := 'Water'.
	firstWikitextArgument := WikitextArgument named: firstArgumentName content: firstArgumentContent.

	secondArgumentName := 'type'.
	secondArgumentContent := 'Creature'.
	secondWikitextArgument := WikitextArgument named: secondArgumentName content: secondArgumentContent.

	wikitextTemplate := WikitextTemplate
		named: templateName
		withArguments: ( Array with: firstWikitextArgument with: secondWikitextArgument ).

	self
		assert: ( wikitextTemplate isNamed: templateName );
		assert: ( wikitextTemplate hasArgumentNamed: firstArgumentName withContent: firstArgumentContent );
		assert: ( wikitextTemplate hasArgumentNamed: secondArgumentName withContent: secondArgumentContent );
		deny: ( wikitextTemplate hasArgumentNamed: firstArgumentName withContent: secondArgumentContent );
		deny: ( wikitextTemplate hasArgumentNamed: secondArgumentName withContent: firstArgumentContent )
]

{ #category : #tests }
WikitextTemplateTest >> testWikitextTemplateWithOneArgument [

	| templateName argumentName argumentContent wikitextArgument wikitextTemplate |

	templateName := 'Cardtable'.
	argumentName := 'civilization'.
	argumentContent := 'Water'.
	wikitextArgument := WikitextArgument named: argumentName content: argumentContent.
	wikitextTemplate := WikitextTemplate named: templateName withArgument: wikitextArgument.

	self
		assert: ( wikitextTemplate isNamed: templateName );
		assert: ( wikitextTemplate hasArgumentNamed: argumentName withContent: argumentContent )
]
