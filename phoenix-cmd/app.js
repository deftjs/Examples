/*
    This file is generated and updated by Sencha Cmd. You can edit this file as
    needed for your application, but these edits will have to be merged by
    Sencha Cmd when upgrading.
*/

// DO NOT DELETE - this directive is required for Sencha Cmd packages to work.
//@require @packageOverrides

//<debug>
Ext.Loader.setPath({
    'Ext': 'ext/src',
    'Deft': 'packages/deft/src/js',
    'Phoenix': 'app'
});
Ext.syncRequire(['Deft.mixin.Injectable','Deft.mixin.Controllable']);
//</debug>

Ext.application({
    name: 'Phoenix',

    extend: 'Phoenix.Application',
    
    autoCreateViewport: false
});

