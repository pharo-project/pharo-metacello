pragma extraction
extractBaselinePragmaFor: aClass
  ^ Pragma allNamed: #'baseline' in: aClass