# Copyright 2024 Optimal Programs
# Licensed under the MIT license

require 'sketchup.rb'
require 'extensions.rb'

module OptimalPrograms
  module CutProExporter

    unless file_loaded?(__FILE__)
      ex = SketchupExtension.new('Cutting Optimization Pro exporter 1.7.3', 'cut/main')
      ex.description = 'SketchUp Ruby Size Exporter.'
      ex.version     = '1.7.3'
      ex.copyright   = 'Optimal Programs'
      ex.creator     = 'Optimal Programs'
      Sketchup.register_extension(ex, true)
      file_loaded(__FILE__)
    end

  end # module 
end # module 