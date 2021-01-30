"
A WikitextConfigurableCleanerTest is a test class for testing the behavior of WikitextConfigurableCleaner
"
Class {
	#name : #WikitextConfigurableCleanerTest,
	#superclass : #TestCase,
	#category : #'DMP-Wikitext-Parsing-Model-Tests'
}

{ #category : #tests }
WikitextConfigurableCleanerTest >> test01WhenConfigurableCleanerIsNotConfiguredItDoesNothing [

	| wikitextToClean wikitextCleaned |

	wikitextToClean := 'clean wikitext'.
	wikitextCleaned := WikitextConfigurableCleaner new
		clean: wikitextToClean.
	self assert: wikitextCleaned equals: wikitextToClean
]

{ #category : #tests }
WikitextConfigurableCleanerTest >> test02CleanerConfiguredWithOneCleaner [

	| wikitextToClean cleanedWikitext expectedCleanedWikitext |

	wikitextToClean := '■ wikitext to clean'.
	cleanedWikitext := WikitextConfigurableCleaner new
		configureBlackSquareCleaner;
		clean: wikitextToClean.
	expectedCleanedWikitext := ' wikitext to clean'.

	self assert: cleanedWikitext equals: expectedCleanedWikitext
]

{ #category : #tests }
WikitextConfigurableCleanerTest >> test03CleanerConfiguredWithManyCleaners [

	| wikitextToClean cleanedWikitext expectedCleanedWikitext |

	wikitextToClean := '■ When this enters the [[battle zone]], you may return one of your opponent''s [[creature]]s to their [[hand]].'.
	cleanedWikitext := WikitextConfigurableCleaner new
		configureBlackSquareCleaner;
		configureWhiteSpacesCleaner;
		configureDoubleSquareBracesCleaner;
		clean: wikitextToClean.
	expectedCleanedWikitext := 'When this enters the battle zone, you may return one of your opponent''s creatures to their hand.'.

	self assert: cleanedWikitext equals: expectedCleanedWikitext
]
