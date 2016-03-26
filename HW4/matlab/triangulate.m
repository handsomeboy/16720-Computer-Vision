function [ P, error ] = triangulate( M1, p1, M2, p2 )
% triangulate:
%       M1 - 3x4 Camera Matrix 1
%       p1 - Nx2 set of points
%       M2 - 3x4 Camera Matrix 2
%       p2 - Nx2 set of points

% Q2.4 - Todo:
%       Implement a triangulation algorithm to compute the 3d locations
%       See Szeliski Chapter 7 for ideas
%

% pt1 = [p1,ones(size(p1,1),1)];
% pt2 = [p2,ones(size(p2,1),1)];
pt1 = p1;
pt2 = p2;

result = zeros(size(p1,1),4);

for i = 1:size(p1,1)

    sample_pt1 = pt1(i,:);
    sample_pt2 = pt2(i,:);

    A = [sample_pt1(1)*M1(3,:) - M1(1,:);
         sample_pt1(2)*M1(3,:) - M1(2,:);
         sample_pt2(1)*M2(3,:) - M2(1,:);
         sample_pt2(2)*M2(3,:) - M2(2,:)];
    [~,~,V] = svd(A);
    temp = V(:,end);
    temp = temp./temp(4);
    result(i,:) = temp';
end

P = result(:,1:3); 

p1_hat = M1*result';
p2_hat = M2*result';
p1_hat = p1_hat(1:2,:);
p2_hat = p2_hat(1:2,:);
p1_hat = p1_hat';
p2_hat = p2_hat';
dif_p1 = p1_hat - p1;
dif_p2 = p2_hat - p2;
dis_p1 = dif_p1.*dif_p1;
dis_p2 = dif_p2.*dif_p2;
distance = sum(dis_p1) + sum(dis_p2);
distance = sum(distance);
error = distance;

end
