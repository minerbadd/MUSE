--:~ field.plot() <- **Create and Harvest Crop Fields, Water Strips Every Eight Blocks** -> muse/docs/fields/crop.md    
--:+ _Loaded by `field.make` with operation name, span of plots for the operation, and points bounding field._    
--:+ **Supported operations are `quarry`, `layer`, `finish`, `harvest`, `path`, and `test`**    
--:+ _Calls `field.plot` with the specified field operation function and all the field's plots for that operation._    
--:+ _Operation functions call `field.plan` with plot bounds, xyz offset, and the prototype plan for the operation._    
--:+ _Plots other than 1 block wide `harvest` plots are 8 blocks wide along east-west axis with water assumed on either side._  