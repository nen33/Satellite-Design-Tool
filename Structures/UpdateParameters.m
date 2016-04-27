function [components,structures, genParameters] = UpdateParameters(components,structures,genParameters)
% Function that expands all the heights of the satellite to the highest height availabe
% for the component.

% Checks to see if this is a stacking satellite or otherwise
[newHeight,i] = max(genParameters.needExpand(:,2));
% At the index of the newest height, see if the newWidth is greater than
% the current width of the satellite's location.
newWidth = genParameters.needExpand(i,3);
% Same for Length.
newLength = genParameters.needExpand(i,4);

if strfind(genParameters.spacecraftType,'Cubesat')
    % If the newHeight to expand to is less than the current top height of
    % the spacecraft, just add another panel
    % Create more panels in which to pack the components on.
    if newHeight >= genParameters.satHeight && newLength >= genParameters.satLength && newWidth >= genParameters.satWidth
        if genParameters.satWidth == .1 && genParameters.satLength == .1 && newHeight <= 0.3
            % If the satellite is a cubesat, expand the satellite up until 3u
            genParameters.satHeight = 0.3;
            genParameters.satLength = 0.2;
            genParameters.satWidth = 0.2;
        else
            fprintf('We can''t make a cubesat bigger than 12u folks')
        end
    elseif newHeight >= genParameters.satHeight && newWidth >= genParameters.satWidth
        if genParameters.satWidth == .1 && genParameters.satLength == .1 && newHeight <= 0.3
            % If the satellite is a cubesat, expand the satellite up until 3u
            genParameters.satHeight = 0.3;
            genParameters.satWidth = 0.2;
        else
            fprintf('We can''t make a cubesat bigger than 12u folks')
        end
    elseif newHeight >= genParameters.satHeight && newLength >= genParameters.satLength
        if genParameters.satWidth == .1 && genParameters.satLength == .1 && newHeight <= 0.3
            % If the satellite is a cubesat, expand the satellite up until 3u
            genParameters.satHeight = 0.3;
            genParameters.satLength = 0.2;
        else
            fprintf('We can''t make a cubesat bigger than 12u folks')
        end
    elseif newHeight >= genParameters.satHeight
        % If the height is more than the current top height of the spacecraft,
        % expand the top height and then create a new panel.
        if genParameters.satWidth == .1 && genParameters.satLength == .1 && newHeight <= 0.3
            % If the satellite is a cubesat, expand the satellite up until 3u
            genParameters.satHeight = genParameters.satHeight + 0.1;
        elseif genParameters.satWidth == .1 && genParameters.satLength == .1 && newHeight == 0.3
            % Else just add an arbitrary height.
            genParameters.satWidth = genParameters.satWidth + .1;
        elseif genParameters.satWidth == .2 && genParameters.satLength == .1 && newHeight == 0.3
            genParameters.satLength = genParameters.satLength + .1;
        else
            fprintf('We can''t make a cubesat bigger than 12u folks')
        end
    end
elseif strfind(genParameters.spacecraftType,'Stacked')

else
    % Expand the structure for any structure that doesn't have mounting
    % panels
    if newHeight >= genParameters.satHeight
        genParameters.satHeight = newHeight;
    end
end
genParameters(:,:).needExpand = 0;