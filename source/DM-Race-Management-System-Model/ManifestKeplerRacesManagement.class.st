Class {
	#name : #ManifestKeplerRacesManagement,
	#superclass : #PackageManifest,
	#category : #'DM-Race-Management-System-Model-Manifest'
}

{ #category : #'class initialization' }
ManifestKeplerRacesManagement class >> initialize [

	<ignoreForCoverage>
	Kepler
		registerInterfaceAt: #RaceManagementSystemInterface
		named: 'Race Management System Interface'
		declaring: #(#name)
]
