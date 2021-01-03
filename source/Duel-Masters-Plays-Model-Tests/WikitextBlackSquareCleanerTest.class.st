"
A WikitextBlackSquareCleanerTest is a test class for testing the behavior of WikitextBlackSquareCleaner
"
Class {
	#name : #WikitextBlackSquareCleanerTest,
	#superclass : #TestCase,
	#category : #'Duel-Masters-Plays-Model-Tests'
}

{ #category : #tests }
WikitextBlackSquareCleanerTest >> test01WhenWikitextToCleanDoesNotHaveBlackSquareItDoesNothing [

	| wikitextToClean wikitextCleaned |

	wikitextToClean := 'clean wikitext'.
	wikitextCleaned := WikitextBlackSquareCleaner new
		clean: wikitextToClean.
	self assert: wikitextCleaned equals: wikitextToClean
]

{ #category : #tests }
WikitextBlackSquareCleanerTest >> test02WhenWikitextToCleanBeginsWithBlackSquareItRemovesIt [

	| wikitextToClean cleanedWikitext expectedCleanedWikitext |

	wikitextToClean := '■ wikitext to clean'.
	cleanedWikitext := WikitextBlackSquareCleaner new
		clean: wikitextToClean.
	expectedCleanedWikitext := ' wikitext to clean'.
	self assert: cleanedWikitext equals: expectedCleanedWikitext
]
