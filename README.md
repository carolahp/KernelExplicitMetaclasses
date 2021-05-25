# KernelExplicitMetaclasses
Class and method definitions for a ObjVLisp like kernel with explicit metaclasses, compatible with Pharo 8.0 VM.

```explicitMetaclasses := MExplicitMetaclasses new name: #KernelExplicit; yourself.
explicitMetaclasses loadTonelRepository: './bootstrap/language-definitions-new-repo/KernelExplicitGit/KernelExplicitMetaclasses'.
explicitMetaclasses loadCustomClasses.
explicitMetaclasses test.
explicitMetaclasses prepareBuilder.
explicitMetaclasses spurImage testStub.
"explicitMetaclasses debugCode: explicitMetaclasses hookEntryPoint code."
"objVLisp evaluateLoadingMissingDefinitionsFromPharo: objVLisp hookEntryPoint code."
 "hookEntryPoint code.
objVLisp debugCode: objVLisp hookEntryPoint code. "
"objVLisp evaluateLoadingMissingDefinitionsFromPharo: 'Class start'."
explicitMetaclasses spurImage testStub.
explicitMetaclasses builder installClasses.
explicitMetaclasses builder installMethods.
explicitMetaclasses builder installProcess.
explicitMetaclasses spurImage testClasses.

imageFileObjVlisp := explicitMetaclasses writeImage.
imageFileObjVlisp runBashScript.
```
