function pcolor_center(x,y,dy,data)

dx = diff(x(1:2)); % Assume the data in x are evenly spaced (lat/lon)
newx = [x - dx/2, x(end) + dx/2]; % new x with one more column

newy = [y - dy/2, y(end) + dy(end)/2]; % new y with one more column

data(end+1, end+1) = NaN ; % add a row+column at the end of original data

pcolor(newx, newy, data)
colorbar
shading flat 
