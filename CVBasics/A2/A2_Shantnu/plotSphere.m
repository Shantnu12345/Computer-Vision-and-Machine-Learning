for i = 1:60
    for j = 1:60
        x(i,j) = i;
        y(i,j) =j;
    end
end

surf(x(:,:),y(:,:),f(:,:));
colormap gray;