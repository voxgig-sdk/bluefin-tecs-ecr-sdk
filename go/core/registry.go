package core

var UtilityRegistrar func(u *Utility)

var NewBaseFeatureFunc func() Feature

var NewTestFeatureFunc func() Feature

var NewEcrApiEntityFunc func(client *BluefinTecsEcrSDK, entopts map[string]any) BluefinTecsEcrEntity

