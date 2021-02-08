"
A DuelMastersInstallationTest is a test class for testing the behavior of DuelMastersInstallation
"
Class {
	#name : #DuelMastersInstallationTest,
	#superclass : #TestCase,
	#category : #'DM-Installation-Model-Tests'
}

{ #category : #'private - asserting' }
DuelMastersInstallationTest >> assert: anInstalledModule isEquivalentToOneIn: anExpectedInstalledModuleClassCollection [

	^ anExpectedInstalledModuleClassCollection
		anySatisfy: [ :moduleClass | anInstalledModule isA: moduleClass ]
]

{ #category : #tests }
DuelMastersInstallationTest >> test01SystemInstallation [

	| installation expectedInstallationName rootSystem installedModuleRegistrationSystem expectedInstalledModuleClasses installedModules |

	installation := DuelMastersInstallation providingInMemoryRepositories.
	expectedInstallationName := 'Duel Masters'.
	rootSystem := installation install.
	rootSystem startUp.

	installedModuleRegistrationSystem := rootSystem >> #InstalledModuleRegistrationSystem.

	expectedInstalledModuleClasses := installation modulesToInstall.
	installedModules := installedModuleRegistrationSystem installedModules.

	self
		assert: rootSystem name equals: expectedInstallationName;
		assert: installation name equals: expectedInstallationName;
		assert: expectedInstalledModuleClasses size equals: installedModules size.

	installedModules
		do:
			[ :installedModule | self assert: installedModule isEquivalentToOneIn: expectedInstalledModuleClasses ]
]

{ #category : #tests }
DuelMastersInstallationTest >> test02ShutdownDoesNothing [

	"This method should be deleted when SystemInstallation>>#beAwareOfShutDownOf: becomes a template method.- ebalsamo"

	DuelMastersInstallation providingInMemoryRepositories beAwareOfShutDownOf: CompositeSystem new.

	self
		assert: ( DuelMastersInstallation compiledMethodAt: #beAwareOfShutDownOf: ) comment
		equals: '"do nothing.- ebalsamo"'
]
