# Sketchup Plugin for exporting sizes to xml files

## Warning

The program works only with version 7 (or newer) of the _Sketchup_. If you don't have this version please download it from _Sketchup_ website.

The web version of the _Sketchup_ does not support plugins! You need either _Sketchup_ _Make_ (from 2017) or _Sketchup_ _Pro_.

## Installation

For exporting the models created with _Sketchup_ please follow the steps:

Read the instructions for [installing Ruby Plugins (Extensions)](https://help.sketchup.com/en/extension-warehouse/adding-extensions-sketchup#install-manual) from _Sketchup_ manual.

After installation in _Plugins_ / _Extensions_ menu of the Sketchup you should see a submenu called _Cutting_ _Optimization_ _pro_ _exporter_.

## Requirements

The model must meet some basic requirements:

- Parts must be either of type _Group_ or _ComponentInstance_.

- We dont export faces, simpled edges, etc. For instance, the walls of a locker must be 3D components (or groups) which have _Height_, _Width_ and _Depth_.

- The pieces which are NOT placed parallel with the axes of coordinates must be initially created as _Component_ having the edges parallel with the axes of coordinates and then moved to the new position. If this requirements are not implemented, the size of the pieces will not be correctly exported.

### Examples

An example of a 3D model can be found in [cad examples\furniture.skp](cad%20examples).

Another example with 2 materials can be found [cad examples\furniture_materials.skp](cad%20examples).

## Running

See on [YouTube a movie with the plugin in action](https://www.youtube.com/watch?v=N1040I4CYtE).

1. Load a model (structure) in _Sketchup_.

2. In _Sketchup_ select the _Components_ and _Groups_ of the model that you want to export.

3. Press _Plugins/Extensions_ | _Cutting_ _Optimization_ _pro_ menu from _Sketchup_.

4. You will be asked for various info. If you want to change the language, you must restart the _Sketchup_ for seeing the strings in the new language. Press OK.

5. If the export was successful, then a message will appear that contains the file name and the path where the data have been saved. The file has the same name with the _Sketchup_ file, but with _xml_ extension (which is the native extension for _Cutting_ _Optimization_ _pro_ and _Simple_ _Cutting_ _Software_ _X_ files). The folder where the file is saved is the same with the folder where the _Sketchup_ _skp_ file is located.

6. Now you can load the _xml_ file in _Cutting_ _Optimization_ _pro_ (as _Demand_|_Parts_). You need at least version 5.x of the Cutting Optimization pro. If you have an older version please download the latest one. Any version of _Simple_ _Cutting_ _Software_ _X_ should be able to load the generated _xml_ files.

## More info

[Optimal Programs website](https://optimalprograms.com)
