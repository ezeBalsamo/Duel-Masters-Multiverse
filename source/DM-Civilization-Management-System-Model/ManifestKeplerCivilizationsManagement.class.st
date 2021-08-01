Class {
	#name : #ManifestKeplerCivilizationsManagement,
	#superclass : #PackageManifest,
	#category : #'DM-Civilization-Management-System-Model-Manifest'
}

{ #category : #'class initialization' }
ManifestKeplerCivilizationsManagement class >> initialize [

	<ignoreForCoverage>
	Kepler
		registerInterfaceAt: #CivilizationManagementSystemInterface
		named: 'Civilization Management System Interface'
		declaring:
			#(#purgeCivilization: #storeCivilization: #updateCivilization:with: #civilizations #withCivilizationNamed:do:else: #fireCivilization #lightCivilization #natureCivilization #waterCivilization #darknessCivilization)
]
