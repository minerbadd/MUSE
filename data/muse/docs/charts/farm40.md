--:~ ":" <- **Chart 40 Block Farm Pens, Crops, Cane, and Tree Fields, and Fences** -> muse/docs/charts/farm40.md    
--:+ _Executing a `chart` commnd naming this file creates `ranges` to place and orient a `farm` in Minecraft coordinates._    
--:+ _The second argument of the command names the farm's corner `point` that will include a `fields` feature._  

--:# **chart farm40 corner toward top ends? treeFarmRows?? -> _Bounds and orientation, `ends` extends length in `>` direction._**    
--:+ `corner` _as point name establishes reference point for farm offsets extending from that point in `toward` direction._    
--:+ `toward`: NW (-x, -z>), SE (+x, +z>), SW (-x, +z>), NE (+x, -z>), WN (-z, -x>), ES (+z, +x>), WS (-z, +x>), EN (+z, -x>)    
--:+ `top` _sets the highest point (y-axis) in the farm area for levelling excavations and fills._    
--:+ `ends` (default 18) _indicates where the farm's lengths extend for pens, cane, and the crops and trees fields._    
--:+ `treeFarmRows` (default 2) _controls the area left over for farm crops by limiting the rows of trees._  

--:# **The farm's `fields` feature has keys for ranges setting bounds for the farm's `fields`, `fences`, and `edges`.**    
--:+ _The ranges are animal `pens`, `trees`, sugar `canes`, and other `crops` ranges with `fields` features._    
--:+ _As well as `north`, `east`, and `south` ranges with `fences` features and a `west` side (place holder) `edges` range._    
--:+ _Apply `field` operations defined for a `farm` for` fields` ranges. Build fences with the `fence` command for `fences`._  