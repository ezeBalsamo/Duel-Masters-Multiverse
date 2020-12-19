"
A WikitextTemplateTest is a test class for testing the behavior of WikitextTemplate
"
Class {
	#name : #WikitextTemplateTest,
	#superclass : #TestCase,
	#category : #'Duel-Masters-Plays-Model-Tests'
}

{ #category : #tests }
WikitextTemplateTest >> test01WikitextTemplateWithZeroArguments [

	| templateName wikitextTemplate |

	templateName := 'Cardtable'.
	wikitextTemplate := WikitextTemplate named: templateName withArguments: #().

	self
		assert: ( wikitextTemplate isNamed: templateName );
		deny: wikitextTemplate hasArguments
]

{ #category : #tests }
WikitextTemplateTest >> test02WikitextTemplateWithOneNamedArgument [

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

{ #category : #tests }
WikitextTemplateTest >> test03WikitextTemplateWithOneUnnamedArgument [

	| templateName argumentContent wikitextArgument wikitextTemplate |

	templateName := 'Cardtable'.
	argumentContent := 'Water'.
	wikitextArgument := WikitextArgument unnamedWithContent: argumentContent.
	wikitextTemplate := WikitextTemplate named: templateName withArgument: wikitextArgument.

	self
		assert: ( wikitextTemplate isNamed: templateName );
		assert: ( wikitextTemplate hasUnnamedArgumentWithContent: argumentContent )
]

{ #category : #tests }
WikitextTemplateTest >> test04WikitextTemplateWithManyArguments [

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
WikitextTemplateTest >> test05WikitextTemplateCantHaveMoreThanOneUnnamedArgumentsWithSameContent [

	| templateName commonContent firstWikitextArgument secondWikitextArgument thirdWikitextArgument |

	templateName := 'Cardtable'.
	commonContent := 'commonContent'.
	firstWikitextArgument := WikitextArgument unnamedWithContent: 'Water'.
	secondWikitextArgument := WikitextArgument unnamedWithContent: commonContent.
	thirdWikitextArgument := WikitextArgument unnamedWithContent: commonContent.

	self
		should: [ WikitextTemplate
				named: templateName
				withArguments: ( Array with: firstWikitextArgument with: secondWikitextArgument with: thirdWikitextArgument )
			]
		raise: InstanceCreationFailed
		withMessageText: 'Wikitext Template can''t have more than one unnamed argument with the same content.'
]

{ #category : #tests }
WikitextTemplateTest >> test06WikitextTemplateCantHaveArgumentsWithSameNameAndDifferentContent [

	| templateName commonArgumentName firstWikitextArgument secondWikitextArgument thirdWikitextArgument |

	templateName := 'Cardtable'.

	commonArgumentName := 'commonArgumentName'.
	firstWikitextArgument := WikitextArgument named: 'civilization' content: 'Water'.
	secondWikitextArgument := WikitextArgument named: commonArgumentName content: 'Creature'.
	thirdWikitextArgument := WikitextArgument named: commonArgumentName content: 'Rare'.

	self
		should: [ WikitextTemplate
				named: templateName
				withArguments: ( Array with: firstWikitextArgument with: secondWikitextArgument with: thirdWikitextArgument )
			]
		raise: InstanceCreationFailed
		withMessageText: 'Wikitext Template can''t have more than one argument with the same name.'
]

{ #category : #tests }
WikitextTemplateTest >> test07WikitextTemplateIsEquivalentToAnotherWhenTheyHaveTheSameNameAndTheSameArguments [

	| templateName wikitextArgument wikitextTemplate anotherWikitextTemplate |

	templateName := 'Cardtable'.
	wikitextArgument := WikitextArgument named: 'civilization' content: 'Water'.
	wikitextTemplate := WikitextTemplate named: templateName withArgument: wikitextArgument.
	anotherWikitextTemplate := WikitextTemplate named: templateName withArgument: wikitextArgument.

	self assert: ( wikitextTemplate isEquivalentTo: anotherWikitextTemplate )
]

{ #category : #tests }
WikitextTemplateTest >> test08WikitextTemplateIsNotEquivalentToAnotherWhenTheArgumentsOfTheFirstAndIncludedInTheArgumentsOfTheSecond [

	| templateName firstWikitextArgument secondWikitextArgument wikitextTemplate anotherWikitextTemplate |

	templateName := 'Cardtable'.
	firstWikitextArgument := WikitextArgument named: 'civilization' content: 'Water'.
	secondWikitextArgument := WikitextArgument named: 'type' content: 'Creature'.

	wikitextTemplate := WikitextTemplate named: templateName withArgument: firstWikitextArgument.
	anotherWikitextTemplate := WikitextTemplate
		named: templateName
		withArguments: ( Array with: firstWikitextArgument with: secondWikitextArgument ).

	self deny: ( wikitextTemplate isEquivalentTo: anotherWikitextTemplate )
]

{ #category : #tests }
WikitextTemplateTest >> test09WikitextTemplateIsNotEquivalentToAnotherWhenTheyHaveDifferentName [

	| templateName anotherTemplateName wikitextArgument wikitextTemplate anotherWikitextTemplate |

	templateName := 'Cardtable'.
	anotherTemplateName := 'Another cardtable'.
	wikitextArgument := WikitextArgument named: 'civilization' content: 'Water'.
	wikitextTemplate := WikitextTemplate named: templateName withArgument: wikitextArgument.
	anotherWikitextTemplate := WikitextTemplate
		named: anotherTemplateName
		withArgument: wikitextArgument.

	self deny: ( wikitextTemplate isEquivalentTo: anotherWikitextTemplate )
]
