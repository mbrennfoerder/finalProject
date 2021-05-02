function [] = trafficData()
global gui; %putting global gui allows for multiple functions instead of everything in one function, this makes things easier to read
gui.vehicle = 0; %This shows that no clicks have been put in yet therefore no vehicle can be selected
gui.fig = figure('numbertitle', 'off', 'name', 'Car Viewing Tracker'); %puts a title on end result
gui.vehicleDisplayMessage = uicontrol('style', 'text', 'units', 'normalized', 'position', [.05 .1 .09 .095], 'string', 'Current number of clicks', 'horizontalalignment', 'right');
gui.reminderDisplayMessage = uicontrol('style', 'text', 'units', 'normalized', 'position', [.05 .5 .8 .1], 'string', 'Reminder number of clicks required on left and the average seen on right of button', 'horizontalalignment', 'right'); %quick reminder on what the numbers on each side of the four buttons mean
gui.vehicleDisplay = uicontrol('style', 'text', 'units', 'normalized', 'position', [.15, .2, .09, .05], 'string', num2str(gui.vehicle), 'horizontalalignment', 'right');
gui.clickerSlot = uicontrol('style', 'pushbutton', 'units', 'normalized', 'position', [.5, .1, .4, .2], 'string', 'Add 1 Click', 'callback', {@addClick,1}); %where clicks are added in order to be able to select a vehicle

%the next four sections are for the four vehicle buttons as well as average
%numbers and the number of clicks required to add them
gui.options(1) = uicontrol('style', 'pushbutton', 'units', 'normalized', 'position', [.55, .76, .12, .05], 'string', 'Truck', 'callback', {@toolResult, 1.5, 1});
gui.average(1) = uicontrol('style', 'text', 'units', 'normalized', 'position', [.9, .75, .05, .05], 'string', '5', 'horizontalalignment', 'right');
gui.price(1) = uicontrol('style', 'text', 'units', 'normalized', 'position', [.48, .76, .05, .05], 'string', '1', 'horizontalalignment', 'right');
gui.averageText(1) = uicontrol('style', 'text', 'units', 'normalized', 'position', [.7, .75, .15, .05], 'string', 'Met Average?', 'horizontalalignment', 'right');

gui.options(2) = uicontrol('style', 'pushbutton', 'units', 'normalized', 'position', [.55, .70, .12, .05], 'string', 'SUV', 'callback', {@toolResult, 1.5, 1});
gui.average(2) = uicontrol('style', 'text', 'units', 'normalized', 'position', [.90, .70, .05, .05], 'string', '3', 'horizontalalignment', 'right');
gui.price(2) = uicontrol('style', 'text', 'units', 'normalized', 'position', [.48, .70, .05, .05], 'string', '2', 'horizontalalignment', 'right');
gui.averageText(2) = uicontrol('style', 'text', 'units', 'normalized', 'position', [.70, .70, .15, .05], 'string', 'Met Average?', 'horizontalalignment', 'right');

gui.options(3) = uicontrol('style', 'pushbutton', 'units', 'normalized', 'position', [.1, .75, .12, .05], 'string', 'Hybrid', 'callback', {@toolResult, 1.5, 1});
gui.average(3) = uicontrol('style', 'text', 'units', 'normalized', 'position', [.27, .75, .18, .05], 'string', '6', 'horizontalalignment', 'right');
gui.price(3) = uicontrol('style', 'text', 'units', 'normalized', 'position', [.0001, .75, .06, .05], 'string', '3', 'horizontalalignment', 'right');
gui.averageText(3) = uicontrol('style', 'text', 'units', 'normalized', 'position', [.25, .75, .15, .05], 'string', 'Met Average?', 'horizontalalignment', 'right');

gui.options(4) = uicontrol('style', 'pushbutton', 'units', 'normalized', 'position', [.1, .70, .12, .05], 'string', 'Biker', 'callback', {@toolResult, 1.5, 1});
gui.average(4) = uicontrol('style', 'text', 'units', 'normalized', 'position', [.27, .70, .18, .05], 'string', '6', 'horizontalalignment', 'right');
gui.price(4) = uicontrol('style', 'text', 'units', 'normalized', 'position', [.0003, .70, .05, .05], 'string', '4', 'horizontalalignment', 'right');
gui.averageText(4) = uicontrol('style', 'text', 'units', 'normalized', 'position', [.25, .70, .15, .05], 'string', 'Met Average?', 'horizontalalignment', 'right');
end

function [] = addClick(source, event, click)
global gui;
gui.vehicle = gui.vehicle + click; %shows that the new gui.vehicle will be 0 plus however many clicks you add
gui.vehicleDisplay.String = ['Clicks: ' num2str(gui.vehicle)];
end

function [] = toolResult(source, event, clicking, index)
global gui;
if gui.vehicle >= clicking && str2double(gui.average(index).String(end)) > 0
    addClick(0,0,-1 * clicking);
    currentAverageNumber = gui.average(index).String(end);
    currentAverageNumber = str2double(currentAverageNumber);
    currentAverageNumber = currentAverageNumber - 1;
    currentAverageNumber = num2str(currentAverageNumber);
    gui.average(index).String = ['Current Stock: ', currentAverageNumber];
    message = ['You have inputted that you have seen a ' source.String]; %This message will show up after the correct number of clicks have been added and the correct vehicle has been selected
    msgbox(message, 'Vehicle Counting Machine Slot', 'modal'); %Title of pop-up above
    
elseif str2double(gui.average(index).String(end)) <= 0
    msgbox('You have met expected value for this vehicle', 'Vehicle Counting Machine Error', 'error', 'modal');
    %This is for when you have seen as many of a certain vehicle as is
    %typically seen in any given day
else
    msgbox('Insufficient clicks', 'Vehicle Counting Machine Error', 'error', 'modal');
    %This is when too few clicks are added for a certain selected vehicle
end
end

function [] = refillVehicles(source, event)
choice = menu('What needs to be allowed more vehicles? (Maximum of 5)', gui.products(1).String);
%For when the average has been met and you are exceeding that value with
%what you are seeing
gui.average(choice).String = 'Current Stock: 5';
end