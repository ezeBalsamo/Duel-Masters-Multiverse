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
BaselineOfDuelMasters >> baselineNameOf: aDependencyRepresentation [

	^ aDependencyRepresentation at: #baselineName
]

{ #category : #'private - extensions package accessing' }
BaselineOfDuelMasters >> buoyMetaprogrammingExtensionsPackage [

	^ self extensionPackageNamed: 'DM-Buoy-Metaprogramming' requiring: self keplerDependencyName
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

	^ self modelPackageNamed: 'DM-Card' requiring: ( self modelPackageNameFor: 'DM-Race' )
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
				with: ( self testsPackageNameFor: ( self moduleModelPackageNameFor: 'DM-Repository-Provider' ) ) )
]

{ #category : #'private - model package accessing' }
BaselineOfDuelMasters >> civilizationManagementSystemModelPackage [

	^ self
		systemModelPackageNamed: 'DM-Civilization-Management'
		requiringAll:
			( Array
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
				with: 'DM-SUnit'
				with: ( self testsPackageNameFor: ( self systemModelPackageNameFor: 'DM-Repository-Provider' ) )
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

	^ self packageNamesFrom: self dependentSUnitExtensionsPackages
]

{ #category : #'private - dependent sunit packages accessing' }
BaselineOfDuelMasters >> dependentSUnitExtensionsPackages [

	^ OrderedCollection
		with:
			( self
				packageNamed: 'DM-SUnit'
				requiringAll:
					( Array
						with: ( self extensionPackageNameFor: 'DM-Collections-Abstract-Base' )
						with: self keplerDependencyName ) )
]

{ #category : #'private - test packages accessing' }
BaselineOfDuelMasters >> dependentSUnitTestsPackage [

	| dependentSUnitPackageName |

	dependentSUnitPackageName := 'DM-SUnit'.
	^ self testsPackageNamed: dependentSUnitPackageName requiring: dependentSUnitPackageName
]

{ #category : #'private - groups set up' }
BaselineOfDuelMasters >> developmentSupportPackageNames [

	^ self packageNamesFrom: self developmentSupportPackages
]

{ #category : #'private - development support packages accessing' }
BaselineOfDuelMasters >> developmentSupportPackages [

	^ OrderedCollection
		  with: ( self packageNamed: 'DM-Development-Support' requiringAll: ( Array with:
					      ( self testsPackageNameFor: ( self modelPackageNameFor: 'DM-Repository-Provider-System' ) )
					      with: ( self modelPackageNameFor: 'DM-Exception' ) ) )
		  with: ( self packageNamed: 'DM-Match-Tests-Support'
				    requiringAll: ( Array with: ( self modelPackageNameFor: 'DM-Card' )
						      with: ( self modelPackageNameFor: 'DM-Race' )
						      with: ( self modelPackageNameFor: 'DM-Civilization' )
						      with: ( self modelPackageNameFor: 'DM-Match-Request' )
						      with: ( self modelPackageNameFor: 'DM-Match' )
						      with: ( self modelPackageNameFor: 'DM-Step' ) ) )
]

{ #category : #'private - test packages accessing' }
BaselineOfDuelMasters >> developmentSupportTestsPackage [

	| transitiveRequirements |

	transitiveRequirements := Array
		with: ( self testsPackageNameFor: ( self systemModelPackageNameFor: 'DM-Repository-Provider' ) )
		with: ( self modelPackageNameFor: 'DM-Exception' ).

	^ self
		testsPackageNamed: 'DM-Development-Support'
		requiringAll:
			( OrderedCollection new
				add: 'DM-Development-Support';
				add: 'DM-SUnit';
				add: ( self testsPackageNameFor: ( self systemModelPackageNameFor: 'DM-Civilization-Management' ) );
				add: ( self extensionPackageNameFor: 'DM-Transcript-Core-Base' );
				add: ( self extensionPackageNameFor: 'DM-Transcript-NonInteractive-Base' );
				add: ( self extensionPackageNameFor: 'DM-Buoy-Metaprogramming' );
				addAll: transitiveRequirements;
				yourself )
]

{ #category : #'private - model package accessing' }
BaselineOfDuelMasters >> exceptionModelPackage [

	^ self modelPackageNamed: 'DM-Exception' requiringAll: #()
]

{ #category : #'private - test packages accessing' }
BaselineOfDuelMasters >> exceptionModelTestsPackage [

	| exceptionModelPackageName |

	exceptionModelPackageName := self modelPackageNameFor: 'DM-Exception'.
	^ self
		testsPackageNamed: exceptionModelPackageName
		requiringAll: ( Array with: self keplerDependencyName with: exceptionModelPackageName )
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

	^ self packageNamesFrom: self extensionPackages
]

{ #category : #'private - extensions package accessing' }
BaselineOfDuelMasters >> extensionPackages [

	^ OrderedCollection new
		add: self buoyMetaprogrammingExtensionsPackage;
		add: self collectionsStringsBaseExtensionsPackage;
		add: self collectionsAbstractBaseExtensionsPackage;
		add: self toolDependencyAnalyserCoreExtensionsPackage;
		add: self saganExtensionsPackage;
		add: self kernelBasicObjectsExtensionsPackage;
		add: self transcriptCoreBaseExtensionsPackage;
		add: self transcriptNonInteractiveBaseExtensionsPackage;
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
				with: ( self moduleModelPackageNameFor: 'DM-Repository-Provider' )
				with: ( self moduleModelPackageNameFor: 'DM-Card' ) )
]

{ #category : #'private - test packages accessing' }
BaselineOfDuelMasters >> installationModelTestsPackage [

	| installationModelPackageName |

	installationModelPackageName := self modelPackageNameFor: 'DM-Installation'.
	^ self testsPackageNamed: installationModelPackageName requiring: installationModelPackageName
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
BaselineOfDuelMasters >> matchModelPackage [

	^ self
		modelPackageNamed: 'DM-Match'
		requiringAll:
			( Array
				with: ( self modelPackageNameFor: 'DM-Exception' )
				with: ( self modelPackageNameFor: 'DM-Card' )
				with: ( self modelPackageNameFor: 'DM-Step' )
				with: ( self modelPackageNameFor: 'DM-Request' ) )
]

{ #category : #'private - test packages accessing' }
BaselineOfDuelMasters >> matchModelTestsPackage [

	| matchModelPackageName |

	matchModelPackageName := self modelPackageNameFor: 'DM-Match'.
	^ self testsPackageNamed: matchModelPackageName requiringAll: ( OrderedCollection new
			    add: matchModelPackageName;
			    add: 'DM-SUnit';
			    add: ( self modelPackageNameFor: 'DM-Step' );
			    add: ( self modelPackageNameFor: 'DM-Card' );
			    add: ( self modelPackageNameFor: 'DM-Exception' );
			    add: 'DM-Match-Tests-Support';
			    add: ( self systemModelPackageNameFor: 'DM-Civilization-Management' );
			    add:
				    ( self testsPackageNameFor: ( self systemModelPackageNameFor: 'DM-Repository-Provider' ) );
			    yourself )
]

{ #category : #'private - model package accessing' }
BaselineOfDuelMasters >> matchRequestModelPackage [

	^ self 
		modelPackageNamed: 'DM-Match-Request'
		requiringAll: ( 
			Array
				with: ( self modelPackageNameFor: 'DM-Player-Action-Descriptions' )
				with: ( self modelPackageNameFor: 'DM-Request' )
				with: ( self modelPackageNameFor: 'DM-Match' ) )
]

{ #category : #'private - test packages accessing' }
BaselineOfDuelMasters >> matchRequestModelTestsPackage [

	| matchModelPackageName |

	matchModelPackageName := self modelPackageNameFor: 'DM-Match-Request'.
	^ self testsPackageNamed: matchModelPackageName requiringAll: ( OrderedCollection new
			    add: matchModelPackageName;
			    add: 'DM-SUnit';
			    add: ( self modelPackageNameFor: 'DM-Match' );
			    add: ( self modelPackageNameFor: 'DM-Step' );
			    add: ( self modelPackageNameFor: 'DM-Exception' );
			    add: 'DM-Match-Tests-Support';
			    yourself )
]

{ #category : #'private - model package accessing' }
BaselineOfDuelMasters >> metaprogrammingModelPackage [

	^ self
		modelPackageNamed: 'DM-Metaprogramming'
		requiringAll: ( Array with: ( self modelPackageNameFor: 'DM-Exception' ) with: self keplerDependencyName )
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

	^ self packageNamesFrom: self modelPackages
]

{ #category : #'private - model package accessing' }
BaselineOfDuelMasters >> modelPackages [

	^ OrderedCollection new
		  add: self civilizationModelPackage;
		  add: self raceModelPackage;
		  add: self cardModelPackage;
		  add: self playerActionDescriptionsModelPackage;
		  add: self requestModelPackage;
		  add: self matchRequestModelPackage;
		  add: self stepModelPackage;
		  add: self matchModelPackage;
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

{ #category : #'private - groups set up' }
BaselineOfDuelMasters >> packageNamesFrom: aPackageRepresentationCollection [

	^ aPackageRepresentationCollection
		collect: [ :aPackageRepresentation | self packageNameOf: aPackageRepresentation ]
]

{ #category : #'private - packages set up' }
BaselineOfDuelMasters >> packages [

	^ OrderedCollection new
		addAll: self modelPackages;
		addAll: self extensionPackages;
		addAll: self developmentSupportPackages;
		addAll: self dependentSUnitExtensionsPackages;
		addAll: self testPackages;
		yourself
]

{ #category : #'private - model package accessing' }
BaselineOfDuelMasters >> playerActionDescriptionsModelPackage [

	^ self modelPackageNamed: 'DM-Player-Action-Descriptions' requiringAll: #(  )
]

{ #category : #'private - test packages accessing' }
BaselineOfDuelMasters >> playerActionDescriptionsModelTestsPackage [

	| modelPackageName |

	modelPackageName := self modelPackageNameFor: 'DM-Player-Action-Descriptions'.
	^ self testsPackageNamed: modelPackageName requiring: modelPackageName
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

	^ self modelPackageNamed: 'DM-Race' requiring: self keplerDependencyName
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
		requiring: repositoryProviderModuleModelPackageName
]

{ #category : #'private - model package accessing' }
BaselineOfDuelMasters >> repositoryProviderSystemModelPackage [

	^ self systemModelPackageNamed: 'DM-Repository-Provider' requiring: self saganDependencyName
]

{ #category : #'private - test packages accessing' }
BaselineOfDuelMasters >> repositoryProviderSystemModelTestsPackage [

	| repositoryProviderPackageName |

	repositoryProviderPackageName := 'DM-Repository-Provider'.
	^ self
		testsPackageNamed: ( self systemModelPackageNameFor: repositoryProviderPackageName )
		requiringAll: ( Array with: 'DM-SUnit' with: ( self moduleModelPackageNameFor: repositoryProviderPackageName ) )
]

{ #category : #'private - model package accessing' }
BaselineOfDuelMasters >> requestModelPackage [

	^ self modelPackageNamed: 'DM-Request' requiringAll: #(  )
]

{ #category : #'private - packages set up' }
BaselineOfDuelMasters >> requirementNamesOf: aPackageRepresentation [

	^ aPackageRepresentation at: #requirementNames
]

{ #category : #'private - dependencies accessing' }
BaselineOfDuelMasters >> saganDependency [

	^ self
		dependencyTo: self saganDependencyName
		hostedIn: 'github://ba-st/Sagan:v5.0.4/source'
		loadingAll: #('Deployment' 'PostgreSQL')
]

{ #category : #'private - dependencies accessing' }
BaselineOfDuelMasters >> saganDependencyName [

	^ #Sagan
]

{ #category : #'private - extensions package accessing' }
BaselineOfDuelMasters >> saganExtensionsPackage [

	^ self
		extensionPackageNamed: 'DM-Sagan'
		requiringAll: ( Array with: self saganDependencyName with: self keplerDependencyName )
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
		group: 'Tools' with: self developmentSupportPackageNames;
		group: 'Dependent-SUnit-Extensions' with: self dependentSUnitExtensionsPackageNames;
		group: 'CI' with: 'Tests';
		group: 'Development' with: #('Tools' 'Tests')
]

{ #category : #'private - packages set up' }
BaselineOfDuelMasters >> setUpPackagesIn: aSpec [

	self packages do: [ :package | self configure: package asPackageIn: aSpec ]
]

{ #category : #'private - model package accessing' }
BaselineOfDuelMasters >> stepModelPackage [

	^ self modelPackageNamed: 'DM-Step'
		  requiring: ( self modelPackageNameFor: 'DM-Player-Action-Descriptions' )
]

{ #category : #'private - dependencies accessing' }
BaselineOfDuelMasters >> superluminalDependency [

	^ self
		dependencyTo: self superluminalDependencyName
		hostedIn: 'github://ba-st/Superluminal:v2.2.0/source'
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

	^ self packageNamesFrom: self testPackages
]

{ #category : #'private - test packages accessing' }
BaselineOfDuelMasters >> testPackages [

	^ OrderedCollection new
		  add: self civilizationModelTestsPackage;
		  add: self raceModelTestsPackage;
		  add: self cardModelTestsPackage;
		  add: self playerActionDescriptionsModelTestsPackage;
		  add: self matchRequestModelTestsPackage;
		  add: self matchModelTestsPackage;
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
		  add: self toolDependencyAnalyserCoreExtensionsTestsPackage;
		  add: self developmentSupportTestsPackage;
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

{ #category : #'private - test packages accessing' }
BaselineOfDuelMasters >> toolDependencyAnalyserCoreExtensionsTestsPackage [

	| toolDependencyAnalyzerCoreExtensionsPackage |

	toolDependencyAnalyzerCoreExtensionsPackage := self
		extensionPackageNameFor: 'DM-Tool-DependencyAnalyser-Core'.
	^ self
		testsPackageNamed: toolDependencyAnalyzerCoreExtensionsPackage
		requiringAll: ( Array with: toolDependencyAnalyzerCoreExtensionsPackage with: self keplerDependencyName )
]

{ #category : #'private - extensions package accessing' }
BaselineOfDuelMasters >> transcriptCoreBaseExtensionsPackage [

	^ self extensionPackageNamed: 'DM-Transcript-Core-Base' requiringAll: #()
]

{ #category : #'private - extensions package accessing' }
BaselineOfDuelMasters >> transcriptNonInteractiveBaseExtensionsPackage [

	^ self extensionPackageNamed: 'DM-Transcript-NonInteractive-Base' requiringAll: #()
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
