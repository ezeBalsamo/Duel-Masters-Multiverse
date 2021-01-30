"
A DuelMastersInstallationTest is a test class for testing the behavior of DuelMastersInstallation
"
Class {
	#name : #DuelMastersInstallationTest,
	#superclass : #TestCase,
	#category : #'DM-Installation-Model-Tests'
}

{ #category : #'private - accessing' }
DuelMastersInstallationTest >> modulesEquivalenceComparisonBlock [

	^ [ :anInstalledModule :anExpectedInstalledModule | anInstalledModule isEquivalentTo: anExpectedInstalledModule ]
]

{ #category : #tests }
DuelMastersInstallationTest >> test01SystemInstallation [

	| installation expectedInstallationName rootSystem installedModuleRegistrationSystem expectedInstalledModules |

	installation := DuelMastersInstallation new.
	expectedInstallationName := 'Duel Masters'.
	rootSystem := installation install.
	rootSystem startUp.

	installedModuleRegistrationSystem := rootSystem >> #InstalledModuleRegistrationSystem.
	expectedInstalledModules := installation modulesToInstall.

	self
		assert: rootSystem name equals: expectedInstallationName;
		assert: installation name equals: expectedInstallationName;
		assert: installedModuleRegistrationSystem installedModules
			hasEquivalentElementsThan: expectedInstalledModules
			comparingWith: self modulesEquivalenceComparisonBlock
]
