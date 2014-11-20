function [ size ] = get_storage( variable )
%GET_STORAGE returns the size of variable in bytes
%   INPUT:
%           variable: variable in whose size we are interested
%   OUTPUT:
%           size: size of variable in bytes
tmp = whos('variable');

size = tmp.bytes;

end

