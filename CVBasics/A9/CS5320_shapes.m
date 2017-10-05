function shapes = CS5320_shapes(segs)
% CS5320_shapes - find triangles and rectangles
% On input:
% segs (segs data structure): segments (see CS5320_line_segs)
% On output:
% shapes (struct vector): shape info
% (s).segs (1xk vector): segment indexes of shape
% currently either 3 (triangle) or 4 (rectangle)
% Call:
% Tt = CS5320_shapes(square);
% Author:
% T. Henderson
% UU
% Spring 2016
%
