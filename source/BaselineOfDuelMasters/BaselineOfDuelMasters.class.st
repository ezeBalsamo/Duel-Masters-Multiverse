Class {
	#name : #BaselineOfDuelMasters,
	#superclass : #BaselineOf,
	#category : #BaselineOfDuelMasters
}

{ #category : #accessing }
BaselineOfDuelMasters >> baseline: aSpec [

	<baseline>
	aSpec
		for: #pharo
		do: [ self
				setUpDependenciesIn: aSpec;
				setUpPackagesIn: aSpec;
				setUpGroupsIn: aSpec
			]
]

{ #category : #'private - dependencies set up' }
BaselineOfDuelMasters >> baselineNameOf: aDependency [

	^ aDependency at: #baselineName
]

{ #category : #'private - model package accessing' }
BaselineOfDuelMasters >> cardManagementSystemModelPackage [

	^ self systemModelPackageNamed: 'DM-Card-Management' requiring: self keplerDependencyName
]

{ #category : #'private - test packages accessing' }
BaselineOfDuelMasters >> cardManagementSystemModelTestsPackage [

	| cardMagenementSystemModelPackageName |

	cardMagenementSystemModelPackageName := self systemModelPackageNameFor: 'DM-Card-Management'.
	^ self
		testsPackageNamed: cardMagenementSystemModelPackageName
		requiringAll: ( Array with: cardMagenementSystemModelPackageName )
]

{ #category : #'private - model package accessing' }
BaselineOfDuelMasters >> cardModelPackage [

	^ self modelPackageNamed: 'DM-Card' requiringAll: #()
]

{ #category : #'private - test packages accessing' }
BaselineOfDuelMasters >> cardModelTestsPackage [

	| cardModelPackageName |

	cardModelPackageName := self modelPackageNameFor: 'DM-Card'.
	^ self
		testsPackageNamed: cardModelPackageName
		requiringAll:
			( Array
				with: ( self modelPackageNameFor: 'DM-Civilization' )
				with: ( self modelPackageNameFor: 'DM-Race' )
				with: cardModelPackageName )
]

{ #category : #'private - model package accessing' }
BaselineOfDuelMasters >> cardModuleModelPackage [

	^ self
		moduleModelPackageNamed: 'DM-Card'
		requiringAll:
			( Array
				with: self keplerDependencyName
				with: ( self systemModelPackageNameFor: 'DM-Civilization-Management' )
				with: ( self systemModelPackageNameFor: 'DM-Race-Management' )
				with: ( self systemModelPackageNameFor: 'DM-Card-Management' ) )
]

{ #category : #'private - test packages accessing' }
BaselineOfDuelMasters >> cardModuleModelTestsPackage [

	| cardModuleModelPackageName |

	cardModuleModelPackageName := self moduleModelPackageNameFor: 'DM-Card'.
	^ self
		testsPackageNamed: cardModuleModelPackageName
		requiringAll:
			( Array
				with: cardModuleModelPackageName
				with: ( self moduleModelPackageNameFor: 'DM-Repository-Provider' ) )
]

{ #category : #'private - model package accessing' }
BaselineOfDuelMasters >> civilizationManagementSystemModelPackage [

	^ self
		systemModelPackageNamed: 'DM-Civilization-Management'
		requiringAll:
			( Array
				with: self keplerDependencyName
				with: self saganDependencyName
				with: ( self systemModelPackageNameFor: 'DM-Repository-Provider' )
				with: ( self modelPackageNameFor: 'DM-Civilization' ) )
]

{ #category : #'private - test packages accessing' }
BaselineOfDuelMasters >> civilizationManagementSystemModelTestsPackage [

	| civillizationMagenementSystemModelPackageName |

	civillizationMagenementSystemModelPackageName := self
		systemModelPackageNameFor: 'DM-Civilization-Management'.
	^ self
		testsPackageNamed: civillizationMagenementSystemModelPackageName
		requiringAll:
			( Array
				with: ( self testsPackageNameFor: ( self systemModelPackageNameFor: 'DM-Repository-Provider' ) )
				with: self keplerDependencyName
				with: civillizationMagenementSystemModelPackageName
				with: ( self modelPackageNameFor: 'DM-Civilization' ) )
]

{ #category : #'private - model package accessing' }
BaselineOfDuelMasters >> civilizationModelPackage [

	^ self modelPackageNamed: 'DM-Civilization' requiring: ( self extensionPackageNameFor: 'DM-Sagan' )
]

{ #category : #'private - test packages accessing' }
BaselineOfDuelMasters >> civilizationModelTestsPackage [

	| civillizationModelPackageName |

	civillizationModelPackageName := self modelPackageNameFor: 'DM-Civilization'.
	^ self testsPackageNamed: civillizationModelPackageName requiring: civillizationModelPackageName
]

{ #category : #'private - extensions package accessing' }
BaselineOfDuelMasters >> collectionsAbstractBaseExtensionsPackage [

	^ self extensionPackageNamed: 'DM-Collections-Abstract-Base' requiringAll: #()
]

{ #category : #'private - extensions package accessing' }
BaselineOfDuelMasters >> collectionsStringsBaseExtensionsPackage [

	^ self
		extensionPackageNamed: 'DM-Collections-Strings-Base'
		requiring: ( self extensionPackageNameFor: 'DM-Kernel-BasicObjects' )
]

{ #category : #'private - dependencies set up' }
BaselineOfDuelMasters >> configure: aDependency asDependencyIn: aSpec [

	aSpec
		baseline: ( self baselineNameOf: aDependency )
		with: [ aSpec
				repository: ( self repositoryOf: aDependency );
				loads: ( self groupNamesOf: aDependency )
			]
]

{ #category : #'private - packages set up' }
BaselineOfDuelMasters >> configure: aPackage asPackageIn: aSpec [

	aSpec
		package: ( self packageNameOf: aPackage )
		with: [ aSpec requires: ( self requirementNamesOf: aPackage ) ]
]

{ #category : #'private - dependencies accessing' }
BaselineOfDuelMasters >> dependencies [

	^ OrderedCollection new
		add: self superluminalDependency;
		add: self keplerDependency;
		add: self saganDependency;
		yourself
]

{ #category : #'private - dependencies set up' }
BaselineOfDuelMasters >> dependencyTo: aBaselineName hostedIn: aRepository loading: aGroupName [

	^ self dependencyTo: aBaselineName hostedIn: aRepository loadingAll: {aGroupName}
]

{ #category : #'private - dependencies set up' }
BaselineOfDuelMasters >> dependencyTo: aBaselineName hostedIn: aRepository loadingAll: aGroupNameCollection [

	^ Dictionary new
		at: #baselineName put: aBaselineName;
		at: #repository put: aRepository;
		at: #groupNames put: aGroupNameCollection;
		yourself
]

{ #category : #'private - groups set up' }
BaselineOfDuelMasters >> dependentSUnitExtensionsPackageNames [

	^ self dependentSUnitExtensionsPackages
		collect: [ :modelPackage | self packageNameOf: modelPackage ]
]

{ #category : #'private - dependent sunit packages accessing' }
BaselineOfDuelMasters >> dependentSUnitExtensionsPackages [

	^ OrderedCollection
		with:
			( self
				packageNamed: 'DM-SUnit'
				requiring: ( self extensionPackageNameFor: 'DM-Collections-Abstract-Base' ) )
]

{ #category : #'private - test packages accessing' }
BaselineOfDuelMasters >> dependentSUnitTestsPackage [

	| dependentSUnitPackageName |

	dependentSUnitPackageName := 'DM-SUnit'.
	^ self testsPackageNamed: dependentSUnitPackageName requiring: dependentSUnitPackageName
]

{ #category : #'private - model package accessing' }
BaselineOfDuelMasters >> exceptionModelPackage [

	^ self modelPackageNamed: 'DM-Exception' requiringAll: #()
]

{ #category : #'private - test packages accessing' }
BaselineOfDuelMasters >> exceptionModelTestsPackage [

	| exceptionModelPackageName |

	exceptionModelPackageName := self modelPackageNameFor: 'DM-Exception'.
	^ self testsPackageNamed: exceptionModelPackageName requiring: exceptionModelPackageName
]

{ #category : #'private - extensions package accessing' }
BaselineOfDuelMasters >> extensionPackageNameFor: anExtensionPackageName [

	^ '<1s>-Extensions' expandMacrosWith: anExtensionPackageName
]

{ #category : #'private - extensions package accessing' }
BaselineOfDuelMasters >> extensionPackageNamed: anExtensionPackageName requiring: aRequirementName [

	^ self extensionPackageNamed: anExtensionPackageName requiringAll: {aRequirementName}
]

{ #category : #'private - extensions package accessing' }
BaselineOfDuelMasters >> extensionPackageNamed: anExtensionPackageName requiringAll: aRequirementNameCollection [

	^ self
		packageNamed: ( self extensionPackageNameFor: anExtensionPackageName )
		requiringAll: aRequirementNameCollection
]

{ #category : #'private - groups set up' }
BaselineOfDuelMasters >> extensionPackageNames [

	^ self extensionPackages collect: [ :modelPackage | self packageNameOf: modelPackage ]
]

{ #category : #'private - extensions package accessing' }
BaselineOfDuelMasters >> extensionPackages [

	^ OrderedCollection new
		add: self collectionsStringsBaseExtensionsPackage;
		add: self collectionsAbstractBaseExtensionsPackage;
		add: self toolDependencyAnalyserCoreExtensionsPackage;
		add: self saganExtensionsPackage;
		add: self kernelBasicObjectsExtensionsPackage;
		yourself
]

{ #category : #'private - dependencies set up' }
BaselineOfDuelMasters >> groupNamesOf: aDependency [

	^ aDependency at: #groupNames
]

{ #category : #'private - model package accessing' }
BaselineOfDuelMasters >> installationModelPackage [

	^ self
		modelPackageNamed: 'DM-Installation'
		requiringAll:
			( Array
				with: self keplerDependencyName
				with: ( self moduleModelPackageNameFor: 'DM-Repository-Provider' )
				with: ( self moduleModelPackageNameFor: 'DM-Card' ) )
]

{ #category : #'private - test packages accessing' }
BaselineOfDuelMasters >> installationModelTestsPackage [

	| installationModelPackageName |

	installationModelPackageName := self modelPackageNameFor: 'DM-Installation'.
	^ self
		testsPackageNamed: installationModelPackageName
		requiringAll: ( Array with: self keplerDependencyName with: installationModelPackageName )
]

{ #category : #'private - dependencies accessing' }
BaselineOfDuelMasters >> keplerDependency [

	^ self
		dependencyTo: self keplerDependencyName
		hostedIn: 'github://ba-st/Kepler:v5/source'
		loadingAll: #('Extended' 'Dependent-SUnit-Extensions')
]

{ #category : #'private - dependencies accessing' }
BaselineOfDuelMasters >> keplerDependencyName [

	^ #Kepler
]

{ #category : #'private - extensions package accessing' }
BaselineOfDuelMasters >> kernelBasicObjectsExtensionsPackage [

	^ self extensionPackageNamed: 'DM-Kernel-BasicObjects' requiringAll: #()
]

{ #category : #'private - model package accessing' }
BaselineOfDuelMasters >> metaprogrammingModelPackage [

	^ self
		modelPackageNamed: 'DM-Metaprogramming'
		requiring: ( self modelPackageNameFor: 'DM-Exception' )
]

{ #category : #'private - test packages accessing' }
BaselineOfDuelMasters >> metaprogrammingModelTestsPackage [

	| metaprogrammingModelPackageName |

	metaprogrammingModelPackageName := self modelPackageNameFor: 'DM-Metaprogramming'.
	^ self
		testsPackageNamed: metaprogrammingModelPackageName
		requiringAll: ( Array with: ( self modelPackageNameFor: 'DM-Exception' ) with: metaprogrammingModelPackageName )
]

{ #category : #'private - groups set up' }
BaselineOfDuelMasters >> modelAndExtensionPackageNames [

	^ OrderedCollection new
		addAll: self modelPackageNames;
		addAll: self extensionPackageNames;
		yourself
]

{ #category : #'private - model package accessing' }
BaselineOfDuelMasters >> modelPackageNameFor: aModelPackageName [

	^ '<1s>-Model' expandMacrosWith: aModelPackageName
]

{ #category : #'private - model package accessing' }
BaselineOfDuelMasters >> modelPackageNamed: aModelPackageName requiring: aRequirementName [

	^ self modelPackageNamed: aModelPackageName requiringAll: {aRequirementName}
]

{ #category : #'private - model package accessing' }
BaselineOfDuelMasters >> modelPackageNamed: aModelPackageName requiringAll: aRequirementNameCollection [

	^ self
		packageNamed: ( self modelPackageNameFor: aModelPackageName )
		requiringAll: aRequirementNameCollection
]

{ #category : #'private - groups set up' }
BaselineOfDuelMasters >> modelPackageNames [

	^ self modelPackages collect: [ :modelPackage | self packageNameOf: modelPackage ]
]

{ #category : #'private - model package accessing' }
BaselineOfDuelMasters >> modelPackages [

	^ OrderedCollection new
		add: self civilizationModelPackage;
		add: self raceModelPackage;
		add: self cardModelPackage;
		add: self repositoryProviderSystemModelPackage;
		add: self civilizationManagementSystemModelPackage;
		add: self raceManagementSystemModelPackage;
		add: self cardManagementSystemModelPackage;
		add: self cardModuleModelPackage;
		add: self repositoryProviderModuleModelPackage;
		add: self installationModelPackage;
		add: self exceptionModelPackage;
		add: self metaprogrammingModelPackage;
		add: self wikitextParsingModelPackage;
		yourself
]

{ #category : #'private - model package accessing' }
BaselineOfDuelMasters >> moduleModelPackageNameFor: aModuleModelPackageName [

	^ self modelPackageNameFor: ( '<1s>-Module' expandMacrosWith: aModuleModelPackageName )
]

{ #category : #'private - model package accessing' }
BaselineOfDuelMasters >> moduleModelPackageNamed: aModuleModelPackageName requiringAll: aRequirementNameCollection [

	^ self
		packageNamed: ( self moduleModelPackageNameFor: aModuleModelPackageName )
		requiringAll: aRequirementNameCollection
]

{ #category : #'private - packages set up' }
BaselineOfDuelMasters >> packageNameOf: aPackageRepresentation [

	^ aPackageRepresentation at: #packageName
]

{ #category : #'private - packages set up' }
BaselineOfDuelMasters >> packageNamed: aPackageName requiring: aRequirementName [

	^ self packageNamed: aPackageName requiringAll: {aRequirementName}
]

{ #category : #'private - packages set up' }
BaselineOfDuelMasters >> packageNamed: aPackageName requiringAll: aRequirementNameCollection [

	^ Dictionary new
		at: #packageName put: aPackageName;
		at: #requirementNames put: aRequirementNameCollection;
		yourself
]

{ #category : #'private - packages set up' }
BaselineOfDuelMasters >> packages [

	^ OrderedCollection new
		addAll: self modelPackages;
		addAll: self extensionPackages;
		addAll: self dependentSUnitExtensionsPackages;
		addAll: self testPackages;
		yourself
]

{ #category : #accessing }
BaselineOfDuelMasters >> projectClass [

	^ MetacelloCypressBaselineProject
]

{ #category : #'private - model package accessing' }
BaselineOfDuelMasters >> raceManagementSystemModelPackage [

	^ self systemModelPackageNamed: 'DM-Race-Management' requiring: self keplerDependencyName
]

{ #category : #'private - test packages accessing' }
BaselineOfDuelMasters >> raceManagementSystemModelTestsPackage [

	| raceMagenementSystemModelPackageName |

	raceMagenementSystemModelPackageName := self systemModelPackageNameFor: 'DM-Race-Management'.
	^ self
		testsPackageNamed: raceMagenementSystemModelPackageName
		requiringAll: ( Array with: raceMagenementSystemModelPackageName )
]

{ #category : #'private - model package accessing' }
BaselineOfDuelMasters >> raceModelPackage [

	^ self modelPackageNamed: 'DM-Race' requiringAll: #()
]

{ #category : #'private - test packages accessing' }
BaselineOfDuelMasters >> raceModelTestsPackage [

	| raceModelPackageName |

	raceModelPackageName := self modelPackageNameFor: 'DM-Race'.
	^ self testsPackageNamed: raceModelPackageName requiring: raceModelPackageName
]

{ #category : #'private - dependencies set up' }
BaselineOfDuelMasters >> repositoryOf: aDependency [

	^ aDependency at: #repository
]

{ #category : #'private - model package accessing' }
BaselineOfDuelMasters >> repositoryProviderModuleModelPackage [

	^ self
		moduleModelPackageNamed: 'DM-Repository-Provider'
		requiringAll:
			( Array
				with: self keplerDependencyName
				with: self saganDependencyName
				with: ( self systemModelPackageNameFor: 'DM-Repository-Provider' )
				with: ( self extensionPackageNameFor: 'DM-Sagan' ) )
]

{ #category : #'private - test packages accessing' }
BaselineOfDuelMasters >> repositoryProviderModuleModelTestsPackage [

	| repositoryProviderModuleModelPackageName |

	repositoryProviderModuleModelPackageName := self
		moduleModelPackageNameFor: 'DM-Repository-Provider'.
	^ self
		testsPackageNamed: repositoryProviderModuleModelPackageName
		requiringAll: ( Array with: self keplerDependencyName with: repositoryProviderModuleModelPackageName )
]

{ #category : #'private - model package accessing' }
BaselineOfDuelMasters >> repositoryProviderSystemModelPackage [

	^ self
		systemModelPackageNamed: 'DM-Repository-Provider'
		requiringAll: ( Array with: self keplerDependencyName with: self saganDependencyName )
]

{ #category : #'private - test packages accessing' }
BaselineOfDuelMasters >> repositoryProviderSystemModelTestsPackage [

	| repositoryProviderPackageName |

	repositoryProviderPackageName := 'DM-Repository-Provider'.
	^ self
		testsPackageNamed: ( self systemModelPackageNameFor: repositoryProviderPackageName )
		requiringAll:
			( Array
				with: self keplerDependencyName
				with: ( self moduleModelPackageNameFor: repositoryProviderPackageName ) )
]

{ #category : #'private - packages set up' }
BaselineOfDuelMasters >> requirementNamesOf: aPackageRepresentation [

	^ aPackageRepresentation at: #requirementNames
]

{ #category : #'private - dependencies accessing' }
BaselineOfDuelMasters >> saganDependency [

	^ self
		dependencyTo: self saganDependencyName
		hostedIn: 'github://ba-st/Sagan:v4.1.0/source'
		loadingAll: #('Deployment' 'PostgreSQL')
]

{ #category : #'private - dependencies accessing' }
BaselineOfDuelMasters >> saganDependencyName [

	^ #Sagan
]

{ #category : #'private - extensions package accessing' }
BaselineOfDuelMasters >> saganExtensionsPackage [

	^ self extensionPackageNamed: 'DM-Sagan' requiring: self saganDependencyName
]

{ #category : #'private - test packages accessing' }
BaselineOfDuelMasters >> saganExtensionsTestsPackage [

	| saganExtensionsPackageName |

	saganExtensionsPackageName := self extensionPackageNameFor: 'DM-Sagan'.
	^ self testsPackageNamed: saganExtensionsPackageName requiring: saganExtensionsPackageName
]

{ #category : #'private - dependencies set up' }
BaselineOfDuelMasters >> setUpDependenciesIn: spec [

	self dependencies do: [ :dependency | self configure: dependency asDependencyIn: spec ]
]

{ #category : #'private - groups set up' }
BaselineOfDuelMasters >> setUpGroupsIn: aSpec [

	aSpec
		group: 'Deployment' with: self modelAndExtensionPackageNames;
		group: 'Tests' with: self testPackageNames;
		group: 'Dependent-SUnit-Extensions' with: self dependentSUnitExtensionsPackageNames;
		group: 'CI' with: 'Tests';
		group: 'Development' with: 'Tests'
]

{ #category : #'private - packages set up' }
BaselineOfDuelMasters >> setUpPackagesIn: aSpec [

	self packages do: [ :package | self configure: package asPackageIn: aSpec ]
]

{ #category : #'private - dependencies accessing' }
BaselineOfDuelMasters >> superluminalDependency [

	^ self
		dependencyTo: self superluminalDependencyName
		hostedIn: 'github://ba-st/Superluminal:v1.2.0/source'
		loading: 'Core'
]

{ #category : #'private - dependencies accessing' }
BaselineOfDuelMasters >> superluminalDependencyName [

	^ #Superluminal
]

{ #category : #'private - model package accessing' }
BaselineOfDuelMasters >> systemModelPackageNameFor: aSystemModelPackageName [

	^ self modelPackageNameFor: ( '<1s>-System' expandMacrosWith: aSystemModelPackageName )
]

{ #category : #'private - model package accessing' }
BaselineOfDuelMasters >> systemModelPackageNamed: aSystemModelPackageName requiring: aRequirementName [

	^ self systemModelPackageNamed: aSystemModelPackageName requiringAll: {aRequirementName}
]

{ #category : #'private - model package accessing' }
BaselineOfDuelMasters >> systemModelPackageNamed: aSystemModelPackageName requiringAll: aRequirementNameCollection [

	^ self
		packageNamed: ( self systemModelPackageNameFor: aSystemModelPackageName )
		requiringAll: aRequirementNameCollection
]

{ #category : #'private - groups set up' }
BaselineOfDuelMasters >> testPackageNames [

	^ self testPackages collect: [ :modelPackage | self packageNameOf: modelPackage ]
]

{ #category : #'private - test packages accessing' }
BaselineOfDuelMasters >> testPackages [

	^ OrderedCollection new
		add: self civilizationModelTestsPackage;
		add: self raceModelTestsPackage;
		add: self cardModelTestsPackage;
		add: self repositoryProviderSystemModelTestsPackage;
		add: self civilizationManagementSystemModelTestsPackage;
		add: self raceManagementSystemModelTestsPackage;
		add: self cardManagementSystemModelTestsPackage;
		add: self repositoryProviderModuleModelTestsPackage;
		add: self cardModuleModelTestsPackage;
		add: self installationModelTestsPackage;
		add: self exceptionModelTestsPackage;
		add: self metaprogrammingModelTestsPackage;
		add: self wikitextParsingModelTestsPackage;
		add: self dependentSUnitTestsPackage;
		add: self saganExtensionsTestsPackage;
		yourself
]

{ #category : #'private - test packages accessing' }
BaselineOfDuelMasters >> testsPackageNameFor: aTestsPackageName [

	^ '<1s>-Tests' expandMacrosWith: aTestsPackageName
]

{ #category : #'private - test packages accessing' }
BaselineOfDuelMasters >> testsPackageNamed: aTestsPackageName requiring: aRequirementName [

	^ self testsPackageNamed: aTestsPackageName requiringAll: {aRequirementName}
]

{ #category : #'private - test packages accessing' }
BaselineOfDuelMasters >> testsPackageNamed: aTestsPackageName requiringAll: aRequirementNameCollection [

	^ self
		packageNamed: ( self testsPackageNameFor: aTestsPackageName )
		requiringAll: aRequirementNameCollection
]

{ #category : #'private - extensions package accessing' }
BaselineOfDuelMasters >> toolDependencyAnalyserCoreExtensionsPackage [

	^ self extensionPackageNamed: 'DM-Tool-DependencyAnalyser-Core' requiringAll: #()
]

{ #category : #'private - model package accessing' }
BaselineOfDuelMasters >> wikitextParsingModelPackage [

	^ self
		modelPackageNamed: 'DMP-Wikitext-Parsing'
		requiringAll:
			( Array
				with: ( self modelPackageNameFor: 'DM-Metaprogramming' )
				with: ( self extensionPackageNameFor: 'DM-Collections-Strings-Base' ) )
]

{ #category : #'private - test packages accessing' }
BaselineOfDuelMasters >> wikitextParsingModelTestsPackage [

	| wikitextParsingModelPackageName |

	wikitextParsingModelPackageName := self modelPackageNameFor: 'DMP-Wikitext-Parsing'.
	^ self
		testsPackageNamed: wikitextParsingModelPackageName
		requiring: wikitextParsingModelPackageName
]
