function [imout] = getTemplate(im, x, y, r)
    if y-r < 0
        imout = ones(2*r+1,2*r+1);
    end
    if x-r < 0
        imout = ones(2*r+1,2*r+1);
    end
    im = im([y-r:y+r],[x-r:x+r]);
    %imtool(im);
    imout = im;
