Name: Varun Sreenivasan
NetID: vsreenivasan

Design Implementation

Part a) The binary image is first computed using im2bw. Then regionprops is used to extract the centroid and the area. This area value is then used to determine the radius.

Part b) From the image, the x and y are known. x and y are transformed so that the origin is the sphere's center. Then, z is determined using the formula r^2 = x^2 + y^2 + z^2.  
        Then a unit vector is obtained by dividing each component (x,y,z) with the magnitude of the radius. 
  
        It is safe to assume that the normal to the brightest spot on the sphere is the direction of the light source because. This is because of the equation corresponding to 
        irradiance E = (J * cos(theta))/r^2 = (J / r^2) * dot_product(unit vector n, unit vector s). This expression is maximum when theta is 0 because the dot product then equals 1.
        Thus the two vectors are parallel to each other and therefore, the normal to the brightest spot on the sphere is in the direction of the light source. 

        In this part, I first determined the brightest point in each sphere, then transformed the corresponding x,y values using the sphere centroid. I then determined the z value
        using the formula mentioned above and then converted it to a unit vector. I then multiplied it with the corresponding intensity value in the image so that length of the
        vector is equal to the intensity. In case of multiple maximas (same maximum brightness), I choose the uppermost pixel and if there are multiple maximas in the uppermost row, 
        I choose the leftmost pixel. 

Part c) The mask at a pixel has a value of 1 if this pixel location corresponds to the vase object in at least one of the five images.

Part d) For each pixel that has a corresponding mask value of 1, I used all 5 light sources to determine ths surface normal and albedo at this pixel. I used the least-squares method.
        I then scaled the albedo to ensure that values are in the 0-1 range. I also then scaled the surface normal vector to ensure it is a unit vector. 
 