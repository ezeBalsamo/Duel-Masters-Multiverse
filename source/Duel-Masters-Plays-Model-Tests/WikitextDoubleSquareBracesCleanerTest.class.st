"
A WikitextDoubleSquareBracesCleanerTest is a test class for testing the behavior of WikitextDoubleSquareBracesCleaner
"
Class {
	#name : #WikitextDoubleSquareBracesCleanerTest,
	#superclass : #TestCase,
	#category : #'Duel-Masters-Plays-Model-Tests'
}

{ #category : #tests }
WikitextDoubleSquareBracesCleanerTest >> test01WhenWikitextToCleanDoesNotHaveDoubleSquareBracesItDoesNothing [

	| wikitextToClean wikitextCleaned |

	wikitextToClean := 'clean wikitext'.
	wikitextCleaned := WikitextDoubleSquareBracesCleaner new
		clean: wikitextToClean.
	self assert: wikitextCleaned equals: wikitextToClean
]

{ #category : #tests }
WikitextDoubleSquareBracesCleanerTest >> test02WhenWikitextToCleanIncludesDoubleSquareBracesItRemovesThem [

	| wikitextToClean cleanedWikitext expectedCleanedWikitext |

	wikitextToClean := 'When this enters the [[battle zone]], you may return one of your opponent''s [[creature]]s to their [[hand]]'.
	cleanedWikitext := WikitextDoubleSquareBracesCleaner new
		clean: wikitextToClean.
	expectedCleanedWikitext := 'When this enters the battle zone, you may return one of your opponent''s creatures to their hand'.
	self assert: cleanedWikitext equals: expectedCleanedWikitext
]
